-- Un procedimiento almacenado para registrar una venta.

CREATE OR REPLACE PROCEDURE registrar_venta(p_id_cliente INTEGER, p_productos INTEGER[])
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_transaccion  INTEGER;
    v_prod_id         INTEGER;
    v_stock_actual    INTEGER;
BEGIN
    -- Validar que el cliente exista
    PERFORM 1
    FROM cliente
    WHERE id = p_id_cliente;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Error: Cliente con id % no existe.', p_id_cliente;
    END IF;

    -- Verificar stock para TODOS los productos antes de empezar
    FOREACH v_prod_id IN ARRAY p_productos
    LOOP
        SELECT stock INTO v_stock_actual
        FROM inventario
        WHERE id_producto = v_prod_id
        LIMIT 1;

        IF NOT FOUND THEN
            RAISE NOTICE 'Stock check: Producto id % no existe en inventario.', v_prod_id;
            RETURN;
        ELSIF v_stock_actual < 1 THEN
            RAISE NOTICE 'Stock insuficiente: Producto id %, disponible %.', v_prod_id, v_stock_actual;
            RETURN; 
        END IF;
    END LOOP;

    INSERT INTO transaccion(fecha)
    VALUES (CURRENT_DATE)
    RETURNING id INTO v_id_transaccion;

    -- Insertar detalles y actualizar stock
    FOREACH v_prod_id IN ARRAY p_productos
    LOOP

        SELECT stock INTO v_stock_actual
        FROM inventario
        WHERE id_producto = v_prod_id
        FOR UPDATE;

        INSERT INTO det_transaccion(id_producto, id_transaccion) VALUES (v_prod_id, v_id_transaccion);

        UPDATE inventario SET stock = stock - 1 WHERE id_producto = v_prod_id;
    END LOOP;

    -- Registrar la venta
    INSERT INTO venta(id_cliente, id_transaccion) VALUES (p_id_cliente, v_id_transaccion);

    -- Confirmación
    RAISE NOTICE 'Venta registrada: cliente=%, transacción=%.', p_id_cliente, v_id_transaccion;
END;
$$;