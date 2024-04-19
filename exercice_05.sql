DELIMITER $
DROP PROCEDURE IF EXISTS rapport_aires_de_stationnement $
CREATE PROCEDURE rapport_aires_de_stationnement()
BEGIN
	DECLARE v_id_universite INT(11);
    DECLARE v_nom_universite VARCHAR(45);
    DECLARE v_nb_espaces_stationnement INT DEFAULT 0;
    DECLARE v_nb_agents_surveillance INT DEFAULT 0;
    DECLARE v_nb_allees INT DEFAULT 0;
    DECLARE v_nb_places INT DEFAULT 0;
    DECLARE v_nb_places_handicapes INT DEFAULT 0;
    DECLARE v_nb_places_disponibles INT DEFAULT 0;
    DECLARE v_nb_places_reservees INT DEFAULT 0;
    DECLARE v_nb_reservation_moyen_2023 FLOAT DEFAULT 0;
    DECLARE v_date_max_reservation DATE DEFAULT NULL;
    DECLARE v_date_min_reservation DATE DEFAULT NULL;
    
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR
    SELECT universite.id_universite
    FROM universite;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    boucle : LOOP
		FETCH cur INTO v_id_universite;
		IF done THEN
			LEAVE boucle;
		END IF;
		
        SELECT universite.nom_universite INTO v_nom_universite FROM universite WHERE universite.id_universite = v_id_universite;
        
        SELECT COUNT(espace_stationnement.id_espace_stationnement) INTO v_nb_espaces_stationnement FROM espace_stationnement WHERE espace_stationnement.id_universite = v_id_universite;
        
        SELECT COUNT(distinct agent.id_agent) INTO v_nb_agents_surveillance
        FROM agent
        INNER JOIN espace_surveille ON espace_surveille.id_agent = agent.id_agent
        INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = espace_surveille.id_espace_stationnement
        WHERE espace_stationnement.id_universite = v_id_universite;
        
        SELECT COUNT(distinct allee.id_allee) INTO v_nb_allees
        FROM allee
        INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
        WHERE espace_stationnement.id_universite = v_id_universite;
        
        SELECT COUNT(distinct place.id_place) INTO v_nb_places
        FROM place
        INNER JOIN allee ON allee.id_allee = place.id_allee
        INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
        WHERE espace_stationnement.id_universite = v_id_universite;
        
        SELECT COUNT(distinct place.id_place) INTO v_nb_places_handicapes
        FROM place
        INNER JOIN allee ON allee.id_allee = place.id_allee
        INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
        WHERE espace_stationnement.id_universite = v_id_universite AND type_de_place = 'personnes à mobilité réduite';
        
        
        SELECT COUNT(distinct place.id_place) INTO v_nb_places_disponibles
        FROM place
        INNER JOIN allee ON allee.id_allee = place.id_allee
        INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
        WHERE espace_stationnement.id_universite = v_id_universite AND disponibilite = 'Oui';
        
        SELECT COUNT(distinct place.id_place) INTO v_nb_places_reservees
        FROM place
        INNER JOIN allee ON allee.id_allee = place.id_allee
        INNER JOIN espace_stationnement ON espace_stationnement.id_espace_stationnement = allee.id_espace_stationnement
        WHERE espace_stationnement.id_universite = v_id_universite AND disponibilite = 'Non';
        
        
        SELECT COUNT(DISTINCT place_reservee.id_etudiant) / COUNT(DISTINCT place_reservee.id_place)
        INTO v_nb_reservation_moyen_2023
        FROM place_reservee
        INNER JOIN etudiant ON etudiant.id_etudiant = place_reservee.id_etudiant
        WHERE YEAR(place_reservee.date_heure_debut) = 2023
        AND etudiant.id_universite = v_id_universite;
        
        SELECT DATE(place_reservee.date_heure_debut) AS date_reservation_max
		INTO v_date_max_reservation
		FROM place_reservee
		INNER JOIN etudiant ON etudiant.id_etudiant = place_reservee.id_etudiant
		WHERE etudiant.id_universite = v_id_universite
		GROUP BY DATE(place_reservee.date_heure_debut)
		ORDER BY COUNT(place_reservee.id_etudiant) DESC
		LIMIT 1;
        
		SELECT DATE(place_reservee.date_heure_debut) AS date_reservation_min
		INTO v_date_min_reservation
		FROM place_reservee
		INNER JOIN etudiant ON etudiant.id_etudiant = place_reservee.id_etudiant
		WHERE etudiant.id_universite = v_id_universite
		GROUP BY DATE(place_reservee.date_heure_debut)
		ORDER BY COUNT(place_reservee.id_etudiant) ASC
		LIMIT 1;
		
        SELECT v_id_universite, v_nom_universite, v_nb_espaces_stationnement, v_nb_agents_surveillance, v_nb_allees, v_nb_places, v_nb_places_handicapes, v_nb_places_disponibles, v_nb_places_reservees, v_nb_reservation_moyen_2023, v_date_max_reservation, v_date_min_reservation;
        
    END LOOP boucle;
    CLOSE cur;
END $
DELIMITER ;