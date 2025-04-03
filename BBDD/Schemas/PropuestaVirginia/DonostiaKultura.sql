

create database donostiaKultura;
use donostiaKultura;

create table Users(
dni varchar(9) PRIMARY KEY,
name varchar(50) not null,
surname varchar(100),
email varchar(2500) not null,
password varchar(255) not null,
phoneNumber varchar(50),
rol varchar(50) not null
);

create table suggestions (
SuggestionID int unsigned auto_increment primary key,
description tinytext not null,
userName varchar(50) not null,
userEmail varchar(255) not null,
suggestionDate date
);

create table companys (
CIF varchar(20) primary key,
name varchar(50) not null,
address varchar(250) not null
);

create table formations (
formationID int unsigned auto_increment primary key,
name varchar(50) not null,
description tinytext DEFAULT 'No description available',
peculiarity enum('english', '')
);

create table sessions(
sessionID int auto_increment primary key,
day date not null,
hour time not null,
capacity int unsigned not null,
formationID int unsigned not null,
companyName varchar(50) not null,
FOREIGN KEY (formationID) REFERENCES formations(formationID)
);

create table reservations(
reservationID int unsigned auto_increment primary key,
userID VARCHAR(9) not null,
sessionID int not null,
FOREIGN KEY (userID) REFERENCES users(dni),
FOREIGN KEY (sessionID) REFERENCES sessions(sessionID)
);

create table deleteLogs(
actionID int unsigned auto_increment primary key,
affectedTable enum("users", "reservations","sessions","formations", "companys"),
dataBeforeDelete tinytext not null,
deleteDate datetime not null
);


create table updateLogs(
actionID int unsigned auto_increment primary key,
affectedTable enum("users", "reservations","sessions","formations", "companys"),
dataBeforeUpdate tinytext not null,
updateDate datetime not null
);



INSERT INTO Users (dni, name, surname, email, password, phoneNumber, rol) VALUES
('11111111A', 'Manuel', 'Ortega', 'manuel@example.com', 'pass111', '610000001', 'user'),
('22222222B', 'Sofía', 'Castro', 'sofia@example.com', 'pass222', '610000002', 'admin'),
('33333333C', 'Raúl', 'González', 'raul@example.com', 'pass333', '610000003', 'user'),
('44444444D', 'Carmen', 'Pérez', 'carmen@example.com', 'pass444', '610000004', 'user'),
('55555555E', 'Miguel', 'Hernández', 'miguel@example.com', 'pass555', '610000005', 'user'),
('66666666F', 'Lucía', 'Ramírez', 'lucia@example.com', 'pass666', '610000006', 'admin'),
('77777777G', 'Diego', 'Martín', 'diego@example.com', 'pass777', '610000007', 'user'),
('88888888H', 'Elena', 'López', 'elena@example.com', 'pass888', '610000008', 'user'),
('99999999I', 'Javier', 'Serrano', 'javier@example.com', 'pass999', '610000009', 'user'),
('10101010J', 'Natalia', 'Vega', 'natalia@example.com', 'pass101', '610000010', 'user'),
('11111112K', 'Andrés', 'Díaz', 'andres@example.com', 'pass112', '610000011', 'admin'),
('12121212L', 'Valeria', 'Morales', 'valeria@example.com', 'pass121', '610000012', 'user'),
('13131313M', 'Sergio', 'Torres', 'sergio@example.com', 'pass131', '610000013', 'user'),
('14141414N', 'Clara', 'Suárez', 'clara@example.com', 'pass141', '610000014', 'user'),
('15151515O', 'Pablo', 'Mendoza', 'pablo@example.com', 'pass151', '610000015', 'admin'),
('16161616P', 'Isabel', 'Navarro', 'isabel@example.com', 'pass161', '610000016', 'user'),
('17171717Q', 'Adrián', 'Fuentes', 'adrian@example.com', 'pass171', '610000017', 'user'),
('18181818R', 'Lorena', 'Cruz', 'lorena@example.com', 'pass181', '610000018', 'user'),
('19191919S', 'Alberto', 'Rojas', 'alberto@example.com', 'pass191', '610000019', 'user'),
('20202020T', 'Beatriz', 'Flores', 'beatriz@example.com', 'pass202', '610000020', 'user');


INSERT INTO suggestions (suggestionID, description, user_name, user_email, suggestion_date) VALUES
(1, 'Más talleres de escultura.', 'Manuel', 'manuel@example.com', '2025-04-10'),
(2, 'Incluir clases de danza moderna.', 'Sofía', 'sofia@example.com', '2025-04-11'),
(3, 'Taller de música clásica.', 'Raúl', 'raul@example.com', '2025-04-12'),
(4, 'Cursos de cocina internacional.', 'Carmen', 'carmen@example.com', '2025-04-13'),
(5, 'Clases de diseño gráfico.', 'Miguel', 'miguel@example.com', '2025-04-14'),
(6, 'Eventos de poesía y literatura.', 'Lucía', 'lucia@example.com', '2025-04-15'),
(7, 'Más actividades al aire libre.', 'Diego', 'diego@example.com', '2025-04-16'),
(8, 'Mejoras en la plataforma web.', 'Elena', 'elena@example.com', '2025-04-17'),
(9, 'Integrar servicio de streaming.', 'Javier', 'javier@example.com', '2025-04-18'),
(10, 'Seminarios sobre historia del arte.', 'Natalia', 'natalia@example.com', '2025-04-19');



INSERT INTO companys (CIF, name, address) VALUES
('E56789012', 'Artes Escénicas S.L.', 'Calle Luna 10, Donostia'),
('F67890123', 'Danza Viva', 'Avenida del Sol 25, Madrid'),
('G78901234', 'Música en Vivo', 'Plaza Central 3, Bilbao'),
('H89012345', 'Diseño Digital S.A.', 'Calle Arte 45, Barcelona');


INSERT INTO formations (formationID,name, description, peculiarity) VALUES
(1, 'Curso de Escultura', 'Técnicas avanzadas de modelado.', 'english'),
(2, 'Danza Contemporánea', 'Expresión a través del movimiento.', null),
(3, 'Música Clásica', 'Teoría y práctica instrumental.', null),
(4, 'Diseño Gráfico', 'Uso de herramientas digitales.', 'english'),
(5, 'Fotografía Artística', 'Composición y edición de imágenes.', null),
(6, 'Teatro y Actuación', 'Técnicas de interpretación escénica.', null),
(7, 'Pintura al Óleo', 'Técnicas y estilos pictóricos.', null),
(8, 'Cine y Producción Audiovisual', 'Dirección y edición de video.', null),
(9, 'Historia del Arte', 'Análisis de movimientos artísticos.', null),
(10, 'Escritura Creativa', 'Taller de narrativa y poesía.', null);


INSERT INTO sessions (sessionID, day, hour, capacity, formationID, companyName) VALUES
(1, '2025-10-05', '14:00:00', 15, 7, 'Artes Escénicas S.L.'),
(2, '2025-10-15', '16:00:00', 20, 8, 'Danza Viva'),
(3, '2025-11-01', '18:30:00', 25, 9, 'Música en Vivo'),
(4, '2025-11-20', '10:00:00', 30, 10, 'Diseño Digital S.A.'),
(5, '2025-12-01', '09:00:00', 12, 1, 'Escultura Moderna'),
(6, '2025-12-10', '11:30:00', 18, 2, 'Danza Contemporánea Co.'),
(7, '2025-12-20', '15:00:00', 22, 3, 'Orquesta Sinfónica'),
(8, '2026-01-05', '17:45:00', 28, 4, 'Agencia de Diseño Gráfico'),
(9, '2026-01-15', '13:30:00', 16, 5, 'Fotografía Creativa S.L.'),
(10, '2026-02-01', '10:15:00', 20, 6, 'Escuela de Teatro y Cine');


INSERT INTO reservations (userID, sessionID) VALUES
('11111111A', 7),
('22222222B', 8),
('33333333C', 9),
('44444444D', 10),
('55555555E', 7),
('66666666F', 8),
('77777777G', 9),
('88888888H', 10),
('99999999I', 7),
('10101010J', 8),
('11111112K', 9),
('12121212L', 10),
('13131313M', 7),
('14141414N', 8),
('15151515O', 9),
('16161616P', 10),
('17171717Q', 7),
('18181818R', 8),
('19191919S', 9),
('20202020T', 10);
















