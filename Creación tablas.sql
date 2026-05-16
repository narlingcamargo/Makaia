CREATE DATABASE logistica_transporte;

CREATE TABLE rutas
(
 Id_Ruta INT AUTO_INCREMENT PRIMARY KEY,
 Destino VARCHAR(100) NOT NULL,
 Distancia DECIMAL(10,2) NOT NULL,
 Tipo_Ruta VARCHAR(50) NOT NULL,
 Tiempo_Estimado INT
);

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    departamento VARCHAR(100),
    tipo_cliente VARCHAR(20),
    fecha_registro DATE,
    estado_cliente VARCHAR(20)
);

CREATE TABLE envios (
id_envio INT AUTO_INCREMENT PRIMARY KEY, 
id_remitente INT NOT NULL, 
id_destinatario INT NOT NULL, 
id_ruta INT NOT NULL, 
tipo_envio VARCHAR(50), 
peso DECIMAL(10,2), 
fecha_envio DATE NOT NULL, 
fecha_entrega DATE, 
estado VARCHAR(30), 
tiempo_entrega INT, 
costo_envio DECIMAL(10,2),  
FOREIGN KEY (id_remitente) REFERENCES clientes(id_cliente), 
FOREIGN KEY (id_destinatario) REFERENCES clientes(id_cliente), 
FOREIGN KEY (id_ruta) REFERENCES rutas( id_ruta));

-- =====================
-- TABLA SEGUIMIENTO
-- =====================

CREATE TABLE seguimiento(
	id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_envio INT NOT NULL,
    fecha_evento DATE,
    estado VARCHAR(30),
    ubicacion VARCHAR(100),
    tipo_evento VARCHAR(50),
    
    FOREIGN KEY (id_envio) REFERENCES envios(id_envio)
);