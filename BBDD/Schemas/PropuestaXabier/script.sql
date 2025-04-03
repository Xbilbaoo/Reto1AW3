DROP DATABASE IF EXISTS donostiaKultura;

CREATE DATABASE donostiaKultura;
USE donostiaKultura;

CREATE TABLE users (
    dni VARCHAR(9) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    surname VARCHAR(100) NOT NULL, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL, 
    phoneNumber VARCHAR(50) NULL, 
    rol VARCHAR(50) NOT NULL
);

CREATE TABLE suggestions (
    SuggestionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    description TINYTEXT NOT NULL,
    userEmail VARCHAR(255) NULL, 
    suggestionDate DATE,
	
	CONSTRAINT fk_userEmail FOREIGN KEY (userEmail) REFERENCES users(email)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE companys (
    CIF VARCHAR(20) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL UNIQUE, 
    address VARCHAR(250) NOT NULL
);

CREATE TABLE formations (
    formationID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,  
    name VARCHAR(50) NOT NULL, 
    description TINYTEXT DEFAULT 'No description available', 
    peculiarity ENUM('english', '')
);

CREATE TABLE sessions (
    sessionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    day DATE NOT NULL, 
    hour TIME NOT NULL, 
    capacity INT UNSIGNED NOT NULL, 
    formationID INT UNSIGNED NULL, 
    companyName VARCHAR(50) NULL, 
   
	CONSTRAINT fk_formationID FOREIGN KEY (formationID) REFERENCES formations(formationID)
        ON DELETE CASCADE
        ON UPDATE CASCADE, 
    
	CONSTRAINT fk_companyName FOREIGN KEY (companyName) REFERENCES companys(name)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE reservations (
    reservationID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    userID VARCHAR(9) NULL, 
    sessionID INT UNSIGNED NULL, 
    
	CONSTRAINT fk_userID FOREIGN KEY (userID) REFERENCES users(dni)
		ON DELETE CASCADE
        ON UPDATE CASCADE, 
    
	CONSTRAINT fk_sessionID FOREIGN KEY (sessionID) REFERENCES sessions(sessionID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE deleteLogs (
    actionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    affectedTable ENUM('users', 'reservations', 'sessions', 'formations', 'companys', 'suggestions'), 
    dataBeforeDelete TINYTEXT NOT NULL, 
    deleteDate DATETIME NOT NULL
);

CREATE TABLE updateLogs (
    actionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    affectedTable ENUM('users', 'reservations', 'sessions', 'formations', 'companys'), 
    dataBeforeUpdate TINYTEXT NOT NULL, 
    updateDate DATETIME NOT NULL
);

INSERT INTO companys (CIF, name, address) VALUES
('A12345678', 'Tecnalia', 'Parque Tecnológico de Gipuzkoa, 20009 Donostia, Gipuzkoa, España'),
('B23456789', 'Irizar', 'Calle Irizar 10, 20180 Oiarzun, Gipuzkoa, España'),
('C34567890', 'Danobat', 'Bº Lapatza 2, 20870 Elgoibar, Gipuzkoa, España'),
('D45678901', 'CAF', 'Calle Padre José de Arce, 2, 20200 Beasain, Gipuzkoa, España'),
('E56789012', 'KUKA Robotics', 'Paseo del Molino, 4, 20012 Donostia, Gipuzkoa, España'),
('F67890123', 'Orona', 'Polígono Industrial Agustinas, 20400 Tolosa, Gipuzkoa, España'),
('G78901234', 'IK4-TEKNIKER', 'Calle Ibaiondo 12, 20500 Arrasate-Mondragón, Gipuzkoa, España'),
('H89012345', 'Sener', 'Calle Zubieta, 2, 20018 Donostia, Gipuzkoa, España'),
('I90123456', 'Ibermática', 'Calle José María Soroa, 13, 20018 Donostia, Gipuzkoa, España'),
('J01234567', 'Siemens Gamesa', 'Calle José Elosegui 45, 20015 Donostia, Gipuzkoa, España');

INSERT INTO formations (name, description, peculiarity) VALUES
('Robótica 101', 'Introducción a los fundamentos de la robótica, desde la teoría hasta la aplicación práctica.', 'ingles'),
('IA y Aprendizaje Automático', 'Aprende cómo la IA está transformando industrias y profundiza en técnicas de aprendizaje automático.', ''),
('Robótica Avanzada', 'Explora temas avanzados de robótica, incluyendo visión robótica e integración de IA.', 'ingles'),
('Sistemas de Energía Sostenible', 'Enfoque en fuentes de energía renovable y sus aplicaciones tecnológicas.', ''),
('Tecnologías de la Salud', 'Entiende las últimas tecnologías en salud y sus aplicaciones en el mundo real.', 'ingles'),
('Ciudades Inteligentes', 'Estudia los avances tecnológicos que están transformando las ciudades en entornos sostenibles e inteligentes.', ''),
('Ciberseguridad para la Industria', 'Profundiza en los protocolos de seguridad y las tecnologías diseñadas para proteger los sistemas industriales.', 'ingles'),
('Ciencia de Datos y Big Data', 'Aprende cómo Big Data está moldeando el futuro y cómo aprovechar los datos para la ventaja empresarial.', ''),
('Vehículos Autónomos', 'Aprende las tecnologías detrás de los vehículos autónomos, desde los sensores hasta los algoritmos de IA.', 'ingles'),
('Transformación Digital en los Negocios', 'Entiende cómo las herramientas digitales están remodelando los negocios y la economía moderna.', '');

INSERT INTO users (dni, name, surname, email, password, phoneNumber, rol) VALUES
('12345678A', 'Naruto', 'Uzumaki', 'naruto.uzumaki@example.com', '$2y$10$abcdefghijk1234567890123456789012345678901234567890', '123456789', 'admin'),
('23456789B', 'Pau', 'Gasol', 'pau.gasol@example.com', '$2y$10$zyxwvutsrqpo9876543210987654321098765432109876543210', '123456789', 'moderator'),
('34567890C', 'Rafa', 'Nadal', 'rafa.nadal@example.com', '$2y$10$abcdefghijk1234567890123456789012345678901234567890', '456789123', 'user'),
('45678901D', 'Saitama', 'One Punch', 'saitama.punch@example.com', '$2y$10$1234567890qwertyuiopasdfghjklzxcvbnm1234567890123', '1122334455', 'editor'),
('56789012E', 'Iker', 'Casillas', 'iker.casillas@example.com', '$2y$10$abcdefghijk1234567890123456789012345678901234567890', '987654321', 'user'),
('67890123F', 'Luffy', 'Monkey D.', 'luffy.monkey@example.com', '$2y$10$lmnopqrstuvwxyz1234567890123456789012345678901234', '654321987', 'moderator'),
('78901234G', 'Mia', 'Martinez', 'mia.martinez@example.com', '$2y$10$abcdefg1234567890123456789012345678901234567890', '987654321', 'admin'),
('89012345H', 'Olivia', 'Lopez', 'olivia.lopez@example.com', '$2y$10$abcdefg1234567890123456789012345678901234567890', '345678901', 'user'),
('90123456I', 'Fernando', 'Alonso', 'fernando.alonso@example.com', '$2y$10$zyxwvutsrqpo9876543210987654321098765432109876543210', '654321987', 'admin'),
('01234567J', 'Carlos', 'Hernandez', 'carlos.hernandez@example.com', '$2y$10$abcdefg1234567890123456789012345678901234567890', '456789012', 'editor'),
('12345678K', 'Liam', 'Gomez', 'liam.gomez@example.com', '$2y$10$abcdefg1234567890123456789012345678901234567890', '234567890', 'moderator'),
('23456789L', 'Goku', 'Son', 'goku.son@example.com', '$2y$10$qwertyuiopasdfghjklzxcvbnm123456789012345678901234', '1122334455', 'editor'),
('34567890M', 'John', 'Doe', 'john.doe@example.com', '$2y$10$abcdefg1234567890123456789012345678901234567890', '678901234', 'user'),
('45678901N', 'Sara', 'Simón', 'sara.simon@example.com', '$2y$10$1234567890qwertyuiopasdfghjklzxcvbnm1234567890123', '9988776655', 'user'),
('56789012O', 'Sakura', 'Haruno', 'sakura.haruno@example.com', '$2y$10$zyxwvutsrqpo9876543210987654321098765432109876543210', '987654321', 'user');

INSERT INTO sessions (day, hour, capacity, formationID, companyName) VALUES
('2025-04-01', '09:00:00', 50, 1, 'Tecnalia'),
('2025-04-01', '11:00:00', 50, 2, 'Irizar'),
('2025-04-02', '09:00:00', 30, 3, 'Danobat'),
('2025-04-02', '14:00:00', 40, 4, 'CAF'),
('2025-04-03', '10:00:00', 60, 5, 'KUKA Robotics'),
('2025-04-03', '12:00:00', 35, 6, 'Orona'),
('2025-04-04', '09:00:00', 50, 7, 'IK4-TEKNIKER'),
('2025-04-04', '11:00:00', 60, 8, 'Sener'),
('2025-04-05', '09:00:00', 45, 9, 'Ibermática'),
('2025-04-05', '11:00:00', 40, 10, 'Siemens Gamesa');

INSERT INTO reservations (userID, sessionID) VALUES
('12345678A', 5),
('23456789B', 1),
('34567890C', 9),
('45678901D', 3),
('56789012E', 7),
('67890123F', 2),
('78901234G', 4),
('89012345H', 10),
('90123456I', 6),
('01234567J', 8),
('12345678K', 2),
('23456789L', 6),
('34567890M', 4),
('45678901N', 10),
('56789012O', 5);

INSERT INTO suggestions (description, userEmail, suggestionDate) VALUES
('Los horarios de las sesiones son muy temprano. Sería mejor tenerlos por la tarde.', 'naruto.uzumaki@example.com', '2025-04-01'),
('Creo que el contenido de la sesión 3 podría ser más interactivo con estudios de caso.', 'pau.gasol@example.com', '2025-04-02'),
('Por favor, agreguen más sesiones centradas en robótica avanzada.', 'rafa.nadal@example.com', '2025-04-03'),
('La sesión estuvo bien, pero el equipo técnico no funcionaba bien durante la demostración.', 'saitama.punch@example.com', '2025-04-04'),
('¿Podrían agregar más ejemplos del sector sanitario en la próxima sesión?', 'iker.casillas@example.com', '2025-04-05'),
('Me gustaría ver más talleres prácticos en las próximas sesiones.', 'luffy.monkey@example.com', '2025-04-06'),
('La sesión estuvo bien, pero me gustaría ver más sobre las prácticas de sostenibilidad medioambiental.', 'mia.martinez@example.com', '2025-04-07'),
('Sería bueno tener más oportunidades de networking al final del evento.', 'olivia.lopez@example.com', '2025-04-08'),
('Me gustó la sesión, pero no hubo suficientes oportunidades para hacer preguntas.', 'fernando.alonso@example.com', '2025-04-09'),
('¿Podemos obtener más detalles sobre las futuras tendencias tecnológicas en las próximas sesiones?', 'carlos.hernandez@example.com', '2025-04-10'),
('Tal vez podrían ofrecer más actividades grupales para fomentar la colaboración en equipo.', 'liam.gomez@example.com', '2025-04-11'),
('Me gustaría ver más estudios de caso sobre la transformación empresarial global en las sesiones.', 'goku.son@example.com', '2025-04-12'),
('¿Podrían extender el tiempo de las sesiones? A veces se sienten apresuradas.', 'john.doe@example.com', '2025-04-13'),
('Debería haber una sesión dedicada específicamente a los problemas éticos en la IA.', 'sara.simon@example.com', '2025-04-14'),
('Creo que podríamos beneficiarnos de una sesión de seguimiento para profundizar más en los temas tratados.', 'sakura.haruno@example.com', '2025-04-15');



DROP TRIGGER IF EXISTS addDeleteLogUsers;

DELIMITER $$
	
	CREATE TRIGGER addDeleteLogUsers
	
		AFTER DELETE
		
		ON users FOR EACH ROW
		
		BEGIN
				
			INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate) VALUES
				('users', CONCAT('OldDNI: ', OLD.dni, ' | OldName: ', OLD.name, ' | OldSurname: ', OLD.surname, ' | OldEmail: ', OLD.email, ' | OldPassword: ', OLD.password, ' |  OldPhoneNumber: ', OLD.phoneNumber, ' | OldRol: ', OLD.rol), NOW());

		END $$
		
DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteSuggestion_and_Reservations;

DELIMITER $$

CREATE TRIGGER addDeleteLogSuggestions_and_Reservations
    BEFORE DELETE
    ON users FOR EACH ROW
    BEGIN
	
		DELETE FROM reservations
			WHERE userID = OLD.dni;
		
		DELETE FROM suggestions
			WHERE userEmail = OLD.email;

    END $$

DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogReservations;

DELIMITER $$

CREATE TRIGGER addDeleteLogReservations
    AFTER DELETE
    ON reservations FOR EACH ROW
    BEGIN
        
		INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate)
            VALUES
            ('reservations', CONCAT('OldReservationID: ', OLD.reservationID, ' | OldUserID: ', OLD.userID, ' | OldSessionID: ', OLD.sessionID), NOW());
    END $$
	
DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogSuggestions;

DELIMITER $$

CREATE TRIGGER addDeleteLogSuggestions
    AFTER DELETE
    ON Suggestions FOR EACH ROW
    BEGIN
        INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate)
            VALUES
            ('suggestions', CONCAT('OldSuggestionID: ', OLD.SuggestionID, ' , OldUserEmail: ', OLD.userEmail, ' , OldDescription: ', OLD.description), NOW());
    END $$

DELIMITER ;

