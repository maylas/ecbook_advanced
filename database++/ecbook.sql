-- MySQL Script generated by MySQL Workbench
-- 03/27/15 11:12:20
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ecbookdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecbookdb` ;

-- -----------------------------------------------------
-- Schema ecbookdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecbookdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ecbookdb` ;

-- -----------------------------------------------------
-- Table `ecbookdb`.`Benutzergruppe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Benutzergruppe` (
  `bg_id` INT NOT NULL,
  `bg_name` VARCHAR(45) NULL,
  PRIMARY KEY (`bg_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Person` (
  `p_nachname` VARCHAR(45) NOT NULL,
  `p_vorname` VARCHAR(45) NOT NULL,
  `p_geburtsdatum` VARCHAR(45) NOT NULL,
  `p_wohnort` VARCHAR(45) NULL,
  `p_plz` VARCHAR(45) NULL,
  `p_ort` VARCHAR(45) NULL,
  `p_wohnadresse` VARCHAR(45) NULL,
  `p_telefonnummer` VARCHAR(45) NULL,
  `l_benutzername` VARCHAR(45) NOT NULL,
  `l_passwort` VARCHAR(45) NOT NULL,
  `Benutzergruppe_bg_id` INT NOT NULL,
  PRIMARY KEY (`p_nachname`, `p_vorname`, `p_geburtsdatum`),
  INDEX `fk_Person_Benutzergruppe1_idx` (`Benutzergruppe_bg_id` ASC),
  CONSTRAINT `fk_Person_Benutzergruppe1`
    FOREIGN KEY (`Benutzergruppe_bg_id`)
    REFERENCES `ecbookdb`.`Benutzergruppe` (`bg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Lehrer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Lehrer` (
  `l_lehrerid` INT NOT NULL,
  `l_istklassenvorstand` TINYINT(1) NULL,
  `p_nachname` INT NOT NULL,
  `p_vorname` VARCHAR(45) NOT NULL,
  `p_geburtsdatum` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`l_lehrerid`),
  INDEX `fk_Lehrer_Person1_idx` (`p_nachname` ASC, `p_vorname` ASC, `p_geburtsdatum` ASC),
  CONSTRAINT `fk_Lehrer_Person1`
    FOREIGN KEY (`p_nachname` , `p_vorname` , `p_geburtsdatum`)
    REFERENCES `ecbookdb`.`Person` (`p_nachname` , `p_vorname` , `p_geburtsdatum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Abteilung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Abteilung` (
  `abt_bezeichnung` VARCHAR(45) NOT NULL,
  `abt_kuerzel` VARCHAR(45) NOT NULL,
  `abt_vorstand` VARCHAR(45) NULL,
  `Lehrer_l_lehrerid` INT NOT NULL,
  PRIMARY KEY (`abt_bezeichnung`),
  INDEX `fk_Abteilung_Lehrer1_idx` (`Lehrer_l_lehrerid` ASC),
  CONSTRAINT `fk_Abteilung_Lehrer1`
    FOREIGN KEY (`Lehrer_l_lehrerid`)
    REFERENCES `ecbookdb`.`Lehrer` (`l_lehrerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Schulform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Schulform` (
  `schf_id` INT NOT NULL,
  `schf_zweig` VARCHAR(45) NULL,
  `schf_modulanforderung` TINYINT(1) NOT NULL,
  PRIMARY KEY (`schf_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Klasse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Klasse` (
  `k_name` VARCHAR(45) NOT NULL,
  `k_jahrgang` VARCHAR(45) NULL,
  `k_abschlussjahr` VARCHAR(45) NULL,
  `k_schueleranzahl` INT NULL,
  `k_abt_bezeichnung` VARCHAR(45) NOT NULL,
  `k_semester` TIMESTAMP(0) NULL,
  `Schulform_schf_id` INT NOT NULL,
  PRIMARY KEY (`k_name`),
  INDEX `fk_Klasse_Abteilung1_idx` (`k_abt_bezeichnung` ASC),
  INDEX `fk_Klasse_Schulform1_idx` (`Schulform_schf_id` ASC),
  CONSTRAINT `fk_Klasse_Abteilung1`
    FOREIGN KEY (`k_abt_bezeichnung`)
    REFERENCES `ecbookdb`.`Abteilung` (`abt_bezeichnung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Klasse_Schulform1`
    FOREIGN KEY (`Schulform_schf_id`)
    REFERENCES `ecbookdb`.`Schulform` (`schf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Eltern`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Eltern` (
  `e_id` VARCHAR(45) NOT NULL,
  `Person_p_nachname` VARCHAR(45) NOT NULL,
  `Person_p_vorname` VARCHAR(45) NOT NULL,
  `Person_p_geburtsdatum` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`e_id`),
  INDEX `fk_Eltern_Person1_idx` (`Person_p_nachname` ASC, `Person_p_vorname` ASC, `Person_p_geburtsdatum` ASC),
  CONSTRAINT `fk_Eltern_Person1`
    FOREIGN KEY (`Person_p_nachname` , `Person_p_vorname` , `Person_p_geburtsdatum`)
    REFERENCES `ecbookdb`.`Person` (`p_nachname` , `p_vorname` , `p_geburtsdatum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Schueler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Schueler` (
  `s_schuelernummer` INT NOT NULL,
  `s_religionsbekenntnis` VARCHAR(45) NULL,
  `s_istklassensprecher` TINYINT(1) NOT NULL,
  `p_nachname` INT NOT NULL,
  `p_vorname` VARCHAR(45) NOT NULL,
  `p_geburtsdatum` VARCHAR(45) NOT NULL,
  `k_name` VARCHAR(45) NOT NULL,
  `Eltern_e_id` VARCHAR(45) NOT NULL,
  `Schuelercol` VARCHAR(45) NULL,
  PRIMARY KEY (`s_schuelernummer`),
  INDEX `fk_Schueler_Person_idx` (`p_nachname` ASC, `p_vorname` ASC, `p_geburtsdatum` ASC),
  INDEX `fk_Schueler_Klasse1_idx` (`k_name` ASC),
  INDEX `fk_Schueler_Eltern1_idx` (`Eltern_e_id` ASC),
  CONSTRAINT `fk_Schueler_Person`
    FOREIGN KEY (`p_nachname` , `p_vorname` , `p_geburtsdatum`)
    REFERENCES `ecbookdb`.`Person` (`p_nachname` , `p_vorname` , `p_geburtsdatum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schueler_Klasse1`
    FOREIGN KEY (`k_name`)
    REFERENCES `ecbookdb`.`Klasse` (`k_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schueler_Eltern1`
    FOREIGN KEY (`Eltern_e_id`)
    REFERENCES `ecbookdb`.`Eltern` (`e_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Unterrichtsfach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Unterrichtsfach` (
  `uf_bezeichnung` VARCHAR(45) NOT NULL,
  `uf_kurzbezeichnung` VARCHAR(45) NOT NULL,
  `uf_jahrgang` VARCHAR(45) NULL,
  `uf_stundenanzahlprowoche` INT NULL,
  PRIMARY KEY (`uf_bezeichnung`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Fehlstunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Fehlstunde` (
  `fs_datum` TIMESTAMP(0) NOT NULL DEFAULT NULL,
  `fs_grund` VARCHAR(45) NOT NULL,
  `s_schuelernummer` INT NOT NULL,
  `Unterrichtsfach_uf_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fs_datum`),
  INDEX `fk_Fehlstunde_Schueler1_idx` (`s_schuelernummer` ASC),
  INDEX `fk_Fehlstunde_Unterrichtsfach1_idx` (`Unterrichtsfach_uf_bezeichnung` ASC),
  CONSTRAINT `fk_Fehlstunde_Schueler1`
    FOREIGN KEY (`s_schuelernummer`)
    REFERENCES `ecbookdb`.`Schueler` (`s_schuelernummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fehlstunde_Unterrichtsfach1`
    FOREIGN KEY (`Unterrichtsfach_uf_bezeichnung`)
    REFERENCES `ecbookdb`.`Unterrichtsfach` (`uf_bezeichnung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Krankmeldung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Krankmeldung` (
  `km_id` INT NOT NULL,
  `km_datum` DATETIME(0) NULL,
  `km_unterschrift` VARCHAR(45) NULL,
  `s_schuelernummer` INT NOT NULL,
  PRIMARY KEY (`km_id`),
  INDEX `fk_Krankmeldung_Schueler1_idx` (`s_schuelernummer` ASC),
  CONSTRAINT `fk_Krankmeldung_Schueler1`
    FOREIGN KEY (`s_schuelernummer`)
    REFERENCES `ecbookdb`.`Schueler` (`s_schuelernummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Schueler_has_Fehlstunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Schueler_has_Fehlstunde` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Krankmeldung_ist_Fehlstunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Krankmeldung_ist_Fehlstunde` (
  `km_Krankmeldungsid` INT NOT NULL,
  `fs_datum` DATE NOT NULL,
  `fs_grund` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`km_Krankmeldungsid`, `fs_datum`, `fs_grund`),
  INDEX `fk_Krankmeldung_has_Fehlstunde_Fehlstunde1_idx` (`fs_datum` ASC, `fs_grund` ASC),
  INDEX `fk_Krankmeldung_has_Fehlstunde_Krankmeldung1_idx` (`km_Krankmeldungsid` ASC),
  CONSTRAINT `fk_Krankmeldung_has_Fehlstunde_Krankmeldung1`
    FOREIGN KEY (`km_Krankmeldungsid`)
    REFERENCES `ecbookdb`.`Krankmeldung` (`km_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Krankmeldung_has_Fehlstunde_Fehlstunde1`
    FOREIGN KEY (`fs_datum` , `fs_grund`)
    REFERENCES `ecbookdb`.`Fehlstunde` (`fs_datum` , `fs_grund`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Unterrichtsstunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Unterrichtsstunde` (
  `uf_id` INT NOT NULL,
  `uf_std_datum` DATE NOT NULL,
  `uf_stunde` INT NOT NULL,
  `uf_kurzbezeichnung` VARCHAR(45) NOT NULL,
  `uf_raum` VARCHAR(45) NOT NULL,
  `uf_thema` VARCHAR(45) NULL,
  `k_name` VARCHAR(45) NOT NULL,
  `Lehrer_l_lehrerid` INT NOT NULL,
  `Unterrichtsfach_uf_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`uf_id`),
  INDEX `fk_Unterrichtsstunde_has_Unterrichtsfach_Klasse1_idx` (`k_name` ASC),
  INDEX `fk_Unterrichtsfach in der Unterrichtsstunde_Lehrer1_idx` (`Lehrer_l_lehrerid` ASC),
  INDEX `fk_Unterrichtsstunde_Unterrichtsfach1_idx` (`Unterrichtsfach_uf_bezeichnung` ASC),
  CONSTRAINT `fk_Unterrichtsstunde_has_Unterrichtsfach_Klasse1`
    FOREIGN KEY (`k_name`)
    REFERENCES `ecbookdb`.`Klasse` (`k_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Unterrichtsfach in der Unterrichtsstunde_Lehrer1`
    FOREIGN KEY (`Lehrer_l_lehrerid`)
    REFERENCES `ecbookdb`.`Lehrer` (`l_lehrerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Unterrichtsstunde_Unterrichtsfach1`
    FOREIGN KEY (`Unterrichtsfach_uf_bezeichnung`)
    REFERENCES `ecbookdb`.`Unterrichtsfach` (`uf_bezeichnung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Menu` (
  `m_name` INT NOT NULL,
  `m_url` VARCHAR(45) NULL,
  `m_anzeige` VARCHAR(45) NULL,
  `m_beschreibung` VARCHAR(45) NULL,
  PRIMARY KEY (`m_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecbookdb`.`Prüfungen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecbookdb`.`Prüfungen` (
  `p_datum` INT NOT NULL,
  `p_uhrzeit` VARCHAR(45) NULL,
  `Unterrichtsstunde_uf_id` INT NOT NULL,
  PRIMARY KEY (`p_datum`),
  INDEX `fk_Prüfungen_Unterrichtsstunde1_idx` (`Unterrichtsstunde_uf_id` ASC),
  CONSTRAINT `fk_Prüfungen_Unterrichtsstunde1`
    FOREIGN KEY (`Unterrichtsstunde_uf_id`)
    REFERENCES `ecbookdb`.`Unterrichtsstunde` (`uf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
