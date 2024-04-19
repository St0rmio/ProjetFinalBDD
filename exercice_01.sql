DELIMITER $
DROP PROCEDURE IF EXISTS ajout_universite $
CREATE PROCEDURE ajout_universite(
	IN param_nom_universite VARCHAR(45),
    IN param_sigle VARCHAR(10),
    IN param_numero_civique VARCHAR(5),
    IN param_nom_rue VARCHAR(15),
    IN param_ville VARCHAR(45),
    IN param_province ENUM('Alberta','Colombie-Britannique','Île-du-Prince-Édouard','Manitoba','Nouveau-Brunswick','Nouvelle-Écosse','Ontario','Québec','Saskatchewan','Terre-Neuve-et-Labrador','Territoires du Nord-Ouest','Nunavut','Yukon'),
    IN param_code_postal VARCHAR(7)
)
BEGIN
	DECLARE id_universite INT(11);
    DECLARE id_espace_stationnement INT(11);
    DECLARE id_allee INT(11);
    DECLARE id_place INT(11);
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE k INT DEFAULT 1;
    
    -- Création d'un nouvelle université dans la table universite.
    INSERT INTO universite (nom_universite, sigle, numero_civique, nom_rue, ville, province, code_postal)
    VALUES (param_nom_universite, param_sigle, param_numero_civique, param_nom_rue, param_ville, param_province, param_code_postal);
    
    -- Récupération de l'identifiant de la nouvelle université.
    SET id_universite = LAST_INSERT_ID();
    
    -- Création d'un espace de stationnement de la nouvelle université.
    INSERT INTO espace_stationnement (designation_espace_stationnement, id_universite)
    VALUES (CONCAT('Parking de', ' ', param_sigle), id_universite);
    
    -- Récupération de l'identifiant de l'espace de stationnement.
    SET id_espace_stationnement = LAST_INSERT_ID();
    
    -- Boucle while pour créer 3 nouvelles allées au nouvel espace de stationnement.
    WHILE i <= 3 DO
        -- Création d'une nouvelle allée.
		INSERT INTO allee (id_espace_stationnement, designation_allee, sens_circulation, nombre_places_dispo, tarif_horaire)
        VALUES (id_espace_stationnement, CONCAT('Allee ', i), CASE i
																			WHEN 1 THEN 'Entrée'
                                                                            WHEN 2 THEN 'Sortie'
                                                                            WHEN 3 THEN 'Bidirectionnel'
																		END, 10, 4.5);
		set i = i + 1;
    END WHILE;
    
    -- Création des places dans les différentes allées.
    WHILE j <= 3 DO
		SELECT allee.id_allee INTO id_allee FROM allee WHERE allee.id_espace_stationnement = id_espace_stationnement AND allee.designation_allee = CONCAT('Allee ', j);
        WHILE k <= 2 DO
            -- Creation d'une place pour personne à mobilité réduite.
            INSERT INTO place (type_de_place, id_allee, disponibilite)
            VALUES ('personnes à mobilité réduite', id_allee, 'oui');
            
            set k = k + 1;
        END WHILE;
        set k = 1;
        
        WHILE k <= 2 DO
			-- Récupération de l'identifiant de la prochaine place.
			SELECT IFNULL(MAX(place.id_place) + 1, 1) INTO id_place FROM place;
            
            -- Creation d'une place pour véhicules électriques.
            INSERT INTO place (type_de_place, id_allee, disponibilite)
            VALUES ('véhicules électriques', id_allee, 'oui');
            
            set k = k + 1;
        END WHILE;
        set k = 1;
        
        WHILE k <= 6 DO
            -- Creation d'une place standard.
            INSERT INTO place (type_de_place, id_allee, disponibilite)
            VALUES ('standard', id_allee, 'oui');
            
            set k = k + 1;
        END WHILE;
        
        set k = 1;
        set j = j + 1;
    END WHILE;
    
END $
DELIMITER ;


DELIMITER $
CREATE TABLE IF NOT EXISTS log_aire_stationnement (id_log INT(11) AUTO_INCREMENT PRIMARY KEY, nom_universite VARCHAR(45), sigle_universite VARCHAR(10), date_heure_tentative DATETIME) $
DROP TRIGGER IF EXISTS log_creation_espace_stationnement $
CREATE TRIGGER log_creation_espace_stationnement
AFTER INSERT ON espace_stationnement
FOR EACH ROW
BEGIN
	DECLARE nom_universite VARCHAR(45);
    DECLARE sigle_universite VARCHAR(10);
    
    SELECT universite.nom_universite, universite.sigle INTO nom_universite, sigle_universite FROM universite WHERE universite.id_universite = NEW.id_universite;
    
    INSERT INTO log_aire_stationnement (nom_universite, sigle_universite, date_heure_tentative)
    VALUES (nom_universite, sigle_universite, NOW());

END $
DELIMITER ;