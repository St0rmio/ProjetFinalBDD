-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: projet_final_8trd151
-- ------------------------------------------------------
-- Server version	5.7.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agent`
--

DROP TABLE IF EXISTS `agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agent` (
  `id_agent` int(11) NOT NULL AUTO_INCREMENT,
  `nom_agent` varchar(45) NOT NULL,
  `prenom_agent` varchar(60) NOT NULL,
  PRIMARY KEY (`id_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent`
--

LOCK TABLES `agent` WRITE;
/*!40000 ALTER TABLE `agent` DISABLE KEYS */;
/*!40000 ALTER TABLE `agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allee`
--

DROP TABLE IF EXISTS `allee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allee` (
  `id_allee` int(11) NOT NULL AUTO_INCREMENT,
  `id_espace_stationnement` int(11) NOT NULL,
  `designation_allee` varchar(45) NOT NULL,
  `sens_circulation` enum('Entrée','Sortie','Bidirectionnel') NOT NULL,
  `nombre_places_dispo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `tarif_horaire` float NOT NULL DEFAULT '4.5',
  PRIMARY KEY (`id_allee`),
  UNIQUE KEY `nom_allee_espace` (`designation_allee`,`id_espace_stationnement`),
  KEY `allee_ibfk_1` (`id_espace_stationnement`),
  CONSTRAINT `allee_ibfk_1` FOREIGN KEY (`id_espace_stationnement`) REFERENCES `espace_stationnement` (`id_espace_stationnement`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allee`
--

LOCK TABLES `allee` WRITE;
/*!40000 ALTER TABLE `allee` DISABLE KEYS */;
/*!40000 ALTER TABLE `allee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cours` (
  `id_cours` int(11) NOT NULL AUTO_INCREMENT,
  `nom_du_cours` varchar(65) NOT NULL,
  `nombre_heures` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_cours`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cours`
--

LOCK TABLES `cours` WRITE;
/*!40000 ALTER TABLE `cours` DISABLE KEYS */;
/*!40000 ALTER TABLE `cours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cours_suivi`
--

DROP TABLE IF EXISTS `cours_suivi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cours_suivi` (
  `id_cours` int(11) NOT NULL,
  `id_etudiant` varchar(10) NOT NULL,
  `session` varchar(50) NOT NULL,
  `local` varchar(45) NOT NULL,
  `heure_debut` time NOT NULL,
  `heure_fin` time NOT NULL,
  PRIMARY KEY (`id_cours`,`id_etudiant`,`session`),
  KEY `cours_suivi_ibfk_2_idx` (`id_etudiant`),
  CONSTRAINT `cours_suivi_ibfk_1` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id_cours`),
  CONSTRAINT `cours_suivi_ibfk_2` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cours_suivi`
--

LOCK TABLES `cours_suivi` WRITE;
/*!40000 ALTER TABLE `cours_suivi` DISABLE KEYS */;
/*!40000 ALTER TABLE `cours_suivi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espace_stationnement`
--

DROP TABLE IF EXISTS `espace_stationnement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espace_stationnement` (
  `id_espace_stationnement` int(11) NOT NULL AUTO_INCREMENT,
  `designation_espace_stationnement` varchar(45) NOT NULL,
  `id_universite` int(11) NOT NULL,
  PRIMARY KEY (`id_espace_stationnement`),
  UNIQUE KEY `designation_par_uni` (`designation_espace_stationnement`,`id_universite`),
  KEY `espace_stationnement_ibfk_1` (`id_universite`),
  CONSTRAINT `espace_stationnement_ibfk_1` FOREIGN KEY (`id_universite`) REFERENCES `universite` (`id_universite`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espace_stationnement`
--

LOCK TABLES `espace_stationnement` WRITE;
/*!40000 ALTER TABLE `espace_stationnement` DISABLE KEYS */;
/*!40000 ALTER TABLE `espace_stationnement` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_creation_espace_stationnement
BEFORE INSERT ON espace_stationnement
FOR EACH ROW
BEGIN
	DECLARE nom_universite VARCHAR(45);
    DECLARE sigle_universite VARCHAR(10);
    
    SELECT universite.nom_universite, universite.sigle INTO nom_universite, sigle_universite FROM universite WHERE universite.id_universite = NEW.id_universite;
    
    INSERT INTO log_aire_stationnement (nom_universite, sigle_universite, date_heure_tentative)
    VALUES (nom_universite, sigle_universite, NOW());

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `espace_surveille`
--

DROP TABLE IF EXISTS `espace_surveille`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espace_surveille` (
  `id_agent` int(11) NOT NULL,
  `id_espace_stationnement` int(11) NOT NULL,
  `date_heure_debut_surveillance` datetime NOT NULL,
  `date_heure_fin_surveillance` datetime NOT NULL,
  PRIMARY KEY (`id_agent`,`id_espace_stationnement`,`date_heure_debut_surveillance`),
  KEY `id_espace_stationnement` (`id_espace_stationnement`),
  CONSTRAINT `espace_surveille_ibfk_1` FOREIGN KEY (`id_agent`) REFERENCES `agent` (`id_agent`),
  CONSTRAINT `espace_surveille_ibfk_2` FOREIGN KEY (`id_espace_stationnement`) REFERENCES `espace_stationnement` (`id_espace_stationnement`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espace_surveille`
--

LOCK TABLES `espace_surveille` WRITE;
/*!40000 ALTER TABLE `espace_surveille` DISABLE KEYS */;
/*!40000 ALTER TABLE `espace_surveille` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant` (
  `id_etudiant` varchar(10) NOT NULL,
  `nom_etudiant` varchar(45) NOT NULL,
  `prenom_etudiant` varchar(60) NOT NULL,
  `code_permanent` varchar(15) NOT NULL COMMENT 'CONE31128105',
  `numero_plaque` varchar(10) NOT NULL,
  `courriel_etudiant` varchar(55) NOT NULL,
  `telephone_etudiant` varchar(10) NOT NULL,
  `supprime` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `id_universite` int(11) NOT NULL,
  PRIMARY KEY (`id_etudiant`),
  UNIQUE KEY `courriel_etudiant_UNIQUE` (`courriel_etudiant`),
  UNIQUE KEY `telephone_etudiant_UNIQUE` (`telephone_etudiant`),
  UNIQUE KEY `code_permanent_UNIQUE` (`code_permanent`),
  KEY `universite_fk_idx` (`id_universite`),
  CONSTRAINT `universite_fk` FOREIGN KEY (`id_universite`) REFERENCES `universite` (`id_universite`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant`
--

LOCK TABLES `etudiant` WRITE;
/*!40000 ALTER TABLE `etudiant` DISABLE KEYS */;
/*!40000 ALTER TABLE `etudiant` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER log_mettre_a_jour_etudiant 
AFTER UPDATE ON etudiant
FOR EACH ROW
BEGIN
	INSERT INTO historique_etudiant (id_etudiant, ancien_nom_etudiant, ancien_prenom_etudiant, ancien_code_permanent, ancien_numero_plaque, ancien_courriel_etudiant, ancien_telephone_etudiant, ancien_id_universite, date_modification)
    VALUES (OLD.id_etudiant, OLD.nom_etudiant, OLD.prenom_etudiant, OLD.code_permanent, OLD.numero_plaque, OLD.courriel_etudiant, OLD.telephone_etudiant, OLD.id_universite, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `historique_etudiant`
--

DROP TABLE IF EXISTS `historique_etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historique_etudiant` (
  `id_historique` int(11) NOT NULL AUTO_INCREMENT,
  `id_etudiant` varchar(10) DEFAULT NULL,
  `ancien_nom_etudiant` varchar(45) DEFAULT NULL,
  `ancien_prenom_etudiant` varchar(60) DEFAULT NULL,
  `ancien_code_permanent` varchar(15) DEFAULT NULL,
  `ancien_numero_plaque` varchar(10) DEFAULT NULL,
  `ancien_courriel_etudiant` varchar(55) DEFAULT NULL,
  `ancien_telephone_etudiant` varchar(10) DEFAULT NULL,
  `ancien_id_universite` int(11) DEFAULT NULL,
  `date_modification` datetime DEFAULT NULL,
  PRIMARY KEY (`id_historique`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historique_etudiant`
--

LOCK TABLES `historique_etudiant` WRITE;
/*!40000 ALTER TABLE `historique_etudiant` DISABLE KEYS */;
/*!40000 ALTER TABLE `historique_etudiant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `informations_aire_stationnement`
--

DROP TABLE IF EXISTS `informations_aire_stationnement`;
/*!50001 DROP VIEW IF EXISTS `informations_aire_stationnement`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `informations_aire_stationnement` AS SELECT 
 1 AS `nom_universite`,
 1 AS `espace_stationnement`,
 1 AS `allee`,
 1 AS `nombre_places`,
 1 AS `nombres_places_reservees`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `log_aire_stationnement`
--

DROP TABLE IF EXISTS `log_aire_stationnement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_aire_stationnement` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `nom_universite` varchar(45) DEFAULT NULL,
  `sigle_universite` varchar(10) DEFAULT NULL,
  `date_heure_tentative` datetime DEFAULT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_aire_stationnement`
--

LOCK TABLES `log_aire_stationnement` WRITE;
/*!40000 ALTER TABLE `log_aire_stationnement` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_aire_stationnement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place` (
  `id_place` int(11) NOT NULL AUTO_INCREMENT,
  `type_de_place` enum('standard','personnes à mobilité réduite','véhicules électriques') NOT NULL,
  `id_allee` int(11) NOT NULL,
  `disponibilite` enum('Oui','Non') NOT NULL,
  PRIMARY KEY (`id_place`),
  KEY `place_ibfk_1` (`id_allee`),
  CONSTRAINT `place_ibfk_1` FOREIGN KEY (`id_allee`) REFERENCES `allee` (`id_allee`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place`
--

LOCK TABLES `place` WRITE;
/*!40000 ALTER TABLE `place` DISABLE KEYS */;
/*!40000 ALTER TABLE `place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place_reservee`
--

DROP TABLE IF EXISTS `place_reservee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place_reservee` (
  `id_place` int(11) NOT NULL AUTO_INCREMENT,
  `id_etudiant` varchar(10) NOT NULL,
  `date_heure_debut` datetime NOT NULL,
  `date_heure_fin` datetime NOT NULL,
  PRIMARY KEY (`id_place`,`id_etudiant`,`date_heure_debut`),
  KEY `place_reservee_ibfk_2_idx` (`id_etudiant`),
  CONSTRAINT `place_reservee_ibfk_1` FOREIGN KEY (`id_place`) REFERENCES `place` (`id_place`),
  CONSTRAINT `place_reservee_ibfk_2` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place_reservee`
--

LOCK TABLES `place_reservee` WRITE;
/*!40000 ALTER TABLE `place_reservee` DISABLE KEYS */;
/*!40000 ALTER TABLE `place_reservee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER actualiser_places_disponibles 
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `universite`
--

DROP TABLE IF EXISTS `universite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universite` (
  `id_universite` int(11) NOT NULL AUTO_INCREMENT,
  `nom_universite` varchar(45) NOT NULL,
  `sigle` varchar(10) NOT NULL,
  `numero_civique` varchar(5) NOT NULL,
  `nom_rue` varchar(15) NOT NULL,
  `ville` varchar(45) NOT NULL,
  `province` enum('Alberta','Colombie-Britannique','Île-du-Prince-Édouard','Manitoba','Nouveau-Brunswick','Nouvelle-Écosse','Ontario','Québec','Saskatchewan','Terre-Neuve-et-Labrador','Territoires du Nord-Ouest','Nunavut','Yukon') NOT NULL DEFAULT 'Québec',
  `code_postal` varchar(7) NOT NULL,
  PRIMARY KEY (`id_universite`),
  UNIQUE KEY `nom_universite_UNIQUE` (`nom_universite`),
  UNIQUE KEY `sigle_UNIQUE` (`sigle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universite`
--

LOCK TABLES `universite` WRITE;
/*!40000 ALTER TABLE `universite` DISABLE KEYS */;
/*!40000 ALTER TABLE `universite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'projet_final_8trd151'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `mise_à_jour_disponibilite_places` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `mise_à_jour_disponibilite_places` ON SCHEDULE EVERY 5 MINUTE STARTS '2024-04-25 17:22:53' ON COMPLETION PRESERVE ENABLE DO BEGIN
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
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'projet_final_8trd151'
--
/*!50003 DROP FUNCTION IF EXISTS `generate_student_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `generate_student_id`() RETURNS varchar(10) CHARSET latin1
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `afficher_etudiant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `afficher_etudiant`(
	p_id_etudiant VARCHAR(10)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant) THEN
		SELECT 'Aucun étudiant trouvé avec cet identifiant.' AS message;
	ELSE
		SELECT * FROM etudiant WHERE etudiant.id_etudiant = p_id_etudiant;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ajout_universite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajout_universite`(
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
    
    IF param_nom_universite = '' OR param_sigle = '' OR param_numero_civique = '' OR param_nom_rue = '' OR param_ville = '' OR param_code_postal = '' THEN
		SELECT 'Tous les champs doivent être remplis.' AS message_erreur;
	ELSEIF EXISTS (SELECT * FROM universite WHERE universite.nom_universite = param_nom_universite AND universite.sigle = param_sigle) THEN
		SELECT 'L''université existe déjà.' AS message_erreur;
	ELSE
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
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `creer_etudiant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `creer_etudiant`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mettre_a_jour_etudiant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mettre_a_jour_etudiant`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rapport_aires_de_stationnement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rapport_aires_de_stationnement`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reserver_place_pour_etudiant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reserver_place_pour_etudiant`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `supprimer_etudiant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `supprimer_etudiant`(
	IN p_id_etudiant VARCHAR(10)
)
BEGIN
	IF NOT EXISTS (SELECT * FROM etudiant WHERE id_etudiant = p_id_etudiant) THEN
		SELECT 'Aucun étudiant trouvé avec cet identifiant.' AS message_erreur;
	else
		UPDATE etudiant SET supprime = 1 WHERE id_etudiant = p_id_etudiant;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `informations_aire_stationnement`
--

/*!50001 DROP VIEW IF EXISTS `informations_aire_stationnement`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `informations_aire_stationnement` AS select `universite`.`nom_universite` AS `nom_universite`,`espace_stationnement`.`designation_espace_stationnement` AS `espace_stationnement`,`allee`.`designation_allee` AS `allee`,`allee`.`nombre_places_dispo` AS `nombre_places`,(10 - `allee`.`nombre_places_dispo`) AS `nombres_places_reservees` from ((`universite` join `espace_stationnement` on((`espace_stationnement`.`id_universite` = `universite`.`id_universite`))) join `allee` on((`allee`.`id_espace_stationnement` = `espace_stationnement`.`id_espace_stationnement`))) group by `espace_stationnement`.`id_espace_stationnement`,`allee`.`id_allee` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-25 17:30:02
