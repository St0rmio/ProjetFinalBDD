-- AUTHORS : Luc FRANCOIS, Kevin PETIT

DELIMITER $
DROP PROCEDURE IF EXISTS reserver_place_pour_etudiant $
CREATE PROCEDURE reserver_place_pour_etudiant (
	IN p_id_etudiant VARCHAR(10),
    IN p_date_arrivee DATETIME,
    IN p_date_depart DATETIME
)
BEGIN
	DECLARE allee_id INT(11);
    DECLARE place_id INT(11);
    DECLARE cours_existe INT;
    
    IF NOT EXISTS (SELECT * FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant) THEN
		SELECT 'L''étudiant est introuvable' AS message_erreur;
	ELSEIF p_date_arrivee >= p_date_depart THEN
		SELECT 'Date d''arrivée doit être antérieure à la date de départ' AS message_erreur;
	ELSE
    
		-- Verification si l'étudiant a un cours pendant la période de stationnement
		SELECT COUNT(*) INTO cours_existe
		FROM cours_suivi
		INNER JOIN cours ON cours_suivi.id_cours = cours.id_cours
		WHERE cours_suivi.id_etudiant = p_id_etudiant
		AND TIME(p_date_arrivee) BETWEEN cours_suivi.heure_debut AND cours_suivi.heure_fin
		AND TIME(p_date_depart) BETWEEN cours_suivi.heure_debut AND cours_suivi.heure_fin;
		
		IF cours_existe = 0 THEN
			CREATE TABLE IF NOT EXISTS violation_stationnement (
				id_violation INT AUTO_INCREMENT PRIMARY KEY,
				code_permanent VARCHAR(15),
				nom_etudiant VARCHAR(45),
				prenom_etudiant VARCHAR(60),
				numero_plaque VARCHAR(10),
				date_tentative_reservation DATETIME
			);
			
			-- Enregistrement une violation de stationnement
			INSERT INTO violation_stationnement (code_permanent, nom_etudiant, prenom_etudiant, numero_plaque, date_tentative_reservation)
			SELECT code_permanent, nom_etudiant, prenom_etudiant, numero_plaque, NOW()
			FROM etudiant
			WHERE etudiant.id_etudiant = p_id_etudiant;
			
			SELECT 'L''etudiant n''a pas cours dans la tranche horaire souhaitée' AS message;
		ELSE
			SELECT place.id_allee, place.id_place INTO allee_id, place_id
			FROM place
			INNER JOIN allee ON allee.id_allee = place.id_allee
			INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
			INNER JOIN universite ON universite.id_universite = espace_stationnement.id_universite
			WHERE place.disponibilite = 'Oui' AND universite.id_universite = (SELECT etudiant.id_universite FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant)
			LIMIT 1;
			
			IF allee_id IS NULL THEN
				SELECT 'Aucune place disponible' AS message;
			ELSE
				UPDATE place
				SET disponibilite = 'Non'
				WHERE place.id_place = place_id;
				
				-- Ajout d'un enregistrement dans la table place_reservee
				INSERT INTO place_reservee (id_place, id_etudiant, date_heure_debut, date_heure_fin)
				VALUES (place_id, p_id_etudiant, p_date_arrivee, p_date_depart);
				
				-- Afficher les détails de la réservation
				SELECT espace_stationnement.designation_espace_stationnement AS espace_stationnement,
					   allee.designation_allee AS allee,
					   allee.sens_circulation,
					   place.id_place,
					   place.type_de_place,
					   allee.tarif_horaire * TIMESTAMPDIFF(HOUR, p_date_arrivee, p_date_depart) AS montant_a_payer,
					   p_date_arrivee AS date_heure_arrivee,
					   p_date_depart AS date_heure_depart
				FROM espace_stationnement
				INNER JOIN allee ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
				INNER JOIN place ON place.id_allee = allee.id_allee
				WHERE place.id_place = place_id;
			END IF;
		END IF;
	END IF;
END $
DELIMITER ;

DELIMITER $
DROP TRIGGER IF EXISTS actualiser_places_disponibles $
CREATE TRIGGER actualiser_places_disponibles 
AFTER INSERT ON place_reservee
FOR EACH ROW
BEGIN
    DECLARE allee_id INT;
    DECLARE v_nombre_places_dispo INT;
    
    -- Récupérer l'ID de l'allée de la place réservée
    SELECT id_allee INTO allee_id
    FROM place
    WHERE id_place = NEW.id_place;
    
    -- Récupérer le nombre de places disponibles dans l'allée
    SELECT nombre_places_dispo INTO v_nombre_places_dispo
    FROM allee
    WHERE id_allee = allee_id;
    
    -- Actualiser le nombre de places disponibles dans l'allée
    UPDATE allee
    SET nombre_places_dispo = v_nombre_places_dispo - 1
    WHERE id_allee = allee_id;
END $
DELIMITER ;