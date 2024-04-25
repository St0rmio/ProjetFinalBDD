-- Exercice 1

-- Ajout avec un manque dans un champ
CALL ajout_universite('Université du Québec à MontCul', '', '14', 'Rue Montreal', 'Montreal', 'Quebec', '58-EB-5');
CALL ajout_universite('', 'UQAP', '14', 'Rue Montreal', 'Montreal', 'Quebec', '58-EB-5');

-- Ajout correct
CALL ajout_universite('Université du Québec à MontCul', 'UQAP', '14', 'Rue Montreal', 'Montreal', 'Quebec', '58-EB-5');
CALL ajout_universite('Université Laval', 'UL', '2325', 'Rue de l\'U', 'Québec', 'Québec', 'G1V 0A6');


SELECT * FROM universite;
SELECT * FROM espace_stationnement;
SELECT * FROM allee;
SELECT * FROM place;
SELECT * FROM log_aire_stationnement;

-- rajout d'une universite déjà présente
CALL ajout_universite('Université du Québec à MontCul', 'UQAP', '14', 'Rue Montreal', 'Montreal', 'Quebec', '58-EB-5');
CALL ajout_universite('Université Laval', 'UL', '2325', 'Rue de l\'U', 'Québec', 'Québec', 'G1V 0A6');

-- exercice 2

-- créer etudiant
-- champ vide
CALL creer_etudiant('', 'bap', 'baba161605', 'bap4512', 'bap@gamil.com', '8195555555', 1);
-- couriel invalide
CALL creer_etudiant('bap', 'bap', 'baba161605', 'bap4512', 'bap@gamilcom', '8195555555', 1);
CALL creer_etudiant('bap', 'bap', 'baba161605', 'bap4512', 'bapgamil.com', '8195555555', 1);
-- téléphone invalide
CALL creer_etudiant('bap', 'bap', 'baba161605', 'bap4512', 'bap@gamil.com', '81A5555555', 1);
-- Création d'un étudiant avec un id université invalide
CALL creer_etudiant('bap', 'bap', 'baba161605', 'bap4512', 'bap@gamil.com', '8195555555', 400);
-- création d'un étudiant valide
CALL creer_etudiant('bap', 'bap', 'baba161605', 'bap4512', 'bap@gamil.com', '8195555555', 1);
SELECT * FROM etudiant;
-- création du même etudiant
CALL creer_etudiant('bap', 'bap', 'baba161605', 'bap4512', 'bap@gamil.com', '8195555555', 1);

-- affichage de l'étudiant
-- mauvais id 
CALL afficher_etudiant('ETU-00000A');
CALL afficher_etudiant('ETU-000001');

-- modification d'un étudiant
-- champ vide 
CALL mettre_a_jour_etudiant('ETU-000001', '', 'jean', 'jean161605', 'jea4512', 'jean@gamil.com', '5555555555', 1);
-- courriel invalide
CALL mettre_a_jour_etudiant('ETU-000001', 'jean', 'jean', 'jean161605', 'jea4512', 'jeangamil.com', '5555555555', 1);
CALL mettre_a_jour_etudiant('ETU-000001', 'jean', 'jean', 'jean161605', 'jea4512', 'jean@gamilcom', '5555555555', 1);
-- téléphone invalide
CALL mettre_a_jour_etudiant('ETU-000001', 'jean', 'jean', 'jean161605', 'jea4512', 'jean@gamil.com', '5A555555A5', 1);
-- Etudiant introuvable
CALL mettre_a_jour_etudiant('ETU-00000A', 'jean', 'jean', 'jean161605', 'jea4512', 'jean@gamil.com', '5555555555', 1);
-- Mauvais id universite
CALL mettre_a_jour_etudiant('ETU-000001', 'jean', 'jean', 'jean161605', 'jea4512', 'jean@gamil.com', '5555555555', 400);
-- Modification valide
CALL mettre_a_jour_etudiant('ETU-000001', 'jean', 'jean', 'jean161605', 'jea4512', 'jean@gamil.com', '5555555555', 1);

SELECT * FROM etudiant;
SELECT * FROM historique_etudiant;



-- Supprimer d'un étudiant 
-- mauvais id 
CALL supprimer_etudiant('ETU-00000A');
CALL supprimer_etudiant('ETU-000001');
SELECT * FROM etudiant;

-- Création d'autres étudiants
CALL creer_etudiant('test', 'test', 'test31128105', 'ABC123', 'test.test@example.com', '0123456789', 1);
CALL creer_etudiant('test2', 'test2', '2est31128105', '2BC123', '2est.test@example.com', '2123456789', 2);
SELECT * FROM etudiant;


-- Exercice 3

INSERT INTO cours (id_cours, nom_du_cours, nombre_heures)
VALUES (1, 'programmation', 15);
SELECT * FROM cours;

INSERT INTO cours_suivi (id_cours, id_etudiant, `session`, `local`, heure_debut, heure_fin)
VALUES (1, 'ETU-000002', "Hiver", 'P4000', '14:00:00', '17:00:00');
SELECT * FROM cours_suivi;

INSERT INTO cours_suivi (id_cours, id_etudiant, `session`, `local`, heure_debut, heure_fin)
VALUES (1, 'ETU-000003', "Hiver", 'P4000', '14:00:00', '17:00:00');
SELECT * FROM cours_suivi;

-- etudiant introuvable
CALL reserver_place_pour_etudiant ('ETU-A00002', '2024-04-08 14:00:00', '2024-04-08 16:00:00');
-- heure inversée
CALL reserver_place_pour_etudiant ('ETU-000002', '2024-04-08 17:00:00', '2024-04-08 15:00:00');
-- L'étudiant n'a pas cours 
CALL reserver_place_pour_etudiant ('ETU-000002', '2024-04-08 18:00:00', '2024-04-08 19:00:00');
SELECT * FROM violation_stationnement;
-- Réservation valide
CALL reserver_place_pour_etudiant ('ETU-000002', '2024-04-08 14:00:00', '2024-04-08 17:00:00');
SELECT * FROM place;
SELECT * FROM allee;
-- etudiant d'une autre universite (la 2)
CALL reserver_place_pour_etudiant ('ETU-000003', '2024-04-08 14:00:00', '2024-04-08 17:00:00');
SELECT * FROM place;
SELECT * FROM allee;

SELECT * FROM place_reservee;

-- Exercice 4
-- l'id étudiant est testé depuis le début

-- 2
SELECT * FROM informations_aire_stationnement;

-- 3
-- Ajout d'une place réservé après pour voir s'il n'est pas supprimé
CALL reserver_place_pour_etudiant ('ETU-000003', '2024-04-30 14:00:00', '2024-04-30 17:00:00');


-- On a repris le corps de l'event
DELIMITER $
DROP PROCEDURE IF EXISTS exercice43 $
CREATE PROCEDURE exercice43()
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

CALL exercice43();
SELECT * FROM place_reservee;
SELECT * FROM allee;
SELECT * FROM place;



INSERT INTO agent VALUES (42, "Francis", "Michel");
INSERT INTO espace_surveille VALUES (42, 1, '2024-04-30 14:00:00', '2024-04-30 17:00:00');
SELECT * FROM agent;
CALL rapport_aires_de_stationnement();

CREATE DATABASE test_sauvegarde;

SHOW VARIABLES LIKE 'event_scheduler';


SET GLOBAL event_scheduler = ON;

ALTER EVENT mise_à_jour_disponibilite_places
ON COMPLETION PRESERVE
ENABLE;