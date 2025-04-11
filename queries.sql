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
