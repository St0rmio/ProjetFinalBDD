-- AUTHORS : Luc FRANCOIS, Kevin PETIT
-- ----------------------------------------------------------------------------------------------------------------------------------
DELIMITER $
DROP PROCEDURE IF EXISTS creer_etudiant $
CREATE PROCEDURE creer_etudiant (
	IN p_nom_etudiant VARCHAR(45),
    IN p_prenom_etudiant VARCHAR(60),
    IN p_code_permanent VARCHAR(15),
    IN p_numero_plaque VARCHAR(10),
    IN p_courriel_etudiant VARCHAR(55),
    IN p_telephone_etudiant VARCHAR(10),
    IN p_id_universite INT(11)
)
BEGIN
	DECLARE id_etudiant VARCHAR(10);

	IF p_nom_etudiant = '' OR p_prenom_etudiant = '' OR p_code_permanent = '' OR p_numero_plaque = '' OR p_courriel_etudiant = '' OR p_telephone_etudiant = '' THEN
		SELECT 'Tous les champs doivent être remplis.' AS message_erreur;
	ELSEIF NOT p_courriel_etudiant REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$' THEN
		SELECT 'Le format du courriel est invalide.' AS message_erreur;
	ELSEIF NOT p_telephone_etudiant REGEXP '^[0-9]{10}$' THEN
		SELECT 'Le format du numéro de téléphone est invalide' AS message_erreur;
	ELSEIF EXISTS (SELECT * FROM etudiant WHERE etudiant.code_permanent = p_code_permanent) THEN
		SELECT 'Un étudiant avec ce code permanent existe déjà.' AS message_erreur;
	ELSEIF NOT EXISTS (SELECT * FROM universite WHERE universite.id_universite = p_id_universite) THEN
		SELECT 'L''id de l''université n''existe pas' AS message_erreur;
	ELSE
        -- Création de l'id de l'étudiant.
		SET id_etudiant = generate_student_id();
    
		-- Insertion de l'étudiant.
		INSERT INTO etudiant(id_etudiant, nom_etudiant, prenom_etudiant, code_permanent, numero_plaque, courriel_etudiant, telephone_etudiant, supprime, id_universite)
		VALUES (id_etudiant, p_nom_etudiant, p_prenom_etudiant, p_code_permanent, p_numero_plaque, p_courriel_etudiant, p_telephone_etudiant, 0, p_id_universite);
	END IF;
END $
DELIMITER ;



-- ----------------------------------------------------------------------------------------------------------------------------------
DELIMITER $
DROP PROCEDURE IF EXISTS afficher_etudiant $
CREATE PROCEDURE afficher_etudiant (
	p_id_etudiant VARCHAR(10)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant) THEN
		SELECT 'Aucun étudiant trouvé avec cet identifiant.' AS message;
	ELSE
		SELECT * FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant;
	END IF;
END $
DELIMITER ;



-- ----------------------------------------------------------------------------------------------------------------------------------
DELIMITER $
DROP PROCEDURE IF EXISTS mettre_a_jour_etudiant $
CREATE PROCEDURE mettre_a_jour_etudiant (
	IN p_id_etudiant VARCHAR(10),
	IN p_nom_etudiant VARCHAR(45),
    IN p_prenom_etudiant VARCHAR(60),
    IN p_code_permanent VARCHAR(15),
    IN p_numero_plaque VARCHAR(10),
    IN p_courriel_etudiant VARCHAR(55),
    IN p_telephone_etudiant VARCHAR(10),
    IN p_id_universite INT(11)
)
BEGIN

	IF p_nom_etudiant = '' OR p_prenom_etudiant = '' OR p_code_permanent = '' OR p_numero_plaque = '' OR p_courriel_etudiant = '' OR p_telephone_etudiant = '' THEN
		SELECT 'Tous les champs doivent être remplis.' AS message_erreur;
	ELSEIF NOT p_courriel_etudiant REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$' THEN
		SELECT 'Le format du courriel est invalide.' AS message_erreur;
	ELSEIF NOT p_telephone_etudiant REGEXP '^[0-9]{10}$' THEN
		SELECT 'Le format du numéro de téléphone est invalide' AS message_erreur;
	ELSEIF NOT EXISTS (SELECT * FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant) THEN
		SELECT 'Aucun étudiant trouvé avec cet id.' AS message_erreur;
	ELSEIF NOT EXISTS (SELECT * FROM universite WHERE universite.id_universite = p_id_universite) THEN
		SELECT 'L''id de l''université n''existe pas' AS message_erreur;
	else
		UPDATE etudiant
		SET nom_etudiant = p_nom_etudiant, prenom_etudiant = p_prenom_etudiant, code_permanent = p_code_permanent, 
			numero_plaque = p_numero_plaque, courriel_etudiant = p_courriel_etudiant, telephone_etudiant = p_telephone_etudiant, 
			id_universite = p_id_universite
		WHERE id_etudiant = p_id_etudiant;
	END IF;
END $
DELIMITER ;



-- ----------------------------------------------------------------------------------------------------------------------------------
DELIMITER $
CREATE TABLE IF NOT EXISTS historique_etudiant (
    id_historique INT AUTO_INCREMENT PRIMARY KEY,
    id_etudiant VARCHAR(10),
    ancien_nom_etudiant VARCHAR(45),
    ancien_prenom_etudiant VARCHAR(60),
    ancien_code_permanent VARCHAR(15),
    ancien_numero_plaque VARCHAR(10),
    ancien_courriel_etudiant VARCHAR(55),
    ancien_telephone_etudiant VARCHAR(10),
    ancien_id_universite INT,
    date_modification DATETIME
) $
DROP TRIGGER IF EXISTS log_mettre_a_jour_etudiant $
CREATE TRIGGER log_mettre_a_jour_etudiant 
AFTER UPDATE ON etudiant
FOR EACH ROW
BEGIN
	INSERT INTO historique_etudiant (id_etudiant, ancien_nom_etudiant, ancien_prenom_etudiant, ancien_code_permanent, ancien_numero_plaque, ancien_courriel_etudiant, ancien_telephone_etudiant, ancien_id_universite, date_modification)
    VALUES (OLD.id_etudiant, OLD.nom_etudiant, OLD.prenom_etudiant, OLD.code_permanent, OLD.numero_plaque, OLD.courriel_etudiant, OLD.telephone_etudiant, OLD.id_universite, NOW());
END $
DELIMITER ;




DELIMITER $
DROP PROCEDURE IF EXISTS supprimer_etudiant $
CREATE PROCEDURE supprimer_etudiant (
	IN p_id_etudiant VARCHAR(10)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM etudiant WHERE id_etudiant = p_id_etudiant) THEN
		SELECT 'Aucun étudiant trouvé avec cet identifiant.' AS message_erreur;
	else
		UPDATE etudiant SET supprime = 1 WHERE id_etudiant = p_id_etudiant;
    END IF;
END $
DELIMITER ;