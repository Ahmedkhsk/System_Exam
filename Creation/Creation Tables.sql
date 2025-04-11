SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `System_Exam` DEFAULT CHARACTER SET utf8mb4 ;
USE `System_Exam` ;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Branch` (
  `BranchID` INT NOT NULL,
  `BranchName` VARCHAR(45) NULL,
  PRIMARY KEY (`BranchID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Track` (
  `TrackID` INT NOT NULL,
  `TrackName` VARCHAR(45) NULL,
  `BranchID` INT NOT NULL,
  PRIMARY KEY (`TrackID`),
  INDEX `fk_Track_Branch1_idx` (`BranchID` ASC),
  CONSTRAINT `fk_Track_Branch1`
    FOREIGN KEY (`BranchID`)
    REFERENCES `System_Exam`.`Branch` (`BranchID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Intake` (
  `IntakeID` INT NOT NULL,
  `IntakeName` VARCHAR(45) NULL,
  `TrackID` INT NOT NULL,
  PRIMARY KEY (`IntakeID`),
  INDEX `fk_Intake_Track1_idx` (`TrackID` ASC),
  CONSTRAINT `fk_Intake_Track1`
    FOREIGN KEY (`TrackID`)
    REFERENCES `System_Exam`.`Track` (`TrackID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Instructor` (
  `InstructorID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `IsTrainingManager` BIT NULL,
  PRIMARY KEY (`InstructorID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Course` (
  `CourseID` INT NOT NULL,
  `CourseName` VARCHAR(100) NULL,
  `Description` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `MaxDegree` INT NULL,
  `MinDegree` INT NULL,
  `InstructorID` INT NULL,
  PRIMARY KEY (`CourseID`),
  INDEX `fk_Course_Instructor1_idx` (`InstructorID` ASC),
  CONSTRAINT `fk_Course_Instructor1`
    FOREIGN KEY (`InstructorID`)
    REFERENCES `System_Exam`.`Instructor` (`InstructorID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Questions` (
  `QuestionID` INT NOT NULL,
  `QuestionText` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `Ques_Type` VARCHAR(45) NULL,
  `CorrectAnswer` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `BestAcceptedAnswer` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `CourseID` INT NOT NULL,
  PRIMARY KEY (`QuestionID`),
  INDEX `fk_Questions_Course1_idx` (`CourseID` ASC),
  CONSTRAINT `fk_Questions_Course1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `System_Exam`.`Course` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Exam` (
  `ExamID` INT NOT NULL,
  `ExamType` VARCHAR(45) NULL,
  `StartTime` DATETIME NULL,
  `EndTime` DATETIME NULL,
  `TotalTime` INT NULL,
  `AllowanceOptions` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `Year` INT NULL,
  `CourseID` INT NOT NULL,
  `InstructorID` INT NULL,
  PRIMARY KEY (`ExamID`),
  INDEX `fk_Exam_Course1_idx` (`CourseID` ASC),
  INDEX `fk_Exam_Instructor1_idx` (`InstructorID` ASC),
  CONSTRAINT `fk_Exam_Course1`
    FOREIGN KEY (`CourseID`)
    REFERENCES `System_Exam`.`Course` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Exam_Instructor1`
    FOREIGN KEY (`InstructorID`)
    REFERENCES `System_Exam`.`Instructor` (`InstructorID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Choices` (
  `ChoiceID` INT NOT NULL,
  `ChoiceText` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `IF_Correct` BIT NULL,
  `QuestionID` INT NOT NULL,
  PRIMARY KEY (`ChoiceID`),
  INDEX `fk_Choices_Questions1_idx` (`QuestionID` ASC),
  CONSTRAINT `fk_Choices_Questions1`
    FOREIGN KEY (`QuestionID`)
    REFERENCES `System_Exam`.`Questions` (`QuestionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Student` (
  `StudentID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `IntakeID` INT NULL,
  PRIMARY KEY (`StudentID`),
  INDEX `fk_Student_Intake_idx` (`IntakeID` ASC),
  CONSTRAINT `fk_Student_Intake`
    FOREIGN KEY (`IntakeID`)
    REFERENCES `System_Exam`.`Intake` (`IntakeID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Student_Answers` (
  `StudentAnswerID` INT NOT NULL,
  `Std_Answer` LONGTEXT CHARACTER SET utf8mb4 NULL,
  `Mark` INT NULL,
  `IsCorrect` BIT NULL,
  `StudentID` INT NOT NULL,
  `QuestionID` INT NOT NULL,
  `ExamID` INT NOT NULL,
  PRIMARY KEY (`StudentAnswerID`, `StudentID`, `QuestionID`, `ExamID`),
  INDEX `fk_Student_Answers_Student1_idx` (`StudentID` ASC),
  INDEX `fk_Student_Answers_Questions1_idx` (`QuestionID` ASC),
  INDEX `fk_Student_Answers_Exam1_idx` (`ExamID` ASC),
  CONSTRAINT `fk_Student_Answers_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `System_Exam`.`Student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_Answers_Questions1`
    FOREIGN KEY (`QuestionID`)
    REFERENCES `System_Exam`.`Questions` (`QuestionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_Answers_Exam1`
    FOREIGN KEY (`ExamID`)
    REFERENCES `System_Exam`.`Exam` (`ExamID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `System_Exam`.`Exam_Question` (
  `ExamID` INT NOT NULL,
  `QuestionID` INT NOT NULL,
  `Marks` INT NULL,
  PRIMARY KEY (`ExamID`, `QuestionID`),
  INDEX `fk_Exam_has_Questions_Questions1_idx` (`QuestionID` ASC),
  INDEX `fk_Exam_has_Questions_Exam1_idx` (`ExamID` ASC),
  CONSTRAINT `fk_Exam_has_Questions_Exam1`
    FOREIGN KEY (`ExamID`)
    REFERENCES `System_Exam`.`Exam` (`ExamID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exam_has_Questions_Questions1`
    FOREIGN KEY (`QuestionID`)
    REFERENCES `System_Exam`.`Questions` (`QuestionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;