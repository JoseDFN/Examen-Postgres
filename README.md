# Examen-Postgres

## Schema

Visualiza el diagrama aquí [Diagrama](techzone-public.png)

## db

```sql
DROP DATABASE techzone;

CREATE DATABASE techzone;

\c techzone;

DROP TABLE empresa;

CREATE TABLE empresa (
    id serial PRIMARY KEY,
    nombre CHAR (50) NOT NULL,
    nit CHAR(20) NOT NULL,
    telefono CHAR(25) NOT NULL
);

DROP TABLE pais;

CREATE TABLE pais(
    id serial PRIMARY KEY,
    nombre CHAR(50) NOT NULL UNIQUE,
    codigo CHAR(3) NOT NULL UNIQUE
);

DROP TABLE region;

CREATE TABLE region (
    id serial PRIMARY KEY,
    nombre CHAR(45) NOT NULL,
    id_pais INTEGER NOT NULL,
    FOREIGN KEY (id_pais) REFERENCES pais(id)
);

DROP TABLE ciudad;

CREATE TABLE ciudad (
    id serial PRIMARY KEY,
    nombre CHAR(45) NOT NULL,
    id_region INTEGER NOT NULL,
    FOREIGN KEY (id_region) REFERENCES region(id)
);

DROP TABLE direccion;

CREATE TABLE direccion(
    id serial PRIMARY KEY,
    calle CHAR(50),
    carrera CHAR(50),
    avenida CHAR(50),
    id_ciudad INTEGER NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id)
);

DROP TABLE sucursal;

CREATE TABLE sucursal (
    id serial PRIMARY KEY,
    nombre CHAR(100) NOT NULL,
    id_direccion INTEGER NOT NULL,
    id_empresa INTEGER NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id),
    FOREIGN KEY (id_empresa) REFERENCES empresa(id)
);

DROP TABLE entidad;

CREATE TABLE entidad (
    id serial PRIMARY KEY,
    nombre CHAR(100) NOT NULL,
    id_direccion INTEGER NOT NULL,
    telefono CHAR(25),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id)
);

DROP TABLE cliente;

CREATE TABLE cliente(
    id serial PRIMARY KEY,
    id_entidad INTEGER NOT NULL,
    identificacion CHAR(50),
    FOREIGN KEY (id_entidad) REFERENCES entidad(id)
);

DROP TABLE proveedor;

CREATE TABLE proveedor(
    id serial PRIMARY KEY,
    id_entidad INTEGER NOT NULL,
    nit CHAR(50) NOT NULL,
    FOREIGN KEY (id_entidad) REFERENCES entidad(id)
);

DROP TABLE categoria;

CREATE TABLE categoria(
    id serial PRIMARY KEY,
    nombre CHAR(50) NOT NULL,
    descripcion TEXT
);

DROP TABLE producto;

CREATE TABLE producto(
    id serial PRIMARY KEY,
    nombre CHAR(50) NOT NULL,
    descripcion TEXT,
    precio numeric NOT NULL
);

DROP TABLE categoria_producto;

CREATE TABLE categoria_producto(
    id serial PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    id_categoria INTEGER NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id)
);

DROP TABLE proveedor_producto;

CREATE TABLE proveedor_producto(
    id serial PRIMARY KEY,
    id_proveedor INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

DROP TABLE inventario;

CREATE TABLE inventario (
    id serial PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    stock INTEGER DEFAULT 0,
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

DROP TABLE transaccion;

CREATE TABLE transaccion(
    id serial PRIMARY KEY,
    fecha date
);

DROP TABLE det_transaccion;

CREATE TABLE det_transaccion(
    id serial PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    id_transaccion INTEGER NOT NULL,
    FOREIGN KEY (id_transaccion) REFERENCES transaccion(id)
);

DROP TABLE venta;

CREATE TABLE venta(
    id serial PRIMARY KEY,
    id_cliente serial NOT NULL,
    id_transaccion INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_transaccion) REFERENCES transaccion(id)
);

DROP TABLE compra;

CREATE TABLE compra(
    id serial PRIMARY KEY,
    id_proveedor INTEGER NOT NULL,
    id_transaccion INTEGER NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id),
    FOREIGN KEY (id_transaccion) REFERENCES transaccion(id)
);

DROP TABLE historial_compras;

CREATE TABLE historial_compras (
    id serial PRIMARY KEY,
    fecha date NOT NULL,
    id_compra INTEGER NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES compra(id)
);
```

## insert

```sql
INSERT INTO empresa (nombre, nit, telefono) VALUES ('TechZone','58y35298147t51', '656285199');

INSERT INTO pais (nombre, codigo) VALUES ('Colombia', 'CO');

INSERT INTO pais (nombre, codigo) VALUES ('Estados Unidos', 'USA');

INSERT INTO region (nombre, id_pais) VALUES ('Santander', 1);

INSERT INTO region (nombre, id_pais) VALUES ('Florida', 2);

INSERT INTO ciudad (nombre, id_region) VALUES ('Bucaramanga', 1);

INSERT INTO ciudad (nombre, id_region) VALUES ('Miami', 2);

INSERT INTO direccion (calle, carrera, avenida, id_ciudad) VALUES ('CALLE 15', 'CARRERA 18', 'AVENIDA 16', 1);

INSERT INTO direccion (calle, carrera, avenida, id_ciudad) VALUES ('CALLE 23', 'CARRERA 24', 'AVENIDA 2', 1);

INSERT INTO direccion (calle, carrera, avenida, id_ciudad) VALUES ('CALLE 15', 'CARRERA 18', 'AVENIDA 16', 1);

INSERT INTO sucursal (nombre, id_direccion, id_empresa) VALUES ('TechZone BC', 1, 1);

INSERT INTO entidad (nombre, id_direccion, telefono) VALUES ('Pablo', 2, '585728577');

INSERT INTO entidad (nombre, id_direccion, telefono) VALUES ('PARNAM', 3, '587165015');

INSERT INTO cliente (id_entidad, identificacion) VALUES (1, '16548461213546');

INSERT INTO proveedor (id_entidad, nit) VALUES (2, '09987525901-1');

INSERT INTO categoria (nombre, descripcion) VALUES ('computadores', 'gnangjagbjhbgah'), ('telefonos','hnskgldbgagag'), ('electrodomesticos', 'bgbagabkgaga'), ('productividad', 'gnajgajghgbkjaga');

INSERT INTO producto (nombre, descripcion, precio) VALUES ('portatil', 'knkagajgbagjh', 1500), ('celular', 'kgnakgnkjgba', 1000), ('monitor', 'gkbagajgjag', 600);

INSERT INTO categoria_producto (id_producto, id_categoria) VALUES (1,1), (1,4), (2,2), (2,4);

INSERT INTO proveedor_producto (id_proveedor, id_producto) VALUES (1,2), (1,2), (1,3);

INSERT INTO inventario (id_producto, stock) VALUES (1, 50), (2, 15), (3, 10);

INSERT INTO transaccion (fecha) VALUES (NOW()), (NOW());

INSERT INTO det_transaccion (id_producto, id_transaccion) VALUES (1,1), (2,1), (1,1), (2,1);

INSERT INTO venta (id_cliente, id_transaccion) VALUES (1,1);

INSERT INTO det_transaccion (id_producto, id_transaccion) VALUES (1,2), (2,2), (1,2);

INSERT INTO compra (id_proveedor, id_transaccion) VALUES (1,2);

INSERT INTO historial_compras (fecha, id_compra) VALUES (NOW(), 1);
```

## queries

```sql
-- Listar los productos con stock menor a 5 unidades.

SELECT p.nombre, p.precio, i.stock
FROM inventario i
INNER JOIN producto p ON i.id_producto = p.id
WHERE i.stock < 5;

-- Calcular ventas totales de un mes específico.

SELECT TO_CHAR(date_trunc('month', t.fecha), 'YYYY-MM') AS mes, SUM(p.precio) AS ventas_totales
FROM venta v
JOIN transaccion t ON v.id_transaccion = t.id
JOIN det_transaccion dt ON dt.id_transaccion = t.id
JOIN producto p ON dt.id_producto = p.id
WHERE date_part('year', t.fecha)  = 2025 AND date_part('month', t.fecha) = 3
GROUP BY 1;

-- Obtener el cliente con más compras realizadas.

SELECT v.id_cliente ,e.nombre, COUNT(v.id_cliente)
FROM venta v
INNER JOIN cliente c ON v.id_cliente = c.id
INNER JOIN entidad e ON c.id_entidad = e.id
GROUP BY v.id_cliente, e.nombre
ORDER BY COUNT(v.id_cliente) DESC
LIMIT 1;

-- Listar los 5 productos más vendidos.

SELECT dt.id_producto, p.nombre, COUNT(dt.id_producto)
FROM det_transaccion dt
INNER JOIN producto p ON dt.id_producto = p.id
GROUP BY dt.id_producto, p.nombre
ORDER BY COUNT(dt.id_producto) DESC
LIMIT 5;

-- Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.

-- 3 dias

SELECT t.fecha, SUM(p.precio) AS ventas_diarias
FROM venta v
JOIN transaccion t ON v.id_transaccion = t.id
JOIN det_transaccion dt ON dt.id_transaccion = t.id
JOIN producto p ON dt.id_producto = p.id
WHERE t.fecha BETWEEN DATE '2025-03-10' AND DATE '2025-03-12'
GROUP BY t.fecha
ORDER BY t.fecha;

-- 1 mes

SELECT TO_CHAR(date_trunc('month', t.fecha), 'YYYY-MM') AS mes, SUM(p.precio) AS ventas_totales
FROM venta v
JOIN transaccion t ON v.id_transaccion = t.id
JOIN det_transaccion dt ON dt.id_transaccion = t.id
JOIN producto p ON dt.id_producto = p.id
WHERE t.fecha >= DATE '2025-03-01' AND t.fecha <  DATE '2025-04-01'
GROUP BY 1;

-- Identificar clientes que no han comprado en los últimos 6 meses.

SELECT c.id AS cliente_id, e.nombre AS nombre_entidad, e.telefono
FROM cliente c
JOIN entidad e ON c.id_entidad = e.id
WHERE NOT EXISTS (
  SELECT 1
  FROM venta v
  INNER JOIN transaccion t ON v.id_transaccion = t.id
  WHERE v.id_cliente = c.id AND t.fecha >= (CURRENT_DATE - INTERVAL '6 months')
)
ORDER BY e.nombre;
```

## Procedures And Functions

```sql
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
```

