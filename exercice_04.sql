DELIMITER $
DROP FUNCTION IF EXISTS generate_student_id $
CREATE FUNCTION generate_student_id() RETURNS VARCHAR(10)
BEGIN
    DECLARE new_id VARCHAR(10);
    DECLARE max_suffix INT;
    
    -- Trouver l'identifiant le plus élevé actuellement dans la table etudiant
    SELECT MAX(SUBSTRING(id_etudiant, 5)) INTO max_suffix FROM etudiant;
    
    -- Si la table est vide, commencer à partir de 1
    IF max_suffix IS NULL THEN
        SET max_suffix = 0;
    END IF;
    
    -- Incrémenter le nombre le plus élevé trouvé
    SET max_suffix = max_suffix + 1;
    
    -- Formater le numéro avec des zéros à gauche si nécessaire
    SET new_id = CONCAT('ETU-', LPAD(max_suffix, 6, '0'));
    
    RETURN new_id;
END $
DELIMITER ;

DROP VIEW IF EXISTS informations_aire_stationnement;
CREATE VIEW informations_aire_stationnement AS
SELECT
	universite.nom_universite AS nom_universite,
    espace_stationnement.designation_espace_stationnement AS espace_stationnement,
    allee.designation_allee AS allee,
    allee.nombre_places_dispo AS nombre_places,
    10 - allee.nombre_places_dispo AS nombres_places_reservees
FROM universite
INNER JOIN espace_stationnement ON espace_stationnement.id_universite = universite.id_universite
INNER JOIN allee ON allee.id_espace_stationnement = espace_stationnement.id_espace_stationnement
GROUP BY espace_stationnement.id_espace_stationnement, allee.id_allee;

DELIMITER $
DROP EVENT IF EXISTS mise_à_jour_disponibilite_places $
CREATE EVENT mise_a_jour_disponibilite_places
ON SCHEDULE EVERY 5 MINUTE
DO
BEGIN
	DECLARE v_id_place INT(11);
    DECLARE v_id_allee INT(11);
    DECLARE v_nombre_places_dispo INT;
    DECLARE done INT DEFAULT FALSE;
    
	DECLARE c CURSOR FOR 
    SELECT place.id_place, place.id_allee
    FROM place
    WHERE place.disponibilite = 'Non';
    
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN c;
    boucle : LOOP
		FETCH c INTO v_id_place, v_id_allee;
        IF done THEN
			LEAVE boucle;
		END IF;
        
        IF NOT EXISTS (SELECT * FROM place_reservee WHERE place_reservee.id_place = v_id_place AND place_reservee.date_heure_fin > NOW()) THEN
			UPDATE place
			SET place.disponibilite = 'Oui'
			WHERE place.id_place = v_id_place;
			
            SELECT nombre_places_dispo INTO v_nombre_places_dispo
			FROM allee
			WHERE allee.id_allee = v_id_allee;
            
			UPDATE allee
			SET allee.nombre_places_dispo = v_nombre_places_dispo + 1
			WHERE allee.id_allee = v_id_allee;
		END IF;
	END LOOP boucle;
END $
DELIMITER ;