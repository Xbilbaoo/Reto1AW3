--
-- Base de datos: `getYourGuide`
--
DROP DATABASE IF EXISTS getYourGuide;
CREATE DATABASE IF NOT EXISTS getYourGuide DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE getYourGuide;
-- ---------------------------------------------------------------------------------------------------
--
-- Estructura de tabla para la tabla `Persona`
--
CREATE TABLE Persona (
	DNI VARCHAR(9) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50),
	rol VARCHAR(50) NOT NULL,
	mail VARCHAR(50) UNIQUE NOT NULL,
	telefono INT(9),
	contraseyna VARCHAR(50) NOT NULL,
	PRIMARY KEY(DNI)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Persona`
--
INSERT INTO Persona (DNI, nombre, apellido, rol, mail, telefono, contraseyna) VALUES
('12345678A', 'Juan', 'Pérez', 'Guía', 'juan.perez@example.com', 612345678, 'contraseyna123'),
('23456789B', 'Ana', 'Gómez', 'Cliente', 'ana.gomez@example.com', 623456789, 'contraseyna456'),
('34567890C', 'Luis', 'Rodríguez', 'Cliente', 'luis.rodriguez@example.com', 634567890, 'contraseyna789'),
('45678901D', 'Marta', 'Martínez', 'Guía', 'marta.martinez@example.com', 645678901, 'contraseyna321'),
('56789012E', 'Pedro', 'Fernández', 'Guía', 'pedro.fernandez@example.com', 656789012, 'contraseña123'),
('67890123F', 'Laura', 'López', 'Cliente', 'laura.lopez@example.com', 667890123, 'contraseña456'),
('78901234G', 'Carlos', 'Sánchez', 'Cliente', 'carlos.sanchez@example.com', 678901234, 'contraseña789'),
('89012345H', 'Sofía', 'Gutiérrez', 'Guía', 'sofia.gutierrez@example.com', 689012345, 'contraseña321'),
('90123456I', 'Roberto', 'Vázquez', 'Guía', 'roberto.vazquez@example.com', 690123456, 'contraseña654'),
('01234567J', 'María', 'Ramírez', 'Cliente', 'maria.ramirez@example.com', 701234567, 'contraseña987'),
('12345678K', 'David', 'Hernández', 'Cliente', 'david.hernandez@example.com', 712345678, 'contraseña111'),
('23456789L', 'Eva', 'Jiménez', 'Guía', 'eva.jimenez@example.com', 723456789, 'contraseña222'),
('34567890M', 'Javier', 'Moreno', 'Cliente', 'javier.moreno@example.com', 734567890, 'contraseña333'),
('45678901N', 'Isabel', 'Pérez', 'Cliente', 'isabel.perez@example.com', 745678901, 'contraseña444');

--
-- Estructura de tabla para la tabla `Excursion`
--
CREATE TABLE Excursion (
	id_excursion INT AUTO_INCREMENT,
	hora TIME,
	dia DATE,
	aforo INT UNSIGNED,
	Codigo_visita INT NOT NULL,
	PRIMARY KEY(id_excursion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Excursion`
--
INSERT INTO Excursion (id_excursion, hora, dia, aforo,Codigo_visita) VALUES
(1, '10:00:00', '2025-04-05', 50,101),
(2,	'11:00:00', '2025-04-06', 30,102),
(3, '09:00:00', '2025-04-07', 40,103),
(4, '10:30:00', '2025-04-14', 40,104),
(5, '11:00:00', '2025-04-15', 25,105),
(6, '12:00:00', '2025-04-16', 60,106),
(7, '14:00:00', '2025-04-17', 45,107),
(8, '15:00:00', '2025-04-18', 50,108),
(9, '16:00:00', '2025-04-19', 40,109),
(10, '09:30:00', '2025-04-20', 30,110),
(11, '10:00:00', '2025-04-21', 35,111),
(12, '11:30:00', '2025-04-22', 25,112),
(13, '12:30:00', '2025-04-23', 50,113);

--
-- Estructura de tabla para la tabla `Empresa`
--
CREATE TABLE Empresa (
	CIF VARCHAR(9) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	PRIMARY KEY(CIF)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Empresa`
--
INSERT INTO Empresa (CIF, nombre, direccion) VALUES
('B12345678', 'Viajes Granada', 'Calle Gran Vía 10, Granada'),
('B23456789', 'Barcelona Tours', 'Avenida Diagonal 200, Barcelona'),
('B34567890', 'Madrid Cultura', 'Calle de Alcalá 150, Madrid'),
('B45678901', 'Viajes Córdoba', 'Calle de la Mezquita 1, Córdoba'),
('B56789012', 'Tours París', 'Avenida de la Torre Eiffel 5, París'),
('B67890123', 'Roma Tours', 'Piazza del Colosseo 10, Roma'),
('B78901234', 'NYC Art Tours', '5th Avenue 100, New York'),
('B89012345', 'London Sightseeing', 'Oxford Street 20, Londres'),
('B90123456', 'Madrid City Tours', 'Gran Vía 45, Madrid'),
('B01234567', 'British Tours', 'Regent Street 60, Londres'),
('B12345679', 'Paris Museums', 'Rue de Rivoli 80, París'),
('B23456780', 'Pisa Tours', 'Piazza del Duomo 1, Pisa'),
('B34567891', 'Gaudí Tours', 'Passeig de Gràcia 40, Barcelona');

--
-- Estructura de tabla para la tabla `Visita_Viaje`
--
CREATE TABLE Visita_Viaje (
	Codigo_visita INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	descripcion TEXT NOT NULL,
	estado_actividad ENUM('Jubilados','No Jubilados'),
	CIF_empresa VARCHAR(9) NOT NULL,
	PRIMARY KEY(Codigo_visita)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Visita`
--
INSERT INTO Visita_Viaje (Codigo_visita, nombre, descripcion, estado_actividad, CIF_empresa) VALUES
(101, 'Visita a la Alhambra', 'Una visita guiada por el majestuoso palacio de la Alhambra en Granada.', 'No Jubilados', '12345678A'),
(102, 'Visita a la Sagrada Familia', 'Tour por la famosa basílica de Gaudí en Barcelona.', 'Jubilados', '45678901D'),
(103, 'Visita al Museo del Prado', 'Recorrido por las obras maestras del arte español e internacional.', 'No Jubilados', '23456789B'),
(104, 'Visita a la Mezquita de Córdoba', 'Recorrido por la histórica Mezquita-Catedral de Córdoba.', 'No Jubilados', '56789012E'),
(105, 'Visita a la Torre Eiffel', 'Tour por el icónico monumento en París.', 'Jubilados', '89012345H'),
(106, 'Visita al Coliseo Romano', 'Explora el antiguo anfiteatro romano en el centro de Roma.', 'No Jubilados', '67890123F'),
(107, 'Visita al Museo de Arte Moderno de Nueva York', 'Tour por las famosas obras de arte contemporáneo.', 'Jubilados', '90123456I'),
(108, 'Visita al Palacio de Buckingham', 'Recorrido por la residencia oficial de la Reina en Londres.', 'No Jubilados', '23456789L'),
(109, 'Visita a la Plaza Mayor de Madrid', 'Recorrido por la emblemática plaza del centro de Madrid.', 'Jubilados', '34567890M'),
(110, 'Visita al Museo Británico', 'Tour por uno de los museos más importantes del mundo en Londres.', 'No Jubilados', '89012345H'),
(111, 'Visita al Museo del Louvre', 'Explora las colecciones más famosas del museo en París.', 'Jubilados', '56789012E'),
(112, 'Visita a la Torre de Pisa', 'Tour guiado por la famosa torre inclinada en Pisa, Italia.', 'No Jubilados', '23456789L'),
(113, 'Visita al Parque Güell', 'Tour por el parque diseñado por Antoni Gaudí en Barcelona.', 'No Jubilados', '78901234G');

--
-- Estructura de tabla para la tabla `Reserva`
--
CREATE TABLE Reserva (
	Id_reserva INT AUTO_INCREMENT,
	DNI_persona VARCHAR(9) NOT NULL,
	id_excursion INT,
	PRIMARY KEY(Id_reserva)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Reserva`
--
INSERT INTO Reserva (Id_reserva, DNI_persona, id_excursion) VALUES
(1, '12345678A', 1),  
(2, '23456789B', 2),
(3, '34567890C', 3), 
(4, '56789012E', 4),
(5, '67890123F', 5),
(6, '78901234G', 6),
(7, '89012345H', 7),
(8, '90123456I', 8),
(9, '01234567J', 9);

--
-- Estructura de tabla para la tabla `Sugerencias_personas`
--
CREATE TABLE Sugerencias_personas (
	Id_sugerencia INT AUTO_INCREMENT,
	fecha_creacion DATE,
	descripcion TEXT,
	DNI_persona VARCHAR(9) NOT NULL,
	PRIMARY KEY(Id_sugerencia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Sugerencias_personas`
--
INSERT INTO Sugerencias_personas (Id_sugerencia,fecha_creacion, descripcion, DNI_persona) VALUES
(1, '2025-04-01', 'Sería bueno ofrecer un descuento a los jubilados', '12345678A'),
(2, '2025-04-02', 'Me gustaría que se incluyera más información sobre las visitas', '23456789B'),
(3, '2025-04-03', 'Sería útil tener más horarios disponibles', '34567890C'),
(4, '2025-04-04', 'Sería interesante tener un tour nocturno', '56789012E'),
(5, '2025-04-05', 'Poder reservar los tours con más antelación sería útil', '67890123F'),
(6, '2025-04-06', 'Sugiero incluir más información sobre los precios', '78901234G'),
(7, '2025-04-07', 'Me gustaría que los guías pudieran hablar más idiomas', '89012345H'),
(8, '2025-04-08', 'Que se ofrezcan opciones de transporte para los tours', '90123456I'),
(9, '2025-04-09', 'Sería útil tener descuentos para grupos grandes', '01234567J'),
(10, '2025-04-10', 'Incluir visitas a restaurantes típicos de la ciudad', '12345678K'),
(11, '2025-04-11', 'Organizar visitas exclusivas para clientes VIP', '23456789L'),
(12, '2025-04-12', 'Me gustaría más información sobre el tour gastronómico', '34567890M'),
(13, '2025-04-13', 'Asegurarse de que las visitas sean accesibles para personas con movilidad reducida', '45678901N');

-------------------------------------------------------------------------------------------------------

--
-- Claves Foraneas para la tabla `Sugerencias_personas`
--
ALTER TABLE `Sugerencias_personas`
  ADD CONSTRAINT FK_Sugerencias_Persona FOREIGN KEY (DNI_persona) REFERENCES Persona (DNI);

--
-- Claves Foraneas para la tabla `Visita`
--
ALTER TABLE `Visita_Viaje`
  ADD CONSTRAINT `Visita_Viaje_ibfk_1` FOREIGN KEY (CIF_empresa) REFERENCES Empresa (CIF);

--
-- Claves Foraneas para la tabla `Reserva`
--
ALTER TABLE `Reserva`
  ADD CONSTRAINT `Reserva_ibfk_1` FOREIGN KEY (DNI_persona) REFERENCES Persona (DNI);
  ADD CONSTRAINT FK_Reserva_Excursion FOREIGN KEY(id_excursion) REFERENCES Excursion (id_excursion);
 
--
-- Claves Foraneas para la tabla `Excursion`
--
ALTER TABLE
	ADD CONSTRAINT `Excursion_ibfk_1` FOREIGN KEY (Codigo_visita) REFERENCES Visita_Viaje (Codigo_visita);
--
  --Visualización de todos los datos de las tablas 
--

-- Ver todos los datos de la tabla Persona
SELECT * FROM Persona;

-- Ver todos los datos de la tabla Sugerencias_personas
SELECT * FROM Sugerencias_personas;

-- Ver todos los datos de la tabla Visita
SELECT * FROM Visita_Viaje;

-- Ver todos los datos de la tabla Excursion
SELECT * FROM Excursion;

-- Ver todos los datos de la tabla Empresa
SELECT * FROM Empresa;

-- Ver todos los datos de la tabla Reserva
SELECT * FROM Reserva;

-- Ver todos los datos de la tabla datos_actualizados
SELECT * FROM datos_actualizados;

-- Ver todos los datos de la tabla datos_borrados
SELECT * FROM datos_borrados;

--
--Trigger de los datos borrados y actualizados
--

-- Tabla para almacenar datos actualizados
CREATE TABLE datos_actualizados (
    id_accion INT AUTO_INCREMENT PRIMARY KEY,
    tabla_cambiada VARCHAR(50),
    fecha DATETIME,
    datos_pre_modificar TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla para almacenar datos eliminados
CREATE TABLE datos_borrados (
    id_accion INT AUTO_INCREMENT PRIMARY KEY,
    tabla_cambiada VARCHAR(50),
    fecha DATETIME,
    datos_pre_modificar TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELIMITER $$

-- Trigger para datos actualizados en Persona
CREATE TRIGGER trigger_persona_update
AFTER UPDATE ON Persona
FOR EACH ROW
BEGIN
    INSERT INTO datos_actualizados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Persona', NOW(),CONCAT('DNI: ', OLD.DNI, ', Nombre: ', OLD.nombre, ', Apellido: ', OLD.apellido, ', Rol: ', OLD.rol, ', Email: ', OLD.mail, ', Teléfono: ', OLD.telefono));
END $$

-- Trigger para datos borrados en Persona
CREATE TRIGGER trigger_persona_delete
AFTER DELETE ON Persona
FOR EACH ROW
BEGIN
    INSERT INTO datos_borrados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Persona', NOW(),CONCAT('DNI: ', OLD.DNI, ', Nombre: ', OLD.nombre, ', Apellido: ', OLD.apellido, ', Rol: ', OLD.rol, ', Email: ', OLD.mail, ', Teléfono: ', OLD.telefono));
END $$

-- Trigger para datos actualizados en Sugerencias_personas
CREATE TRIGGER trigger_sugerencias_update
AFTER UPDATE ON Sugerencias_personas
FOR EACH ROW
BEGIN
    INSERT INTO datos_actualizados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Sugerencias_personas', NOW(),CONCAT('ID: ', OLD.Id_sugerencia, ', Fecha: ', OLD.fecha_creacion, ', Descripción: ', OLD.descripcion,', DNI_persona: ',OLD.DNI_persona));
END $$

-- Trigger para datos borrados en Sugerencias_personas
CREATE TRIGGER trigger_sugerencias_delete
AFTER DELETE ON Sugerencias_personas
FOR EACH ROW
BEGIN
    INSERT INTO datos_borrados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Sugerencias_personas', NOW(),CONCAT('ID: ', OLD.Id_sugerencia,', Fecha: ', OLD.fecha_creacion, ', Descripción: ', OLD.descripcion,', DNI_persona: ',OLD.DNI_persona));
END $$

-- Trigger para datos actualizados en Visita_Viaje
CREATE TRIGGER trigger_visita_update
AFTER UPDATE ON Visita_Viaje
FOR EACH ROW
BEGIN
    INSERT INTO datos_actualizados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Visita_Viaje', NOW(),CONCAT('Código: ', OLD.Codigo, ', Nombre: ', OLD.nombre, ', Descripción: ', OLD.descripcion, ', estado_actividad: ', OLD.estado_actividad, ', CIF_empresa: ', OLD.CIF_empresa));
END $$

-- Trigger para datos borrados en Visita_Viaje	
CREATE TRIGGER trigger_visita_delete
AFTER DELETE ON Visita_Viaje
FOR EACH ROW
BEGIN
    INSERT INTO datos_borrados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Visita_Viaje', NOW(),CONCAT('Código: ', OLD.Codigo, ', Nombre: ', OLD.nombre, ', Descripción: ', OLD.descripcion, ', estado_actividad: ', OLD.estado_actividad, ', CIF_empresa: ', OLD.CIF_empresa));
END $$

-- Trigger para datos actualizados en Excursion
CREATE TRIGGER trigger_excursion_update
AFTER UPDATE ON Excursion
FOR EACH ROW
BEGIN
    INSERT INTO datos_actualizados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Excursion', NOW(),CONCAT('id_excursion:', OLD.id_excursion,', Hora: ', OLD.hora, ', Día: ', OLD.dia, ', Aforo: ', OLD.aforo,'Codigo_visita:',OLD.Codigo_visita));
END $$

-- Trigger para datos borrados en Excursion
CREATE TRIGGER trigger_excursion_delete
AFTER DELETE ON Excursion
FOR EACH ROW
BEGIN
    INSERT INTO datos_borrados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Excursion', NOW(),CONCAT('id_excursion:', OLD.id_excursion,', Hora: ', OLD.hora, ', Día: ', OLD.dia, ', Aforo: ', OLD.aforo,'Codigo_visita:',OLD.Codigo_visita));
END $$

-- Trigger para datos actualizados en Empresa
CREATE TRIGGER trigger_empresa_update
AFTER UPDATE ON Empresa
FOR EACH ROW
BEGIN
    INSERT INTO datos_actualizados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Empresa', NOW(),CONCAT('CIF: ', OLD.CIF, ', Nombre: ', OLD.nombre, ', Dirección: ', OLD.direccion));
END $$

-- Trigger para datos borrados en Empresa
CREATE TRIGGER trigger_empresa_delete
AFTER DELETE ON Empresa
FOR EACH ROW
BEGIN
    INSERT INTO datos_borrados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Empresa', NOW(),CONCAT('CIF: ', OLD.CIF, ', Nombre: ', OLD.nombre, ', Dirección: ', OLD.direccion));
END $$

-- Trigger para datos actualizados en Reserva
CREATE TRIGGER trigger_reserva_update
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
    INSERT INTO datos_actualizados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Reserva', NOW(),CONCAT('Id_reserva: ', OLD.Id_reserva, ', DNI_persona: ', OLD.DNI_persona, ', id_excursion: ', OLD.id_excursion));
END $$

-- Trigger para datos borrados en Reserva
CREATE TRIGGER trigger_reserva_delete
AFTER DELETE ON Reserva
FOR EACH ROW
BEGIN
    INSERT INTO datos_borrados (tabla_cambiada, fecha, datos_pre_modificar)
    VALUES ('Reserva', NOW(),CONCAT('Id_reserva: ', OLD.Id_reserva, ', DNI_persona: ', OLD.DNI_persona, ', id_excursion: ', OLD.id_excursion));
END $$

DELIMITER ;