-- MySQL Script generated by MySQL Workbench
-- 02/13/15 23:38:22
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`faculties` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`departments` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `faculties_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_departments_faculties_idx` (`faculties_id` ASC),
  CONSTRAINT `fk_departments_faculties`
    FOREIGN KEY (`faculties_id`)
    REFERENCES `university`.`faculties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`courses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `departments_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_courses_departments1_idx` (`departments_id` ASC),
  CONSTRAINT `fk_courses_departments1`
    FOREIGN KEY (`departments_id`)
    REFERENCES `university`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`professors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `departments_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_professors_departments1_idx` (`departments_id` ASC),
  CONSTRAINT `fk_professors_departments1`
    FOREIGN KEY (`departments_id`)
    REFERENCES `university`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`professors_courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`professors_courses` (
  `professors_id` INT(11) NOT NULL,
  `courses_id` INT(11) NOT NULL,
  PRIMARY KEY (`professors_id`, `courses_id`),
  INDEX `fk_professors_courses_courses1_idx` (`courses_id` ASC),
  CONSTRAINT `fk_professors_courses_professors1`
    FOREIGN KEY (`professors_id`)
    REFERENCES `university`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professors_courses_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `university`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`titles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`professors_titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`professors_titles` (
  `professors_id` INT(11) NOT NULL,
  `titles_id` INT(11) NOT NULL,
  PRIMARY KEY (`professors_id`, `titles_id`),
  INDEX `fk_professors_titles_titles1_idx` (`titles_id` ASC),
  CONSTRAINT `fk_professors_titles_professors1`
    FOREIGN KEY (`professors_id`)
    REFERENCES `university`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professors_titles_titles1`
    FOREIGN KEY (`titles_id`)
    REFERENCES `university`.`titles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`students` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `faculties_id1` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_students_faculties1_idx` (`faculties_id1` ASC),
  CONSTRAINT `fk_students_faculties1`
    FOREIGN KEY (`faculties_id1`)
    REFERENCES `university`.`faculties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `university`.`student_course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student_course` (
  `students_id` INT(11) NOT NULL,
  `courses_id` INT(11) NOT NULL,
  INDEX `fk_student_course_courses1_idx` (`courses_id` ASC),
  PRIMARY KEY (`courses_id`, `students_id`),
  CONSTRAINT `fk_student_course_students1`
    FOREIGN KEY (`students_id`)
    REFERENCES `university`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_course_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `university`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
