-- Listar los productos con stock menor a 5 unidades.

SELECT p.nombre, p.precio, i.stock
FROM inventario i
INNER JOIN producto p ON i.id_producto = p.id
WHERE i.stock < 5;

-- Calcular ventas totales de un mes específico.



-- Obtener el cliente con más compras realizadas.

SELECT v.id_cliente ,e.nombre, COUNT(v.id_cliente)
FROM venta v
INNER JOIN cliente c ON v.id_cliente = c.id
INNER JOIN entidad e ON c.id_entidad = e.id
GROUP BY v.id_cliente, e.nombre
ORDER BY COUNT(v.id_cliente)
LIMIT 1;

-- Listar los 5 productos más vendidos.
-- Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.
-- Identificar clientes que no han comprado en los últimos 6 meses.