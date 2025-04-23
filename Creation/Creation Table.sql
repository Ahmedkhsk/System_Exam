USE ExaminationSystem;

-- Table Branch
CREATE table Branch
( 
	Branch_Id int Primary key,
	Branch_Name nvarchar(50) not null,
	Intake_Name varchar(30) foreign key references Intake(Int_Name) ON UPDATE CASCADE  ON DELETE CASCADE,
) 

-- Table Course
CREATE table Course 
(
	Crs_Id int Primary key,
	Crs_Name nvarchar(30) not null,
	Max_Degree int, 
	Min_Degree int
)

-- Table Question
CREATE table Question 
(
	Ques_No int primary key ,
	Ques_Text nvarchar(max),
	Ques_Type varchar(20)
)

-- Table Exam
create Table Exam
(
	Exam_No int primary key ,
	Exam_Date varchar(20) not null ,
	Exam_Type varchar(30) not null ,
	Exam_Time int  not null,
	Crs_ID int,
	constraint FK_Course_Exam foreign key (Crs_ID ) references Course(Crs_Id) ON UPDATE CASCADE  ON DELETE CASCADE
 )

-- Table Choices
create table Choices
(
	Choice_ID int primary key,
	Choice_Text varchar(max)not null,
	IF_Correct int not null,
	Ques_No int,
	constraint FK_Ques_Choices foreign key (Ques_No ) references  Question (Ques_No) ON UPDATE CASCADE  ON DELETE CASCADE
)

-- Table Track
create table Track
(
	Track_ID int primary key,
	Track_Name varchar(50),
	Intake_Name varchar(30) foreign key references Intake(Int_Name) ON UPDATE CASCADE  ON DELETE CASCADE,

)

-- Table Intake
create table Intake
(
	Int_Name varchar(30)  primary key ,
	Int_Start_Date date,
	Int_End_Date date,
)

-- Table Student
 create table Student
(
	Std_ID int primary key,
	Std_Name varchar(40) not null,
	City varchar(20)  ,
	Street varchar(40) ,
	Std_Email varchar(100),
	Std_Gender  varchar(10),
	Int_Name varchar(30),
	Password varchar(5),
	CONSTRAINT FK_Int_Name FOREIGN KEY (Int_Name)
    REFERENCES Intake(Int_Name) ON UPDATE CASCADE  ON DELETE CASCADE,
)

-- Table Exam_Questions
create table Exam_Questions
(
	Exam_No int ,
	Ques_No int ,
	CONSTRAINT FK_Exam_No FOREIGN KEY (Exam_No)  REFERENCES Exam(Exam_No) ON UPDATE CASCADE  ON DELETE CASCADE,
	CONSTRAINT FK_Ques_No FOREIGN KEY (Ques_No)  REFERENCES Question(Ques_No) ON UPDATE CASCADE  ON DELETE CASCADE,
	CONSTRAINT PK_Exam_Question PRIMARY KEY (Exam_No , Ques_No)
)

-- Table Std_Phone
create table Std_Phone 
(
	Std_ID int , 
	Std_Phone int
	constraint FK_Std_ID foreign key(Std_ID) references Student(Std_ID) ON UPDATE CASCADE  ON DELETE CASCADE,
	constraint PK_Std_Phone primary key(Std_ID , Std_Phone) 
)

-- Table Std_Crs
create table Std_Crs 
(
	Std_ID int , 
	Crs_ID int
	constraint FK_Std_ID_Crs foreign key (Std_ID) references  Student(Std_ID) ON UPDATE CASCADE  ON DELETE CASCADE,
	constraint FK_CrsID_Std foreign key (Crs_ID) references Course (Crs_Id) ON UPDATE CASCADE  ON DELETE CASCADE, 
	constraint PK_Std_Crs primary key (Std_ID , Crs_ID) 
)

-- Table Std_Exam_Ans
create table Std_Exam_Ans 
(
	Std_ID int , 
	Exam_No int ,
	Ques_No int,
	Std_Ans int , 
	Std_Score int , 
	constraint FK_Std_ID_Exam foreign key (Std_ID) references Student (Std_ID) ON UPDATE CASCADE  ON DELETE CASCADE,
	constraint FK_Exam_Ques_No foreign key (Ques_No) references Question (Ques_No) ON UPDATE CASCADE  ON DELETE CASCADE,
	constraint FK_Exam_No_Ans foreign key (Exam_No) references Exam (Exam_No) ON UPDATE CASCADE  ON DELETE CASCADE,
	constraint PK_Std_Exam_Ans primary key (Std_ID , Exam_No,Ques_No)
)

-- Table Instructor
Create table Instructor
(
	Ins_ID int primary key,
	Ins_Name varchar(30),
	Ins_Gender varchar(10),
	Ins_Email varchar(50),
	Ins_Salary int,
	City varchar(20),
	Street varchar(30),
	Password varchar(5)
)

ALTER TABLE Instructor ADD 
	Dept_No INT FOREIGN KEY REFERENCES Department(Dept_No)

-- Table Department
Create table Department
(
	Dept_No int primary key,
	Dept_Name varchar(30),
	Dept_Location varchar(20),

)

ALTER TABLE Department Add 
	Mngr_Id INT FOREIGN KEY REFERENCES Instructor(Ins_ID) ON UPDATE CASCADE  ON DELETE CASCADE

-- Table Ins_Course
Create table Ins_Course
(
	Ins_ID int foreign key references Instructor(Ins_ID) ON UPDATE CASCADE  ON DELETE CASCADE,
	Crs_ID int foreign key references Course(Crs_ID) ON UPDATE CASCADE  ON DELETE CASCADE,
	constraint PK_Ins_Course primary key (Ins_ID , Crs_ID)
)

-- Table Ins_Phone
Create table Ins_Phone
(
	Ins_ID int foreign key references Instructor(Ins_ID) ON UPDATE CASCADE  ON DELETE CASCADE,
	Ins_Phone int,
	constraint PK_Ins_Phone primary key (Ins_ID , Ins_Phone)
)