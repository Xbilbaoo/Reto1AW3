DROP DATABASE IF EXISTS donostiaKultura;

/*
 * Crear la base de datos y usarla para poder crear las tablas de esta.
*/

CREATE DATABASE donostiaKultura;
USE donostiaKultura;

/*
 * Crear las tablas (teniendo en cuenta las relaciones del esquema entidad-relacion).
*/
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

    /*
     * Creado una CONSTRAINT para relacionar las sugerencias con los usuarios. Usar como FOREIGN el email del
     * cliente, ya que, asi lo requiere el cliente. 
     * 
     * Borrado y actualizado en cascada debido a que el control de ellos se hace a tráves de los triggers.
    */

	CONSTRAINT fk_userEmail FOREIGN KEY (userEmail) REFERENCES users(email)
		ON DELETE CASCADE
		ON UPDATE CASCADE

);

CREATE TABLE companies (
    
    CIF VARCHAR(20) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL UNIQUE, 
    address VARCHAR(250) NOT NULL

);

CREATE TABLE formations (
    
    formationID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,  
    name VARCHAR(50) NOT NULL, 
    description TINYTEXT DEFAULT 'No description available', 
    peculiarity ENUM('english', 'Other'),
    companyID VARCHAR(20),

    /*
     * Crear una CONTRAINT para relacionar las compañias con las formaciones proporcionadas por las mismas. Usar
     * como FOREIGN KEY el CIF de cada compañia, debido a  que es el PRIMARY KEY de su tabla y es el unico valor
     * nulo de la misma.
     * 
     * Borrado y actualizado en cascada debido a que el control de ellos se hace a tráves de los triggers.
    */

    CONSTRAINT fk_companyID FOREIGN KEY (companyID) REFERENCES companies(CIF)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE sessions (
    
    sessionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    day DATE NOT NULL, 
    hour TIME NOT NULL, 
    capacity INT UNSIGNED NOT NULL, 
    formationID INT UNSIGNED NULL, 

    /*
     * Crear una CONSTRAINT para relacionar las formaciones co las sesiones que tienen estas. Usar como FOREING 
     * KEY el ID de la formación.
     * 
     * Borrado y actualizado en cascada debido a que el control de ellos se hace a tráves de los triggers.
    */

	CONSTRAINT fk_formationID FOREIGN KEY (formationID) REFERENCES formations(formationID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE reservations (
    
    reservationID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    userID VARCHAR(9) NULL, 
    sessionID INT UNSIGNED NULL, 

    /*
     * Crear dos CONSTRAINTS para relacionar las reservas con los usuarios que reservan ciertas sesiones. Usar
     * como FOREIGN KEY-s los PRIMARY KEY de cada tabla.
     * 
     * Borrado y actualizado en cascada debido a que el control de ellos se hace a tráves de los triggers.
    */

	CONSTRAINT fk_userID FOREIGN KEY (userID) REFERENCES users(dni)
		ON DELETE CASCADE
        	ON UPDATE CASCADE, 
    
	CONSTRAINT fk_sessionID FOREIGN KEY (sessionID) REFERENCES sessions(sessionID)
        	ON DELETE CASCADE
        	ON UPDATE CASCADE
);

CREATE TABLE deleteLogs (
    actionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    affectedTable ENUM('users', 'reservations', 'sessions', 'formations', 'companies', 'suggestions'), 
    dataBeforeDelete TINYTEXT NOT NULL, 
    deleteDate DATETIME NOT NULL
);

CREATE TABLE updateLogs (
    actionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    affectedTable ENUM('users', 'reservations', 'sessions', 'formations', 'companies','suggestions'), 
    dataBeforeUpdate TINYTEXT NOT NULL, 
    updateDate DATETIME NOT NULL
);

/*
 * Insertar datos ficticios en todas las tablas (Excluyendo las tablas de log).
*/

INSERT INTO users (dni, name, surname, email, password, phoneNumber, rol) VALUES
('12345678A', 'Aitor', 'Lopez', 'aitor.lopez@email.com', 'password123', '600123456', 'admin'),
('23456789B', 'Amaia', 'Garcia', 'amaia.garcia@email.com', 'password123', '600234567', 'user'),
('34567890C', 'Iker', 'Martinez', 'iker.martinez@email.com', 'password123', '600345678', 'user'),
('45678901D', 'Jon', 'Lasa', 'jon.lasa@email.com', 'password123', '600456789', 'user'),
('56789012E', 'Miren', 'Aranburu', 'miren.aranburu@email.com', 'password123', '600567890', 'user'),
('67890123F', 'Nerea', 'Agirre', 'nerea.agirre@email.com', 'password123', '600678901', 'user'),
('78901234G', 'Markel', 'Etxeberria', 'markel.etxeberria@email.com', 'password123', '600789012', 'user'),
('89012345H', 'Irati', 'Zubia', 'irati.zubia@email.com', 'password123', '600890123', 'user'),
('90123456I', 'Ander', 'Aldaz', 'ander.aldaz@email.com', 'password123', '600901234', 'user'),
('01234567J', 'Leire', 'Garmendia', 'leire.garmendia@email.com', 'password123', '600012345', 'user');

INSERT INTO companies (CIF, name, address) VALUES
('B12345678', 'CultureCo', 'Avenida de la Cultura, 1, Donostia'),
('B23456789', 'LearnCorp', 'Calle del Aprendizaje, 23, Donostia'),
('B34567890', 'LanguageHub', 'Plaza del Idioma, 5, Donostia'),
('B45678901', 'CulturalRoots', 'Camino Antiguo, 12, Donostia'),
('B56789012', 'EduAdvance', 'Calle Nueva, 34, Donostia');

INSERT INTO formations (name, description, peculiarity, companyID) VALUES
('Introduction to Basque Culture', 'A course about Basque language and traditions.', 'Other', 'B12345678'),
('Advanced English Workshop', 'High-level English training for professionals.', 'english', 'B23456789'),
('Spanish Language Immersion', 'Intensive Spanish for foreigners.', 'Other', 'B34567890'),
('Cultural Awareness Seminar', 'Understanding local cultures and diversity.', 'Other', 'B45678901'),
('Creative Writing Workshop', 'Writing techniques for storytelling.', 'Other', 'B56789012');

INSERT INTO sessions (day, hour, capacity, formationID) VALUES
('2025-04-10', '10:00:00', 30, 1),
('2025-04-11', '14:00:00', 25, 1),
('2025-04-12', '09:00:00', 20, 2),
('2025-04-13', '15:00:00', 15, 2),
('2025-04-14', '11:00:00', 25, 3),
('2025-04-15', '16:00:00', 20, 3),
('2025-04-16', '08:00:00', 30, 4),
('2025-04-17', '10:00:00', 30, 4),
('2025-04-18', '12:00:00', 15, 5),
('2025-04-19', '17:00:00', 10, 5);

INSERT INTO reservations (userID, sessionID) VALUES
('12345678A', 1),
('23456789B', 2),
('34567890C', 3),
('45678901D', 4),
('56789012E', 5),
('67890123F', 6),
('78901234G', 7),
('89012345H', 8),
('90123456I', 9),
('01234567J', 10);

INSERT INTO suggestions (description, userEmail, suggestionDate) VALUES
('Would love to see more workshops related to local history.', 'aitor.lopez@email.com', '2025-04-01'),
('Can you organize online sessions for English training?', 'amaia.garcia@email.com', '2025-04-02'),
('It would be great if sessions were available on weekends.', 'iker.martinez@email.com', '2025-04-03'),
('More workshops on Basque folklore would be nice.', 'jon.lasa@email.com', '2025-04-04'),
('Can you provide materials after the sessions?', 'miren.aranburu@email.com', '2025-04-05'),
('Sessions during evenings would be helpful.', 'nerea.agirre@email.com', '2025-04-06'),
('I would love to see cultural tours as well.', 'markel.etxeberria@email.com', '2025-04-07'),
('Could you do a workshop focused on local gastronomy?', 'irati.zubia@email.com', '2025-04-08'),
('Consider adding free trial sessions for new members.', 'ander.aldaz@email.com', '2025-04-09'),
('More weekend events, please!', 'leire.garmendia@email.com', '2025-04-10');