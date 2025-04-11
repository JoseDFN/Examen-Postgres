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

INSERT INTO det_transaccion (id_producto, id_transaccion) VALUES