CREATE DATABASE Libreria_el_mundo_de_sofia;

USE Libreria_el_mundo_de_sofia;

CREATE TABLE Libros (
idLibro INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(150) NOT NULL,
editorial VARCHAR(100) NOT NULL,
fecha_publicacion DATETIME NOT NULL,
isbn VARCHAR(50) NOT NULL UNIQUE,
precio DECIMAL(10,2) NOT NULL,
stock INT  DEFAULT 0
);

CREATE TABLE Autores(
idAutor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
fecha_nacimiento DATETIME NOT NULL,
nacionalidad VARCHAR(50) NOT NULL
);

CREATE TABLE Libro_autor(
idLibro INT,
idAutor INT,
FOREIGN KEY (idLibro) REFERENCES Libros (idLibro),
FOREIGN KEY (idAutor) REFERENCES Autores (idAutor)
);

CREATE TABLE Clientes(
idCliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
correo VARCHAR(150) NOT NULL,
telefono VARCHAR(20) NOT NULL,
direccion VARCHAR(200) NOT NULL
);

CREATE TABLE Pedidos(
idPedido INT AUTO_INCREMENT PRIMARY KEY,
fecha_compra DATETIME NOT NULL,
estado VARCHAR(50) NOT NULL,
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES Clientes (idCliente)  
);

CREATE TABLE Detalle_pedido(
idDetalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
idLibro INT,
idPedido INT,
FOREIGN KEY (idLibro) REFERENCES Libros (idLibro),
FOREIGN KEY (idPedido) REFERENCES Pedidos (idPedido) 
);

CREATE TABLE Transacciones (
idTransacciones INT AUTO_INCREMENT PRIMARY KEY,
metodo_pago VARCHAR(50) NOT NULL,
monto_total DECIMAL(10,2) NOT NULL,
fecha_transaccion DATETIME NOT NULL,
idPedido INT,
FOREIGN KEY (idPedido) REFERENCES Pedidos (idPedido)
);