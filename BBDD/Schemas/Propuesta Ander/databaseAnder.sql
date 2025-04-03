drop database if exists donostiaKultura;
create database donostiaKultura;
use donostiaKultura;

create table users(
  dni varchar(9) PRIMARY KEY, 
  name varchar(50) not null, 
  surname varchar(100) not null, 
  email varchar(255) not null UNIQUE, 
  password varchar(255) not null, 
  phoneNumber varchar(50) null, 
  rol varchar(50) not null
);

create table suggestions (
  SuggestionID int unsigned auto_increment primary key, 
  description tinytext not null, 
  userName varchar(50) not null, 
  userEmail varchar(255) null unique,
  suggestionDate DATE,
  FOREIGN KEY (userEmail) REFERENCES users(email)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

create table companies (
  CIF varchar(20) primary key, 
  name varchar(50) not null UNIQUE, 
  address varchar(250) NOT NULL
);

create table formations (
  formationID int unsigned auto_increment primary key,  
  name varchar(50) not null, 
  description tinytext DEFAULT 'No description available', 
  peculiarity enum('english', '')
);

create table sessions(
  sessionID int unsigned auto_increment primary key, 
  day date not null, 
  hour time not null, 
  capacity int unsigned not null, 
  formationID int unsigned null, 
  companyName varchar(50) null, 
  FOREIGN KEY (formationID) REFERENCES formations(formationID)
    ON DELETE SET NULL
    ON UPDATE CASCADE, 
  FOREIGN KEY (companyName) REFERENCES companies(name)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

create table reservations(
  reservationID int unsigned auto_increment primary key, 
  userID VARCHAR(9) null, 
  sessionID int unsigned null, 
  FOREIGN KEY (userID) REFERENCES users(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
  FOREIGN KEY (sessionID) REFERENCES sessions(sessionID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

create table deleteLogs(
  actionID int unsigned auto_increment primary key, 
  affectedTable enum("users", "suggestions", "reservations", "sessions", "formations", "companies"), 
  dataBeforeDelete tinytext not null, 
  deleteDate datetime not null
);

create table updateLogs(
  actionID int unsigned auto_increment primary key, 
  affectedTable enum("users","suggestions", "reservations", "sessions", "formations", "companies"), 
  dataBeforeUpdate tinytext not null, 
  updateDate datetime not null
);


-- 🔑 Insertar usuarios (10 personajes de anime)
INSERT INTO users (dni, name, surname, email, password, phoneNumber, rol) VALUES
('11111111A', 'Tanjiro', 'Kamado', 'tanjiro@slayer.com', 'hinokami123', '600111222', 'user'),
('22222222B', 'Sakura', 'Haruno', 'sakura@konoha.com', 'cherryBlossom', '600222333', 'user'),
('33333333C', 'Edward', 'Elric', 'edward@alchemy.com', 'fullmetal99', '600333444', 'user'),
('44444444D', 'Light', 'Yagami', 'light@kira.com', 'justice4all', '600444555', 'user'),
('55555555E', 'Eren', 'Yeager', 'eren@paradis.com', 'titanRage', '600555666', 'user'),
('66666666F', 'Mikasa', 'Ackerman', 'mikasa@paradis.com', 'bladesOfSteel', '600666777', 'user'),
('77777777G', 'Gon', 'Freecss', 'gon@hunter.com', 'nenPower', '600777888', 'user'),
('88888888H', 'Lelouch', 'Lamperouge', 'lelouch@geass.com', 'zeroRebellion', '600888999', 'user'),
('99999999I', 'Natsu', 'Dragneel', 'natsu@fairytail.com', 'fireDragon', '600999111', 'user'),
('10101010J', 'Yato', 'God', 'yato@noragami.com', 'strayGod', '601010101', 'user');

-- 📣 Insertar sugerencias para cada usuario
INSERT INTO suggestions (description, userName, userEmail) VALUES
('Más entrenamientos de respiración avanzada.', 'Tanjiro', 'tanjiro@slayer.com'),
('Curso avanzado de ninjutsu médico.', 'Sakura', 'sakura@konoha.com'),
('Alquimia avanzada en las formaciones.', 'Edward', 'edward@alchemy.com'),
('Formación sobre técnicas de manipulación.', 'Light', 'light@kira.com'),
('Entrenamiento de combate con titanes.', 'Eren', 'eren@paradis.com'),
('Técnicas de protección y rescate.', 'Mikasa', 'mikasa@paradis.com'),
('Cursos de entrenamiento en Nen.', 'Gon', 'gon@hunter.com'),
('Formación estratégica avanzada.', 'Lelouch', 'lelouch@geass.com'),
('Técnicas de fuego especializadas.', 'Natsu', 'natsu@fairytail.com'),
('Combate con espadas y armas divinas.', 'Yato', 'yato@noragami.com');

-- 🏢 Insertar empresas (Organizaciones de anime)
INSERT INTO companies (CIF, name, address) VALUES
('CIF001', 'Demon Slayer Corps', 'Monte Fujikasane'),
('CIF002', 'Konoha', 'Aldea Oculta de la Hoja'),
('CIF003', 'State Alchemist Bureau', 'Central City'),
('CIF004', 'Paradis Military', 'Isla Paradis'),
('CIF005', 'Hunter Association', 'Yorknew City'),
('CIF006', 'Fairy Tail Guild', 'Magnolia Town');

-- 📚 Insertar formaciones (Basadas en habilidades de cada anime)
INSERT INTO formations (name, description, peculiarity) VALUES
('Breathing Techniques', 'Técnicas avanzadas de respiración para cazadores de demonios.', 'english'),
('Medical Ninjutsu', 'Curso intensivo sobre curación y técnicas médicas avanzadas.', 'english'),
('Alchemical Studies', 'Principios avanzados de alquimia y transmutación.', 'english'),
('Titan Combat Training', 'Entrenamiento especializado en combate contra titanes.', 'english'),
('Nen Mastery', 'Control y desarrollo del Nen en todas sus formas.', 'english'),
('Strategic Warfare', 'Formaciones en estrategias y tácticas de combate.', 'english'),
('Dragon Slayer Magic', 'Entrenamiento en magia de fuego y otros elementos.', 'english'),
('Divine Weapon Mastery', 'Control y uso de armas divinas.', 'english');

-- 🕒 Insertar sesiones (Programadas en diferentes días)
INSERT INTO sessions (day, hour, capacity, formationID, companyName) VALUES
('2025-04-04', '09:00:00', 30, 1, 'Demon Slayer Corps'),
('2025-04-05', '10:00:00', 25, 2, 'Konoha'),
('2025-04-06', '11:00:00', 40, 3, 'State Alchemist Bureau'),
('2025-04-07', '12:00:00', 20, 4, 'Paradis Military'),
('2025-04-08', '13:00:00', 35, 5, 'Hunter Association'),
('2025-04-09', '14:00:00', 28, 6, 'Fairy Tail Guild'),
('2025-04-10', '15:00:00', 30, 7, 'Fairy Tail Guild'),
('2025-04-11', '16:00:00', 20, 8, 'Paradis Military');

-- 🎫 Insertar reservas (Usuarios registrándose en formaciones)
INSERT INTO reservations (userID, sessionID) VALUES
('11111111A', 1),
('22222222B', 2),
('33333333C', 3),
('44444444D', 4),
('55555555E', 5),
('66666666F', 6),
('77777777G', 5),
('88888888H', 7),
('99999999I', 8),
('10101010J', 4);



--TRIGGER UPDATE USERS--
DELIMITER $$
CREATE TRIGGER AddLogUpdateUsers
AFTER UPDATE ON Users 
FOR EACH ROW
BEGIN 


INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
VALUES (
		'Users', 
		CONCAT(
		'{ UserID : ', IFNULL(OLD.dni,'NULL'),
		', name: ', IFNULL(OLD.name,'NULL') ,
		', Surname: ',IFNULL(OLD.surname,'NULL'),
		', Email : ',IFNULL(OLD.email,'NULL'),
		', Password : ',IFNULL(OLD.password,'NULL'),
		', Phone Number : ',IFNULL(OLD.phoneNumber,'NULL'),
		', Rol : ' ,IFNULL(OLD.rol,'NULL'),' }') 
, NOW());
END $$
DELIMITER ;
--Ejemplo para comprobar trigger
UPDATE users SET dni = '10101010X', email = 'pruebaFuncional@example.com' WHERE dni LIKE '10101010J';

--TRIGGER BEFORE UPDATE Users
DELIMITER $$
CREATE TRIGGER AddLogUpdateUsersBef
BEFORE UPDATE ON Users 
FOR EACH ROW
BEGIN 

UPDATE reservations SET userID = NEW.DNI WHERE userID LIKE OLD.DNI;
UPDATE suggestions SET userName = NEW.name, userEmail = NEW.email WHERE userEmail = OLD.email;

END $$
DELIMITER ;



--TRIGGER UPDATE SUGGESTIONS--
DELIMITER $$

CREATE TRIGGER AddLogUpdateSuggestions
AFTER UPDATE ON suggestions 
FOR EACH ROW
BEGIN 
    INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
    VALUES (
        'suggestions', 
        CONCAT(
            '{ Suggestion ID : ', IFNULL(OLD.SuggestionID, 'NULL'),
            ', Description: ', IFNULL(OLD.description, 'NULL'),
            ', User Name: ', IFNULL(OLD.userName, 'NULL'),
            ', User Email : ', IFNULL(OLD.userEmail, 'NULL'),
            ', Suggestion Date : ', IFNULL(CAST(OLD.suggestionDate AS CHAR), 'NULL'),
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo para comprobar trigger
UPDATE suggestions SET description = 'What the hell' WHERE SuggestionID = 6;



--TRIGGER UPDATE COMPANIES--
DELIMITER $$

CREATE TRIGGER AddLogUpdateCompanies
AFTER UPDATE ON companies 
FOR EACH ROW
BEGIN 

	UPDATE sessions SET companyName = NEW.name WHERE companyName LIKE OLD.name; 
	
    INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
    VALUES (
        'companies', 
        CONCAT(
            '{ CIF : ', IFNULL(OLD.CIF, 'NULL'),
            ', Name: ', IFNULL(OLD.name, 'NULL'),
            ', Address: ', IFNULL(OLD.address, 'NULL'),
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo para comprobar trigger
 UPDATE companies SET name = 'Konoha 2' WHERE CIF = 'CIF001';


--TRIGGER UPDATE FORMATIONS--
DELIMITER $$

CREATE TRIGGER AddLogUpdateFormations
AFTER UPDATE ON formations 
FOR EACH ROW
BEGIN 
	
	UPDATE sessions SET formationID = NEW.formationID WHERE formationID = OLD.formationID;

    INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
    VALUES (
        'formations', 
        CONCAT(
            '{ Formation ID : ', IFNULL(OLD.formationID, 'NULL'),
            ', Name: ', IFNULL(OLD.name, 'NULL'),
            ', Description : ', IFNULL(OLD.description, 'NULL'),			
            ', Peculiarity: ', IFNULL(OLD.peculiarity, 'NULL'),
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo para comprobar trigger
UPDATE formations SET formationID = 12 WHERE formationID = 4;



--TRIGGER UPDATE SESSIONS--
DELIMITER $$

CREATE TRIGGER AddLogUpdateSessions
AFTER UPDATE ON sessions 
FOR EACH ROW
BEGIN 
	
	UPDATE reservations SET sessionsID = NEW.formationID WHERE formationID = OLD.formationID;

    INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
    VALUES (
        'sessions', 
        CONCAT(
            '{ Session ID : ', IFNULL(OLD.sessionID, 'NULL'),
            ', Day: ', IFNULL(OLD.day, 'NULL'),
            ', Hour : ', IFNULL(OLD.hour, 'NULL'),			
            ', Capacity : ', IFNULL(OLD.capacity, 'NULL'),
			', formationID : ', IFNULL(OLD.formationID, 'NULL'),
            ', Company Name : ', IFNULL(OLD.companyName, 'NULL'),
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo para comprobar trigger
UPDATE sessions SET sessionID = 9 WHERE sessionID = 1;

--TRIGGER UPDATE RESERVATIONS--
DELIMITER $$

CREATE TRIGGER AddLogUpdateReservations
AFTER UPDATE ON reservations 
FOR EACH ROW
BEGIN 
	
    INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
    VALUES (
        'reservations', 
        CONCAT(
            '{ Reservation ID : ', IFNULL(OLD.reservationID, 'NULL'),
            ', User ID: ', IFNULL(OLD.userID, 'NULL'),
            ', Session ID : ', IFNULL(OLD.sessionID, 'NULL'),			
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo UPDATE en Reservas
