
--TRIGGER UPDATE USERS--
DELIMITER $$
CREATE TRIGGER AddLogUpdateUsers
AFTER UPDATE ON Users 
FOR EACH ROW
BEGIN 

UPDATE reservations SET userID = NEW.DNI WHERE userID LIKE OLD.DNI;
UPDATE suggestions SET userEmail = NEW.email WHERE userEmail = OLD.email;

INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
VALUES (
		'Users', 
		CONCAT(
		'{ UserID : ', IFNULL(OLD.dni,'NULL'),
		'| name: ', IFNULL(OLD.name,'NULL') ,
		'| Surname: ',IFNULL(OLD.surname,'NULL'),
		'| Email : ',IFNULL(OLD.email,'NULL'),
		'| Password : ',IFNULL(OLD.password,'NULL'),
		'| Phone Number : ',IFNULL(OLD.phoneNumber,'NULL'),
		'| Rol : ' ,IFNULL(OLD.rol,'NULL'),' }') 
, NOW());
END $$
DELIMITER ;
--Ejemplo para comprobar trigger
UPDATE users SET dni = '12345679X', email = 'pruebaNarutoUchiha@example.com' WHERE dni LIKE '12345678A';


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
            '| Description: ', IFNULL(OLD.description, 'NULL'),
            '| User Email : ', IFNULL(OLD.userEmail, 'NULL'),
            '| Suggestion Date : ', IFNULL(CAST(OLD.suggestionDate AS CHAR), 'NULL'),
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
            '| Name: ', IFNULL(OLD.name, 'NULL'),
            '| Address: ', IFNULL(OLD.address, 'NULL'),
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo para comprobar trigger
UPDATE companies SET name= 'Tecnalia2' WHERE CIF LIKE 'A12345678';


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
            '| Name: ', IFNULL(OLD.name, 'NULL'),
            '| Description : ', IFNULL(OLD.description, 'NULL'),			
            '| Peculiarity: ', IFNULL(OLD.peculiarity, 'NULL'),
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
	
	UPDATE reservations SET sessionID = NEW.sessionID WHERE sessionID = OLD.sessionID;

    INSERT INTO updateLogs (affectedTable, dataBeforeUpdate, updateDate)
    VALUES (
        'sessions', 
        CONCAT(
            '{ Session ID : ', IFNULL(OLD.sessionID, 'NULL'),
            '| Day: ', IFNULL(OLD.day, 'NULL'),
            '| Hour : ', IFNULL(OLD.hour, 'NULL'),			
            '| Capacity : ', IFNULL(OLD.capacity, 'NULL'),
			'| formationID : ', IFNULL(OLD.formationID, 'NULL'),
            '| Company Name : ', IFNULL(OLD.companyName, 'NULL'),
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo para comprobar trigger

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
            '| User ID: ', IFNULL(OLD.userID, 'NULL'),
            '| Session ID : ', IFNULL(OLD.sessionID, 'NULL'),			
            '}')
			, 
        NOW()
    );
END $$

DELIMITER ;
--Ejemplo UPDATE en Reservas
