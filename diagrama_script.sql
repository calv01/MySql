-- MySQL Script generated by MySQL Workbench
-- Fri Nov  4 11:23:02 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `Id` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `edad` INT NULL,
  `url_foto` VARCHAR(100) NOT NULL,
  `Domicilio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Experiencia_laboral` (
  `Id` INT NOT NULL,
  `nombreEmpresa` VARCHAR(45) NOT NULL,
  `esTrabajoActual` TINYINT(10) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `Persona_Id` INT NOT NULL,
  PRIMARY KEY (`Id`, `Persona_Id`),
  INDEX `fk_Experiencia_laboral_Persona_idx` (`Persona_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Experiencia_laboral_Persona`
    FOREIGN KEY (`Persona_Id`)
    REFERENCES `mydb`.`Persona` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Educación`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Educación` (
  `id` INT NOT NULL,
  `nombreInstitucion` VARCHAR(45) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `id` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `Persona_Id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Usuarios_Persona1_idx` (`Persona_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Persona1`
    FOREIGN KEY (`Persona_Id`)
    REFERENCES `mydb`.`Persona` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tecnologias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tecnologias` (
  `id` INT NOT NULL,
  `nombreTecnologia` VARCHAR(45) NOT NULL,
  `curso 1` VARCHAR(100) NOT NULL,
  `curso 2` VARCHAR(100) NOT NULL,
  `Educación_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Educación_id`),
  INDEX `fk_Tecnologias_Educación1_idx` (`Educación_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tecnologias_Educación1`
    FOREIGN KEY (`Educación_id`)
    REFERENCES `mydb`.`Educación` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proyectos` (
  `id` INT NOT NULL,
  `nombreProyecto` VARCHAR(100) NOT NULL,
  `fecha` DATE NOT NULL,
  `Tecnologias_id` INT NOT NULL,
  `Tecnologias_Educación_id` INT NOT NULL,
  `Usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Usuarios_id`),
  INDEX `fk_Proyectos_Tecnologias1_idx` (`Tecnologias_id` ASC, `Tecnologias_Educación_id` ASC) VISIBLE,
  INDEX `fk_Proyectos_Usuarios1_idx` (`Usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_Proyectos_Tecnologias1`
    FOREIGN KEY (`Tecnologias_id` , `Tecnologias_Educación_id`)
    REFERENCES `mydb`.`Tecnologias` (`id` , `Educación_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proyectos_Usuarios1`
    FOREIGN KEY (`Usuarios_id`)
    REFERENCES `mydb`.`Usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Educación_has_Experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Educación_has_Experiencia_laboral` (
  `Educación_id` INT NOT NULL,
  `Experiencia_laboral_Id` INT NOT NULL,
  `Experiencia_laboral_Persona_Id` INT NOT NULL,
  PRIMARY KEY (`Educación_id`, `Experiencia_laboral_Id`, `Experiencia_laboral_Persona_Id`),
  INDEX `fk_Educación_has_Experiencia_laboral_Experiencia_laboral1_idx` (`Experiencia_laboral_Id` ASC, `Experiencia_laboral_Persona_Id` ASC) VISIBLE,
  INDEX `fk_Educación_has_Experiencia_laboral_Educación1_idx` (`Educación_id` ASC) VISIBLE,
  CONSTRAINT `fk_Educación_has_Experiencia_laboral_Educación1`
    FOREIGN KEY (`Educación_id`)
    REFERENCES `mydb`.`Educación` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Educación_has_Experiencia_laboral_Experiencia_laboral1`
    FOREIGN KEY (`Experiencia_laboral_Id` , `Experiencia_laboral_Persona_Id`)
    REFERENCES `mydb`.`Experiencia_laboral` (`Id` , `Persona_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
