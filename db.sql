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
    FOREIGN KEY (id_direccion) REFERENCES direccion(id)
);

DROP TABLE persona;

CREATE TABLE persona (
    id serial PRIMARY KEY,
    nombre CHAR(100) NOT NULL,
    id_direccion INTEGER NOT NULL,
    telefono CHAR(25),
    identificacion CHAR(50),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id)
);

DROP TABLE cliente;

CREATE TABLE cliente(
    id serial PRIMARY KEY,
    id_persona INTEGER NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES persona(id)
);

DROP TABLE proveedor;

CREATE TABLE proveedor(
    id serial PRIMARY KEY,
    id_persona INTEGER NOT NULL,
    nit CHAR(50) NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES persona(id)
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

DROP TABLE tipo_transaccion;

CREATE TABLE tipo_transaccion (
    id serial PRIMARY KEY,
    nombre CHAR(25) NOT NULL
);

DROP TABLE transaccion;

CREATE TABLE transaccion(
    id serial PRIMARY KEY
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