/*
TRIGGERS para que cada vez que hay un DELETE, meta los datos anteriores un una especie de "BACKUP"
que se guardaran en una tabla llamada DeleteLogs.
*/

DELIMITER $$

    DROP TRIGGER IF EXISTS addDeleteLogUsers;
	
	CREATE TRIGGER addDeleteLogUsers
	
		AFTER DELETE
		
		ON users FOR EACH ROW
		
		BEGIN
		
			DELETE FROM Suggestions
			
				WHERE userEmail = OLD.email;
				
			DELETE FROM reservations SET clientID = NULL 
				
				WHERE clientID = OLD.dni;
				
			INSERT INTO DeleteLogs (affectedTable, dataBeforeDelete, deleteDate) 
			
				VALUES
				('users', CONCAT('OldDNI: ', OLD.dni, ' , OldName: ', OLD.name, ' , OldSurname: ', OLD.surname, ' , OldEmail: ', OLD.email, ' OldPassword: ', OLD.password, ' , OldPhoneNumber: ', OLD.phoneNumber, ' , OldRol: ', OLD.rol), NOW());

		END $$
		
DELIMITER ;