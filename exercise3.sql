-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exercise4` ;
USE `exercise4` ;

-- -----------------------------------------------------
-- Table `exercise4`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Medical` (
  `Overtime_ID` INT NOT NULL,
  `Overtime_rate` VARCHAR(45) NULL,
  PRIMARY KEY (`Overtime_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Doctor` (
  `Doctor_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Salary` VARCHAR(45) NULL,
  `Overtime_ID` INT NOT NULL,
  PRIMARY KEY (`Doctor_ID`),
  INDEX `fk_Doctor_Medical_idx` (`Overtime_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Medical`
    FOREIGN KEY (`Overtime_ID`)
    REFERENCES `exercise4`.`Medical` (`Overtime_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Specialist` (
  `Field_ID` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`Field_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Doctor_has_Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Doctor_has_Specialist` (
  `Doctor_ID` INT NOT NULL,
  `Field_ID` INT NOT NULL,
  PRIMARY KEY (`Doctor_ID`, `Field_ID`),
  INDEX `fk_Doctor_has_Specialist_Specialist1_idx` (`Field_ID` ASC) VISIBLE,
  INDEX `fk_Doctor_has_Specialist_Doctor1_idx` (`Doctor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_has_Specialist_Doctor1`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `exercise4`.`Doctor` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_has_Specialist_Specialist1`
    FOREIGN KEY (`Field_ID`)
    REFERENCES `exercise4`.`Specialist` (`Field_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Patient` (
  `Patient_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Date_of_birth` VARCHAR(45) NULL,
  PRIMARY KEY (`Patient_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Appointment` (
  `Appointment_ID` VARCHAR(45) NOT NULL,
  `Date` INT NOT NULL,
  `Time` VARCHAR(45) NOT NULL,
  `Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Appointment_ID`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `exercise4`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Doctor_has_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Doctor_has_Patient` (
  `Doctor_ID` INT NOT NULL,
  `Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Doctor_ID`, `Patient_ID`),
  INDEX `fk_Doctor_has_Patient_Patient1_idx` (`Patient_ID` ASC) VISIBLE,
  INDEX `fk_Doctor_has_Patient_Doctor1_idx` (`Doctor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_has_Patient_Doctor1`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `exercise4`.`Doctor` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_has_Patient_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `exercise4`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Payment` (
  `Payment_ID` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  `Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  INDEX `fk_Payment_Patient1_idx` (`Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `exercise4`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Bill` (
  `Bill_ID` INT NOT NULL,
  `Total` VARCHAR(45) NULL,
  `Patient_ID` INT NOT NULL,
  PRIMARY KEY (`Bill_ID`),
  INDEX `fk_Bill_Patient1_idx` (`Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `exercise4`.`Patient` (`Patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Bill_has_Payment` (
  `Bill_ID` INT NOT NULL,
  `Payment_ID` INT NOT NULL,
  PRIMARY KEY (`Bill_ID`, `Payment_ID`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_ID` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_ID`)
    REFERENCES `exercise4`.`Bill` (`Bill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_ID`)
    REFERENCES `exercise4`.`Payment` (`Payment_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
