CREATE PROCEDURE AddCourseIfManager
    @ManagerID INT,
    @CourseID INT,
    @CourseName NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        
        IF NOT EXISTS (SELECT 1 FROM Course WHERE Crs_Id = @CourseID)
        BEGIN
            
            INSERT INTO Course (Crs_Id, Crs_Name, Max_Degree, Min_Degree)
            VALUES (@CourseID, @CourseName, @MaxDegree, @MinDegree);
            
            PRINT 'Course added successfully.';
        END
        ELSE
        BEGIN
            PRINT 'CourseID already exists.';
        END
    END
    ELSE
    BEGIN
        
        PRINT 'You do not have permission to add a new course.';
    END
END;
GO
EXEC AddCourseIfManager @ManagerID = 2, @CourseID = 500, @CourseName = 'Database Systems', @MaxDegree = 100, @MinDegree = 50;


CREATE PROCEDURE InsertCourseIfManager
    @ManagerID INT,
    @CourseID INT,
    @CourseName NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    -- ???? ??? ??? ?????? ?????? ?? ???? ???
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- ???? ??? ??? ???? ?????? ????? ??????
        IF NOT EXISTS (SELECT 1 FROM Course WHERE Crs_Id = @CourseID)
        BEGIN
            -- ????? ?????? ??????
            INSERT INTO Course (Crs_Id, Crs_Name, Max_Degree, Min_Degree)
            VALUES (@CourseID, @CourseName, @MaxDegree, @MinDegree);
            
            PRINT 'Course inserted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'CourseID already exists.';
        END
    END
    ELSE
    BEGIN
        -- ??? ?? ??? ???????? ???? ???
        PRINT 'You do not have permission to insert a new course.';
    END
END;
GO

EXEC AddCourseIfManager @ManagerID = 2, @CourseID = 111, @CourseName = 'sql server', @MaxDegree = 100, @MinDegree = 50;



CREATE PROCEDURE UpdateCourseIfManager
    @ManagerID INT,
    @CourseID INT,
    @CourseName NVARCHAR(255),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    -- ???? ??? ??? ?????? ?????? ?? ???? ???
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- ???? ??? ??? ???? ?????? ????? ??????
        IF EXISTS (SELECT 1 FROM Course WHERE Crs_Id = @CourseID)
        BEGIN
            -- ????? ?????? ?????? ???????
            UPDATE Course
            SET Crs_Name = @CourseName,
                Max_Degree = @MaxDegree,
                Min_Degree = @MinDegree
            WHERE Crs_Id = @CourseID;
            
            PRINT 'Course updated successfully.';
        END
        ELSE
        BEGIN
            PRINT 'CourseID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- ??? ?? ??? ???????? ???? ???
        PRINT 'You do not have permission to update the course.';
    END
END;
GO

EXEC UpdateCourseIfManager @ManagerID = 2, @CourseID = 105, @CourseName = 'Advanced Database ', @MaxDegree = 100, @MinDegree = 50;


CREATE PROCEDURE SelectCourseIfManager
    @ManagerID INT,
    @CourseID INT
AS
BEGIN
    -- ???? ??? ??? ?????? ?????? ?? ???? ???
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- ???? ??? ??? ???? ?????? ????? ??????
        IF EXISTS (SELECT 1 FROM Course WHERE Crs_Id = @CourseID)
        BEGIN
            -- ??? ?????? ?????? ???????
            SELECT Crs_Id, Crs_Name, Max_Degree, Min_Degree
            FROM Course
            WHERE Crs_Id = @CourseID;
        END
        ELSE
        BEGIN
            PRINT 'CourseID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- ??? ?? ??? ???????? ???? ???
        PRINT 'You do not have permission to view the course.';
    END
END;
GO

EXEC SelectCourseIfManager @ManagerID = 2, @CourseID = 101;


CREATE PROCEDURE SelectAllCoursesIfManager
    @ManagerID INT
AS
BEGIN
    -- ???? ??? ??? ?????? ?????? ?? ???? ???
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- ??? ???? ?????? ???? ????????
        SELECT * FROM Course;
    END
    ELSE
    BEGIN
        -- ??? ?? ??? ???????? ???? ???
        PRINT 'You do not have permission to view the courses.';
    END
END;
GO
EXEC SelectAllCoursesIfManager @ManagerID = 2;


CREATE PROCEDURE DeleteCourseIfManager
    @ManagerID INT,
    @CourseID INT
AS
BEGIN
    -- ???? ??? ??? ?????? ?????? ?? ???? ???
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- ???? ??? ??? ???? ?????? ????? ??????
        IF EXISTS (SELECT 1 FROM Course WHERE Crs_Id = @CourseID)
        BEGIN
            -- ??? ??????
            DELETE FROM Course WHERE Crs_Id = @CourseID;
            PRINT 'Course deleted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'CourseID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- ??? ?? ??? ???????? ???? ???
        PRINT 'You do not have permission to delete the course.';
    END
END;
GO

EXEC DeleteCourseIfManager @ManagerID = 2, @CourseID = 105;

----------------------------2-----------------------------------------------------
CREATE PROCEDURE AddQuestion
    @Ins_ID INT,
    @Ques_No INT,
    @Ques_Text NVARCHAR(MAX),
    @Ques_Type VARCHAR(20)
AS
BEGIN
    -- تحقق إذا كان معرف المدرب موجود في جدول Instructor
    IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
    BEGIN
        -- إضافة السؤال
        INSERT INTO Question (Ques_No, Ques_Text, Ques_Type)
        VALUES (@Ques_No, @Ques_Text, @Ques_Type);
        PRINT 'Question added successfully.';
    END
    ELSE
    BEGIN
        PRINT 'You do not have permission to add the question.';
    END
END;
GO;

EXEC AddQuestion  @Ins_ID = 2, @Ques_No=902, @Ques_Text='qwertyu', @Ques_Type=crrective;


CREATE PROCEDURE UpdateQuestion
    @Ins_ID INT,
    @Ques_No INT,
    @Ques_Text NVARCHAR(MAX),
    @Ques_Type VARCHAR(20)
AS
BEGIN
    -- تحقق إذا كان معرف المدرب موجود في جدول Instructor
    IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
    BEGIN
        -- تحديث السؤال
        UPDATE Question
        SET Ques_Text = @Ques_Text, Ques_Type = @Ques_Type
        WHERE Ques_No = @Ques_No;
        PRINT 'Question updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'You do not have permission to update the question.';
    END
END;
GO
EXEC UpdateQuestion  @Ins_ID = 2, @Ques_No=900, @Ques_Text='qwertyuio', @Ques_Type=mcq;


CREATE PROCEDURE DeleteQuestion
    @Ins_ID INT,
    @Ques_No INT
AS
BEGIN
    -- تحقق إذا كان معرف المدرب موجود في جدول Instructor
    IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
    BEGIN
        -- حذف السؤال
        DELETE FROM Question
        WHERE Ques_No = @Ques_No;
        PRINT 'Question deleted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'You do not have permission to delete the question.';
    END
END;
GO
EXEC DeleteQuestion  @Ins_ID = 2, @Ques_No=900;


CREATE PROCEDURE SelectQuestions
    @Ins_ID INT,
    @Ques_No INT = NULL -- جعل هذا المعامل اختياريًا لاختيار جميع الأسئلة إذا لم يتم تمرير أي قيمة
AS
BEGIN
    -- تحقق إذا كان معرف المدرب موجود في جدول Instructor
    IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
    BEGIN
        -- تحديد الأسئلة
        IF @Ques_No IS NOT NULL
        BEGIN
            SELECT * FROM Question
            WHERE Ques_No = @Ques_No;
        END
        ELSE
        BEGIN
            SELECT * FROM Question;
        END
    END
    ELSE
    BEGIN
        PRINT 'You do not have permission to view the questions.';
    END
END;
GO

EXEC SelectQuestions @Ins_ID=5 select Ques_No  , Ques_Text, Ques_Type from Question
where Ques_No =100 ;


-----------------------------------------------3---------------------------------------------
CREATE OR ALTER PROCEDURE AddBranchIfManager
    @ManagerID INT,
    @Branch_Id INT,
    @Branch_Name NVARCHAR(50),
    @Intake_Name VARCHAR(30)
AS
BEGIN
    -- تحقق إذا كان المعرف الممرر هو مدير قسم
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- تحقق إذا كان Intake_Name موجود في جدول Intake
        IF EXISTS (SELECT 1 FROM Intake WHERE Int_Name = @Intake_Name)
        BEGIN
            -- تحقق إذا كان Branch_Id موجود بالفعل لتجنب التعارض
            IF NOT EXISTS (SELECT 1 FROM Branch WHERE Branch_Id = @Branch_Id)
            BEGIN
                -- إضافة الفرع الجديد
                INSERT INTO Branch (Branch_Id, Branch_Name, Intake_Name)
                VALUES (@Branch_Id, @Branch_Name, @Intake_Name);

                PRINT 'Branch added successfully.';
            END
            ELSE
            BEGIN
                PRINT 'Error: Branch_Id already exists.';
            END
        END
        ELSE
        BEGIN
            PRINT 'Error: The specified Intake_Name does not exist.';
        END
    END
    ELSE
    BEGIN
        -- إذا لم يكن المستخدم مدير قسم
        PRINT 'You do not have permission to add a Branch.';
    END
END;
GO

EXEC AddBranchIfManager @ManagerID = 2, @Branch_Id = 22, @Branch_Name = 'New', @Intake_Name = 'Intake44_Round3';








CREATE OR ALTER PROCEDURE UpdateBranchIfManager
    @ManagerID INT,
    @Branch_Id INT,
    @Branch_Name NVARCHAR(50),
    @Intake_Name VARCHAR(30)
AS
BEGIN
    -- تحقق إذا كان المعرف الممرر هو مدير قسم
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- تحقق إذا كان معرف الفرع موجود بالفعل
        IF EXISTS (SELECT 1 FROM Branch WHERE Branch_Id = @Branch_Id)
        BEGIN
            -- تحقق إذا كان Intake_Name موجود في جدول Intake
            IF EXISTS (SELECT 1 FROM Intake WHERE Int_Name = @Intake_Name)
            BEGIN
                -- تحديث بيانات الفرع الموجود
                UPDATE Branch
                SET  
                    Branch_Name = @Branch_Name,
                    Intake_Name = @Intake_Name
                WHERE Branch_Id = @Branch_Id;

                PRINT 'Branch updated successfully.';
            END
            ELSE
            BEGIN
                PRINT 'Error: The specified Intake_Name does not exist.';
            END
        END
        ELSE
        BEGIN
            PRINT 'BranchID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- إذا لم يكن المستخدم مدير قسم
        PRINT 'You do not have permission to update the Branch.';
    END
END;
GO
EXEC UpdateBranchIfManager @ManagerID = 2, @Branch_Id = 1, @Branch_Name = 'New Branch Name', @Intake_Name = 'Intake43_Round1';



CREATE OR ALTER PROCEDURE DeleteBranchIfManager
    @ManagerID INT,
    @Branch_Id INT
AS
BEGIN
    -- تحقق إذا كان المعرف الممرر هو مدير قسم
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- تحقق إذا كان Branch_Id موجود
        IF EXISTS (SELECT 1 FROM Branch WHERE Branch_Id = @Branch_Id)
        BEGIN
            -- حذف الفرع الموجود
            DELETE FROM Branch
            WHERE Branch_Id = @Branch_Id;

            PRINT 'Branch deleted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'Error: Branch_Id does not exist.';
        END
    END
    ELSE
    BEGIN
        -- إذا لم يكن المستخدم مدير قسم
        PRINT 'You do not have permission to delete the Branch.';
    END
END;
GO

EXEC DeleteBranchIfManager @ManagerID = 2, @Branch_Id = 22;



CREATE OR ALTER PROCEDURE SelectAllBranchesIfManager
    @ManagerID INT
AS
BEGIN
    -- تحقق إذا كان المعرف الممرر هو مدير قسم
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- استعلام SELECT لجلب جميع البيانات من جدول Branch
        SELECT * FROM Branch;
    END
    ELSE
    BEGIN
        -- إذا لم يكن المستخدم مدير قسم
        PRINT 'You do not have permission to view the Branch table.';
    END
END;
GO

EXEC SelectAllBranchesIfManager @ManagerID = 2;




CREATE OR ALTER PROCEDURE SelectBranchByIdIfManager
    @ManagerID INT,
    @Branch_Id INT
AS
BEGIN
    -- تحقق إذا كان المعرف الممرر هو مدير قسم
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- استعلام SELECT لجلب بيانات الفرع المحدد
        SELECT * FROM Branch
        WHERE Branch_Id = @Branch_Id;
    END
    ELSE
    BEGIN
        -- إذا لم يكن المستخدم مدير قسم
        PRINT 'You do not have permission to view the Branch data.';
    END
END;
GO

EXEC SelectBranchByIdIfManager @ManagerID = 2, @Branch_Id = 2;

-----------------------function-----------------------------------------------------------------------
CREATE FUNCTION dbo.GetBranchAndManager()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        d.Dept_Name, 
        i.Ins_iD AS Manager_Id, 
        i.Ins_Name AS Manager_Name
    FROM 
	Instructor i,Department d
        
   where i.Ins_ID=d.Mngr_Id
);
SELECT * FROM dbo.GetBranchAndManager();

CREATE or alter FUNCTION dbo.GetInstructorsAndCourses()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        i.Ins_iD,
        i.Ins_Name,
        i.Dept_No,
        c.Crs_id,
        c.Crs_Name,
        c.Max_Degree,
        c.Min_Degree
    FROM 
        Instructor i
     JOIN 
        Ins_Course ic ON i.Ins_iD = ic.Ins_ID
     JOIN 
        Course c ON ic.Crs_ID = c.Crs_id
);
-- Example usage:
SELECT * FROM dbo.GetInstructorsAndCourses();


-----------------------------mang_instructor-------------------
CREATE or alter PROCEDURE AddInstructorIfManager
    @ManagerID INT,
    @InstructorID INT,
    @InstructorName NVARCHAR(255),
    @DeptNo INT,
    @Gender VARCHAR(10),
    @Email NVARCHAR(50),
    @Salary INT,
    @City NVARCHAR(20),
    @Street NVARCHAR(30),
    @Password NVARCHAR(5)
AS
BEGIN
    -- Check if the provided ManagerID is a valid manager
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- Check if the InstructorID already exists in the Instructor table
        IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Ins_iD = @InstructorID)
        BEGIN
            -- Insert the new instructor into the Instructor table
            INSERT INTO Instructor (Ins_iD, Ins_Name, Dept_No, Ins_Gender, Ins_Email, Ins_Salary, City, Street, Password)
            VALUES (@InstructorID, @InstructorName, @DeptNo, @Gender, @Email, @Salary, @City, @Street, @Password);
            
            PRINT 'Instructor added successfully.';
        END
        ELSE
        BEGIN
            PRINT 'InstructorID already exists.';
        END
    END
    ELSE
    BEGIN
        -- If the ManagerID is not valid, print a permission error message
        PRINT 'You do not have permission to add a new instructor.';
    END
END;
GO

EXEC AddInstructorIfManager 
    @ManagerID = 2, 
    @InstructorID = 3002, 
    @InstructorName = 'John Doe', 
    @DeptNo = 20, 
    @Gender = 'Male', 
    @Email = 'john.doe@example.com', 
    @Salary = 5000, 
    @City = 'New York', 
    @Street = '5th Avenue', 
    @Password = '54321';

---------------------

CREATE PROCEDURE UpdateInstructorIfManager
    @ManagerID INT,
    @InstructorID INT,
    @InstructorName NVARCHAR(255),
    @DeptNo INT,
    @Gender VARCHAR(10),
    @Email NVARCHAR(50),
    @Salary INT,
    @City NVARCHAR(20),
    @Street NVARCHAR(30),
    @Password NVARCHAR(5)
AS
BEGIN
    -- التحقق مما إذا كان معرّف المدير صالحًا
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- التحقق مما إذا كان معرّف المدرس موجودًا
        IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_iD = @InstructorID)
        BEGIN
            -- تحديث بيانات المدرس في جدول Instructor
            UPDATE Instructor
            SET Ins_Name = @InstructorName,
                Dept_No = @DeptNo,
                Ins_Gender = @Gender,
                Ins_Email = @Email,
                Ins_Salary = @Salary,
                City = @City,
                Street = @Street,
                Password = @Password
            WHERE Ins_iD = @InstructorID;
            
            PRINT 'Instructor updated successfully.';
        END
        ELSE
        BEGIN
            PRINT 'InstructorID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- إذا كان معرّف المدير غير صالح، طباعة رسالة خطأ
        PRINT 'You do not have permission to update this instructor.';
    END
END;
GO

EXEC UpdateInstructorIfManager 
    @ManagerID = 2, 
    @InstructorID = 300, 
    @InstructorName = 'Jane Doe', 
    @DeptNo = 30, 
    @Gender = 'Female', 
    @Email = 'jane.doe@example.com', 
    @Salary = 6000, 
    @City = 'Los Angeles', 
    @Street = 'Sunset Boulevard', 
    @Password = '67890';


	------------------------------
	CREATE PROCEDURE DeleteInstructorIfManager
    @ManagerID INT,
    @InstructorID INT
AS
BEGIN
    -- التحقق مما إذا كان معرّف المدير صالحًا
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- التحقق مما إذا كان معرّف المدرس موجودًا
        IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_iD = @InstructorID)
        BEGIN
            -- حذف المدرس من جدول Instructor
            DELETE FROM Instructor
            WHERE Ins_iD = @InstructorID;

            PRINT 'Instructor deleted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'InstructorID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- إذا كان معرّف المدير غير صالح، طباعة رسالة خطأ
        PRINT 'You do not have permission to delete this instructor.';
    END
END;
GO


EXEC DeleteInstructorIfManager 
    @ManagerID = 2, 
    @InstructorID = 300;


	--------------------------------------------
	CREATE PROCEDURE SelectInstructorIfManager
    @ManagerID INT,
    @InstructorID INT
AS
BEGIN
    -- التحقق مما إذا كان معرّف المدير صالحًا
    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_ID = @ManagerID)
    BEGIN
        -- التحقق مما إذا كان معرّف المدرس موجودًا
        IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_iD = @InstructorID)
        BEGIN
            -- استرجاع بيانات المدرس من جدول Instructor
            SELECT *
            FROM Instructor
            WHERE Ins_iD = @InstructorID;
        END
        ELSE
        BEGIN
            PRINT 'InstructorID does not exist.';
        END
    END
    ELSE
    BEGIN
        -- إذا كان معرّف المدير غير صالح، طباعة رسالة خطأ
        PRINT 'You do not have permission to view this instructor.';
    END
END;
GO

EXEC SelectInstructorIfManager 
    @ManagerID = 2, 
    @InstructorID = 20;



	-------------------------view--------
	----------------View لعرض معلومات المدرسين
	CREATE VIEW vw_AllQuestions AS
SELECT 
    Ques_No,
    Ques_Text,
    Ques_Type
FROM 
    Question;

	select *from vw_AllQuestions
-----------------------------
CREATE or alter VIEW vw_InstructorsCourses AS
SELECT 
    i.Ins_iD,
    i.Ins_Name,
    c.Crs_id,
    c.Crs_Name
FROM 
    Instructor i,Ins_Course ic, Course c
 
    where  i.Ins_iD = ic.Ins_ID
 
    and ic.Crs_ID = c.Crs_id;


	SELECT * FROM vw_InstructorsCourses


	----------------------------
	CREATE or alter VIEW vw_Managers AS
SELECT 
    d.Dept_No,
    d.Mngr_id,
    i.Ins_Name AS Manager_Name,
	i.Ins_Email As Manager_Email
FROM 
    Department d
JOIN 
    Instructor i ON d.Mngr_id = i.Ins_iD;

		SELECT * FROM vw_Managers


		-----------------------------------------
CREATE OR ALTER VIEW vw_FullCourseDetails AS
SELECT 
    c.Crs_id,
    c.Crs_Name,
    c.Max_Degree,
    c.Min_Degree,
    i.Ins_iD,
    i.Ins_Name,
    i.Ins_Gender,
    i.Ins_Email,
    i.Ins_Salary,
    i.City,
    i.Street,
    d.Dept_Name
FROM 
    Course c , Ins_Course ic ,  Instructor i,  Department d
 where
      c.Crs_id = ic.Crs_ID
 and
    ic.Ins_ID = i.Ins_iD
 and
     i.Dept_No = d.Dept_No;
	 
	 select*from vw_FullCourseDetails
	 ------------------------trigger-----------------------------------------------------------------



	 CREATE TABLE InstructorAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Ins_iD INT,
    Operation NVARCHAR(50),
    Old_Ins_Name NVARCHAR(255),
    New_Ins_Name NVARCHAR(255),
    Old_Dept_No INT,
    New_Dept_No INT,
    Old_Ins_Gender VARCHAR(10),
    New_Ins_Gender VARCHAR(10),
    Old_Ins_Email NVARCHAR(50),
    New_Ins_Email NVARCHAR(50),
    Old_Ins_Salary INT,
    New_Ins_Salary INT,
    Old_City NVARCHAR(20),
    New_City NVARCHAR(20),
    Old_Street NVARCHAR(30),
    New_Street NVARCHAR(30),
    Old_Password NVARCHAR(5),
    New_Password NVARCHAR(5),
    ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_Instructor_Insert
ON Instructor
AFTER INSERT
AS
BEGIN
    INSERT INTO InstructorAudit (Ins_iD, Operation, New_Ins_Name, New_Dept_No, New_Ins_Gender, New_Ins_Email, New_Ins_Salary, New_City, New_Street, New_Password)
    SELECT 
        i.Ins_iD, 
        'INSERT', 
        i.Ins_Name, 
        i.Dept_No, 
        i.Ins_Gender, 
        i.Ins_Email, 
        i.Ins_Salary, 
        i.City, 
        i.Street, 
        i.Password
    FROM 
        Inserted i;
END;

SELECT * FROM InstructorAudit;
---------------------------------------------------------

CREATE TRIGGER trg_Instructor_Update
ON Instructor
AFTER UPDATE
AS
BEGIN
    INSERT INTO InstructorAudit (Ins_iD, Operation, Old_Ins_Name, New_Ins_Name, Old_Dept_No, New_Dept_No, Old_Ins_Gender, New_Ins_Gender, Old_Ins_Email, New_Ins_Email, Old_Ins_Salary, New_Ins_Salary, Old_City, New_City, Old_Street, New_Street, Old_Password, New_Password)
    SELECT 
        d.Ins_iD, 
        'UPDATE', 
        d.Ins_Name, 
        i.Ins_Name, 
        d.Dept_No, 
        i.Dept_No, 
        d.Ins_Gender, 
        i.Ins_Gender, 
        d.Ins_Email, 
        i.Ins_Email, 
        d.Ins_Salary, 
        i.Ins_Salary, 
        d.City, 
        i.City, 
        d.Street, 
        i.Street, 
        d.Password, 
        i.Password
    FROM 
        Deleted d
    JOIN 
        Inserted i ON d.Ins_iD = i.Ins_iD;
END;

SELECT * FROM InstructorAudit;

-------------------------------------
CREATE TRIGGER trg_Instructor_Delete
ON Instructor
AFTER DELETE
AS
BEGIN
    INSERT INTO InstructorAudit (Ins_iD, Operation, Old_Ins_Name, Old_Dept_No, Old_Ins_Gender, Old_Ins_Email, Old_Ins_Salary, Old_City, Old_Street, Old_Password)
    SELECT 
        d.Ins_iD, 
        'DELETE',  -- هنا، 'DELETE' تحدد نوع العملية بأنها حذف
        d.Ins_Name, 
        d.Dept_No, 
        d.Ins_Gender, 
        d.Ins_Email, 
        d.Ins_Salary, 
        d.City, 
        d.Street, 
        d.Password
    FROM 
        Deleted d;
END;
SELECT * FROM InstructorAudit;


------------------------question----------
CREATE TABLE QuestionAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Ques_No INT,
    Operation NVARCHAR(50),
    Old_Ques_Text NVARCHAR(MAX),
    New_Ques_Text NVARCHAR(MAX),
    Old_Ques_Type NVARCHAR(20),
    New_Ques_Type NVARCHAR(20),
    ChangeDate DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER trg_Question_Insert
ON Question
AFTER INSERT
AS
BEGIN
    INSERT INTO QuestionAudit (Ques_No, Operation, New_Ques_Text, New_Ques_Type)
    SELECT 
        i.Ques_No, 
        'INSERT',  -- هنا، 'INSERT' تحدد نوع العملية بأنها إدخال
        i.Ques_Text, 
        i.Ques_Type
    FROM 
        Inserted i;
END;

SELECT * FROM QuestionAudit;

--------------------------delete----------------
CREATE TRIGGER trg_Question_Update
ON Question
AFTER UPDATE
AS
BEGIN
    INSERT INTO QuestionAudit (Ques_No, Operation, Old_Ques_Text, New_Ques_Text, Old_Ques_Type, New_Ques_Type)
    SELECT 
        d.Ques_No, 
        'UPDATE',  -- هنا، 'UPDATE' تحدد نوع العملية بأنها تحديث
        d.Ques_Text, 
        i.Ques_Text, 
        d.Ques_Type, 
        i.Ques_Type
    FROM 
        Deleted d
    JOIN 
        Inserted i ON d.Ques_No = i.Ques_No;
END;

SELECT * FROM QuestionAudit;


----------------------------delete-------------------


CREATE TRIGGER trg_Question_Delete
ON Question
AFTER DELETE
AS
BEGIN
    INSERT INTO QuestionAudit (Ques_No, Operation, Old_Ques_Text, Old_Ques_Type)
    SELECT 
        d.Ques_No, 
        'DELETE',  -- هنا، 'DELETE' تحدد نوع العملية بأنها حذف
        d.Ques_Text, 
        d.Ques_Type
    FROM 
        Deleted d;
END;
SELECT * FROM QuestionAudit;




-------------------------------courses-------------------

CREATE TABLE CourseAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Crs_id INT,
    Operation NVARCHAR(50),
    Old_Crs_Name NVARCHAR(30),
    New_Crs_Name NVARCHAR(30),
    Old_Max_Degree INT,
    New_Max_Degree INT,
    Old_Min_Degree INT,
    New_Min_Degree INT,
    ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE Trigger trg_Course_Insert
ON Course
AFTER INSERT
AS
BEGIN
    INSERT INTO CourseAudit (Crs_id, Operation, New_Crs_Name, New_Max_Degree, New_Min_Degree)
    SELECT 
        i.Crs_id, 
        'INSERT',  -- هنا، 'INSERT' تحدد نوع العملية بأنها إدخال
        i.Crs_Name, 
        i.Max_Degree, 
        i.Min_Degree
    FROM 
        Inserted i;
END;

select*from CourseAudit;


----------------------update----------------
CREATE TRIGGER trg_Course_Update
ON Course
AFTER UPDATE
AS
BEGIN
    INSERT INTO CourseAudit (Crs_id, Operation, Old_Crs_Name, New_Crs_Name, Old_Max_Degree, New_Max_Degree, Old_Min_Degree, New_Min_Degree)
    SELECT 
        d.Crs_id, 
        'UPDATE',  -- هنا، 'UPDATE' تحدد نوع العملية بأنها تحديث
        d.Crs_Name, 
        i.Crs_Name, 
        d.Max_Degree, 
        i.Max_Degree, 
        d.Min_Degree, 
        i.Min_Degree
    FROM 
        Deleted d
    JOIN 
        Inserted i ON d.Crs_id = i.Crs_id;
END;




-------------------delete------------------
CREATE TRIGGER trg_Course_Delete
ON Course
AFTER DELETE
AS
BEGIN
    INSERT INTO CourseAudit (Crs_id, Operation, Old_Crs_Name, Old_Max_Degree, Old_Min_Degree)
    SELECT 
        d.Crs_id, 
        'DELETE',  -- هنا، 'DELETE' تحدد نوع العملية بأنها حذف
        d.Crs_Name, 
        d.Max_Degree, 
        d.Min_Degree
    FROM 
        Deleted d;
END;





-------------------------لbranch------------------

CREATE TABLE BranchAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    Branch_id INT,
    Operation NVARCHAR(50),
    Old_Branch_Name NVARCHAR(50),
    New_Branch_Name NVARCHAR(50),
    Old_Intake_Name NVARCHAR(30),
    New_Intake_Name NVARCHAR(30),
    ChangeDate DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER trg_Branch_Insert
ON Branch
AFTER INSERT
AS
BEGIN
    INSERT INTO BranchAudit (Branch_id, Operation, New_Branch_Name, New_Intake_Name)
    SELECT 
        i.Branch_id, 
        'INSERT',  -- هنا، 'INSERT' تحدد نوع العملية بأنها إدخال
        i.Branch_Name, 
        i.Intake_Name
    FROM 
        Inserted i;
END;



---------------------------update------------------
CREATE TRIGGER trg_Branch_Update
ON Branch
AFTER UPDATE
AS
BEGIN
    INSERT INTO BranchAudit (Branch_id, Operation, Old_Branch_Name, New_Branch_Name, Old_Intake_Name, New_Intake_Name)
    SELECT 
        d.Branch_id, 
        'UPDATE',  -- هنا، 'UPDATE' تحدد نوع العملية بأنها تحديث
        d.Branch_Name, 
        i.Branch_Name, 
        d.Intake_Name, 
        i.Intake_Name
    FROM 
        Deleted d
    JOIN 
        Inserted i ON d.Branch_id = i.Branch_id;
END;



------------------------delete---------------------------
CREATE TRIGGER trg_Branch_Delete
ON Branch
AFTER DELETE
AS
BEGIN
    INSERT INTO BranchAudit (Branch_id, Operation, Old_Branch_Name, Old_Intake_Name)
    SELECT 
        d.Branch_id, 
        'DELETE',  -- هنا، 'DELETE' تحدد نوع العملية بأنها حذف
        d.Branch_Name, 
        d.Intake_Name
    FROM 
        Deleted d;
END;

SELECT * FROM BranchAudit;

---------------------------------index---------------------------------------

-- Creating index for all columns in the Course table
CREATE INDEX idx_Crs_Name ON Course (Crs_Name);
CREATE INDEX idx_Max_Degree ON Course (Max_Degree);
CREATE INDEX idx_Min_Degree ON Course (Min_Degree);

-- Creating index for all columns in the Question table
--CREATE INDEX idx_Ques_Text ON Question (Ques_Text);--
CREATE INDEX idx_Ques_Type ON Question (Ques_Type);

-- Creating index for all columns in the Branch table
CREATE INDEX idx_Branch_Name ON Branch (Branch_Name);
CREATE INDEX idx_Intake_Name ON Branch (Intake_Name);

-------------------------------------------------------

-- عرض الفهارس الموجودة على جدول Course
EXEC sp_helpindex 'Course';

-- عرض الفهارس الموجودة على جدول Question
EXEC sp_helpindex 'Question';

-- عرض الفهارس الموجودة على جدول Branch
EXEC sp_helpindex 'Branch';

----------------------------------------------------------------

-- إعادة بناء الفهارس على جدول Course
ALTER INDEX ALL ON Course REBUILD;

-- إعادة بناء الفهارس على جدول Question
ALTER INDEX ALL ON Question REBUILD;

-- إعادة بناء الفهارس على جدول Branch
ALTER INDEX ALL ON Branch REBUILD;


--------------------------------------------------------------------------

-- حذف فهرس معين على جدول Course
DROP INDEX idx_Crs_Name ON Course;

-- حذف فهرس معين على جدول Question
DROP INDEX idx_Ques_Text ON Question;

-- حذف فهرس معين على جدول Branch
DROP INDEX idx_Branch_Name ON Branch;
---------------------------------------------------------------------

