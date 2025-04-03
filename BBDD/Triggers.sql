/*
    Este script crea los triggers necesarios para el correcto funcionamiento de la base de datos.
    Se crean triggers para las tablas de usuarios, reservas, sugerencias, formaciones, sesiones y empresas.
    Los triggers se encargan de insertar en la tabla DeleteLogs los datos de las filas eliminadas de las tablas correspondientes.
    Ademas, se encargan de eliminar las reservas y sugerencias asociadas a los usuarios y formaciones que se van a eliminar.
    Por ultimo, se crean triggers para actualizar los datos de las tablas de reservas, sugerencias, formaciones, sesiones y empresas.
    Los triggers se encargan de insertar en la tabla updateLogs los datos de las filas actualizadas de las tablas correspondientes.
*/
DROP TRIGGER IF EXISTS addDeleteLogUsers;

DELIMITER $$
	
    -- Este trigger se encarga de insertar en la tabla DeleteLogs los datos de la fila eliminada de la tabla users.
	
    CREATE TRIGGER addDeleteLogUsers
	
		AFTER DELETE
		
		ON users FOR EACH ROW
		
		BEGIN
				
			INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate) VALUES 
			('users', CONCAT('OldDNI: ', OLD.dni, ' | OldName: ', OLD.name, ' | OldSurname: ', OLD.surname, ' | OldEmail: ', OLD.email, ' | OldPassword: ', OLD.password, ' |  OldPhoneNumber: ', OLD.phoneNumber, ' | OldRol: ', OLD.rol), NOW());

		END $$
		
DELIMITER ;

DROP TRIGGER IF EXISTS beforeDeleteLogUsers;

DELIMITER $$
    
    -- Este trigger se encarga de eliminar las reservas y sugerencias asociadas al usuario que se va a eliminar.
    
    CREATE TRIGGER beforeDeleteLogUsers
    
    BEFORE DELETE
    
    ON users FOR EACH ROW
    
    BEGIN
	
		DELETE FROM reservations
			WHERE userID = OLD.dni;
		
		DELETE FROM suggestions
			WHERE userEmail = OLD.email;

    END $$

DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogFormations;

DELIMITER $$

    -- Este trigger se encarga de insertar en la tabla DeleteLogs los datos de la fila eliminada de la tabla formations.

	CREATE TRIGGER addDeleteLogFormations
	
	AFTER DELETE
	
	ON formations FOR EACH ROW 
	
	BEGIN
		
		INSERT INTO DeleteLogs (affectedTable,  dataBeforeDelete, deleteDate) VALUES 
		('formations', CONCAT('OldFormationID: ', OLD.formationID, ' | OLdFormationName: ', OLD.name, ' | OldDescription: ', OLD.description, ' | OldPeculiarity: ', OLD.peculiarity), NOW());
		
	END $$
	
DELIMITER ;

DROP TRIGGER IF EXISTS beforeDeleteLogFormations;

DELIMITER $$

    -- Este trigger se encarga de borrar las sesiones asociadas a la formacion que se va a eliminar.
	
    CREATE TRIGGER beforeDeleteLogFormations
	
	BEFORE DELETE 
	
	ON formations FOR EACH ROW
	
	BEGIN
	
		DELETE FROM sessions
			WHERE formationID = OLD.formationID;
			
	END $$
	
DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogSessions;

DELIMITER $$
    
    -- Este trigger se encarga de insertar en la tabla DeleteLogs los datos de la fila eliminada de la tabla sessions.

	CREATE TRIGGER addDeleteLogSessions
	
	AFTER DELETE
	
	ON sessions FOR EACH ROW
	
	BEGIN
	
		INSERT INTO DeleteLogs (affectedTable,  dataBeforeDelete, deleteDate) VALUES 
		('sessions', CONCAT('OldSessionID: ', OLD.sessionID, ' | OldDay: ', OLD.day, ' | OldHour: ', OLD.hour, ' | OldCapacity: ', OLD.capacity, ' | OldFormationID: ', OLD.formationID, ' | OldCompanyName: ', OLD.companyName), NOW());

    END $$

DELIMITER ;

DROP TRIGGER IF EXISTS beforeDeleteLogSessions;

DELIMITER $$

    -- Este trigger se encarga de borrar las reservas asociadas a la sesion que se va a eliminar.

    CREATE TRIGGER beforeDeleteLogSessions
    
    BEFORE DELETE
    
    ON sessions FOR EACH ROW
    
    BEGIN
    
        DELETE FROM reservations
            WHERE sessionID = OLD.sessionID;
            
    END $$

DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogCompanies;

DELIMITER $$

    -- Este trigger se encarga de insertar en la tabla DeleteLogs los datos de la fila eliminada de la tabla companies.

    CREATE TRIGGER addDeleteLogCompanies
    
    AFTER DELETE
    
    ON companies FOR EACH ROW
    
    BEGIN
        
        INSERT INTO DeleteLogs (affectedTable,  dataBeforeDelete, deleteDate) VALUES 
        ('companies', CONCAT('OldCIF: ', OLD.CIF, ' | OldName: ', OLD.name, ' | OldAddress: ', OLD.address), NOW());
        
    END $$

DELIMITER ; 

DROP TRIGGER IF EXISTS beforeDeleteLogCompanies;

DELIMITER $$

    -- Este trigger se encarga de borrar las sesiones asociadas a la empresa que se va a eliminar.

    CREATE TRIGGER beforeDeleteLogCompanies
    
    BEFORE DELETE
    
    ON companies FOR EACH ROW
    
    BEGIN
    
        DELETE FROM sessions
            WHERE companyName = OLD.name;
            
    END $$

DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogReservations;

DELIMITER $$

    -- Este trigger se encarga de insertar en la tabla DeleteLogs los datos de la fila eliminada de la tabla reservations.
    
    CREATE TRIGGER addDeleteLogReservations
    AFTER DELETE
    
    ON reservations FOR EACH ROW
    
    BEGIN
        
		INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate) VALUES 
		('reservations', CONCAT('OldReservationID: ', OLD.reservationID, ' | OldUserID: ', OLD.userID, ' | OldSessionID: ', OLD.sessionID), NOW());
    
    END $$
	
DELIMITER ;

DROP TRIGGER IF EXISTS addDeleteLogSuggestions;

DELIMITER $$

    -- este trigger se encarga de insertar en la tabla DeleteLogs los datos de la fila eliminada de la tabla suggestions.
    
    CREATE TRIGGER addDeleteLogSuggestions
    
    AFTER DELETE
    
    ON Suggestions FOR EACH ROW
    
	BEGIN
        
		INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate) VALUES 
		('suggestions', CONCAT('OldSuggestionID: ', OLD.SuggestionID, ' | OldUserEmail: ', OLD.userEmail, ' | OldDescription: ', OLD.description), NOW());
		
    END $$

DELIMITER ;

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
