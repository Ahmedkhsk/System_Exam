USE ExaminationSystem
----Views----------
CREATE VIEW Vw_Choises_Details 
as
SELECT * from Choices

CREATE VIEW Vw_Instructor_ID
as
SELECT  Ins_ID from Instructor

CREATE VIEW Vw_Track_Details
as
SELECT * from Track

CREATE VIEW Vw_Manager_ID
as
SELECT  Mngr_Id from Department

CREATE VIEW Vw_Student_Details
as
SELECT * from Student

CREATE OR ALTER PROCEDURE Proc_Instructor_Choices
    @Ins_ID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
        BEGIN
            -- Retrieve choices along with course name and instructor ID
            SELECT 
                C.Choice_ID, 
                C.Choice_Text, 
                C.IF_Correct,
                Crs.Crs_Name,
                IC.Ins_ID
            FROM Choices C
            JOIN Ins_Course IC ON C.Ques_No IN (
                SELECT Q.Ques_No
                FROM Question Q
                JOIN Exam_Questions EQ ON Q.Ques_No = EQ.Ques_No
                JOIN Exam E ON EQ.Exam_No = E.Exam_No
                WHERE E.Crs_ID = IC.Crs_ID
            )
            JOIN Course Crs ON IC.Crs_ID = Crs.Crs_ID
            WHERE IC.Ins_ID = @Ins_ID;
        END
        ELSE 
        BEGIN
            SELECT 'This Instructor ID does not exist' AS [Error Msg];
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS [Error Msg]; 
    END CATCH
END;

-- Execute the stored procedure with a valid instructor ID
EXEC Proc_Instructor_Choices @Ins_ID = 1; -- Replace 1 with a valid instructor ID

-- Execute the stored procedure with a valid instructor ID
EXEC Proc_Choice1_Details @Ins_ID = 1; -- Assuming 1 is a valid instructor ID


----------------SP Choices Insert----------------------------
CREATE OR ALTER PROCEDURE Proc_Add_Choice
    @Ins_ID INT,
    @Choice_ID INT,
    @Choice_Text VARCHAR(MAX),
    @IF_Correct INT,
    @Ques_No INT
AS
BEGIN TRY
    -- Check if the instructor exists
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
    BEGIN
        SELECT 'You do not have access to this table' AS [Error Msg];
    END
    ELSE 
    BEGIN
        -- Check if the choice already exists
        IF EXISTS (SELECT 1 FROM Choices WHERE Choice_ID = @Choice_ID)
        BEGIN
            SELECT 'This Choice already exists' AS [Error Msg];
        END
        ELSE
        BEGIN
            -- Ensure the question belongs to a course taught by the instructor
            IF NOT EXISTS (
                SELECT 1 
                FROM Ins_Course IC
                JOIN Exam_Questions EQ ON EQ.Ques_No = @Ques_No
                JOIN Exam E ON EQ.Exam_No = E.Exam_No
                WHERE IC.Ins_ID = @Ins_ID AND E.Crs_ID = (
                    SELECT Crs_ID FROM Course WHERE Crs_ID IN (
                        SELECT Crs_ID FROM Ins_Course WHERE Ins_ID = IC.Ins_ID
                    )
                )
            )
            BEGIN
                SELECT 'You do not have permission to add a choice for this question' AS [Error Msg];
            END
            ELSE
            BEGIN
                BEGIN TRY
                    INSERT INTO Choices (Choice_ID, Choice_Text, IF_Correct, Ques_No)
                    VALUES (@Choice_ID, @Choice_Text, @IF_Correct, @Ques_No);
                    
                    SELECT 'Insert Done Successfully' AS [Success Msg];
                END TRY
                BEGIN CATCH 
                    SELECT 'Could not insert, something went wrong: ' + ERROR_MESSAGE() AS [Error Msg];
                END CATCH
            END
        END
    END
END TRY
BEGIN CATCH
    SELECT 'Invalid Input: ' + ERROR_MESSAGE() AS [Error Msg];
END CATCH;


------------------SP Choices Delete-------------------

CREATE OR ALTER PROCEDURE Proc_Delete_Choice
    @Ins_ID INT,
    @Choice_ID INT
AS
BEGIN TRY 
    -- Check if the instructor exists
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Ins_ID = @Ins_ID)
    BEGIN
        SELECT 'You do not have access to this table' AS [Error Msg];
    END
    ELSE 
    BEGIN
        -- Check if the choice exists
        IF NOT EXISTS (SELECT 1 FROM Choices WHERE Choice_ID = @Choice_ID)
        BEGIN
            SELECT 'This Choice ID does not exist' AS [Error Msg];
        END
        ELSE 
        BEGIN
            -- Ensure the choice belongs to a question for a course taught by the instructor
            IF NOT EXISTS (
                SELECT 1 
                FROM Choices C
                JOIN Exam_Questions EQ ON C.Ques_No = EQ.Ques_No
                JOIN Exam E ON EQ.Exam_No = E.Exam_No
                JOIN Ins_Course IC ON E.Crs_ID = IC.Crs_ID
                WHERE C.Choice_ID = @Choice_ID AND IC.Ins_ID = @Ins_ID
            )
            BEGIN
                SELECT 'You do not have permission to delete this choice' AS [Error Msg];
            END
            ELSE
            BEGIN
                BEGIN TRY 
                    DELETE FROM Choices WHERE Choice_ID = @Choice_ID;
                    SELECT 'Deleted Successfully' AS [Success Msg];
                END TRY
                BEGIN CATCH 
                    SELECT 'Could not delete this choice, something went wrong: ' + ERROR_MESSAGE() AS [Error Msg];
                END CATCH
            END
        END
    END
END TRY 
BEGIN CATCH
    SELECT 'Invalid Input: ' + ERROR_MESSAGE() AS [Error Msg]; 
END CATCH;

-- Example execution of the stored procedure
EXEC Proc_Delete_Choice @Ins_ID = 1, @Choice_ID = 107; -- Replace with actual IDs


-------------------SP Choices Update----------------------

CREATE OR ALTER PROCEDURE Proc_Update_Choices
    @Ins_ID INT,
    @Choice_ID INT,
    @Choice_Text VARCHAR(MAX),
    @IF_Correct INT
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF EXISTS (SELECT 1 FROM Vw_Instructor_ID WHERE Ins_ID = @Ins_ID)
        BEGIN
            -- Check if the choice exists
            IF EXISTS (SELECT 1 FROM Choices WHERE Choice_ID = @Choice_ID)
            BEGIN
                -- Ensure the choice belongs to a question for a course taught by the instructor
                IF NOT EXISTS (
                    SELECT 1 
                    FROM Choices C
                    JOIN Exam_Questions EQ ON C.Ques_No = EQ.Ques_No
                    JOIN Exam E ON EQ.Exam_No = E.Exam_No
                    JOIN Ins_Course IC ON E.Crs_ID = IC.Crs_ID
                    WHERE C.Choice_ID = @Choice_ID AND IC.Ins_ID = @Ins_ID
                )
                BEGIN
                    SELECT 'You do not have permission to update this choice' AS [Error Msg];
                    RETURN;
                END

                -- Check if Choice_Text is not empty
                IF (@Choice_Text IS NOT NULL AND @Choice_Text != '')
                BEGIN
                    UPDATE Choices 
                    SET Choice_Text = @Choice_Text
                    WHERE Choice_ID = @Choice_ID;
                END

                -- Check if IF_Correct is provided
                IF (@IF_Correct IS NOT NULL)
                BEGIN
                    UPDATE Choices 
                    SET IF_Correct = @IF_Correct
                    WHERE Choice_ID = @Choice_ID;
                END
                
                -- Check if no updates were made
                IF (@Choice_Text IS NULL OR @Choice_Text = '') AND (@IF_Correct IS NULL)
                BEGIN
                    SELECT 'Choice text and IF Correct cannot be empty' AS [Error Msg];
                END
                ELSE
                BEGIN
                    SELECT 'Updated Successfully' AS [Success Msg];
                END
            END
            ELSE
            BEGIN
                SELECT 'This Choice not found' AS [Error Msg];
            END
        END
        ELSE
        BEGIN
            SELECT 'You do not have access to this table' AS [Error Msg];
        END
    END TRY
    BEGIN CATCH
        SELECT 'Invalid Input: ' + ERROR_MESSAGE() AS [Error Msg];
    END CATCH
END;
----------------SP Student Insert--------------

CREATE PROCEDURE Proc_Add_Student	@Manager_ID int,
									@Std_ID int ,
									@Std_Name varchar(40),
									@City varchar(20) ,
									@Street varchar(40),
									@Std_Email varchar(100),
									@Std_Gender varchar(10),
									@Int_Name varchar(30),
									@Password varchar(5)
as 
begin TRY 
	if Not Exists(SELECT 1 from Vw_Manager_ID WHERE Mngr_Id = @Manager_ID)
	begin
		SELECT 'You do not have access to this table ' [Error Msg]
	end
	else 
	begin
		if Exists(SELECT 1 from Student WHERE Std_ID = @Std_ID)
		begin
			select 'This Student ID already exists'
		end
		else
		begin
			begin TRY
				INSERT into Student
				values(@Std_ID, @Std_Name, @City, @Street, @Std_Email,
				@Std_Gender, @Int_Name, @Password )
				SELECT 'Inserted Done Successfully' as [Sucess Msg]
			end try
			begin CATCH 
				SELECT 'Could not insert, something went wrong' [Error Msg]
			end catch
		end
	end
end try
begin Catch
	select 'Invalid Input' [Error Msg] 
end catch

Proc_Add_Student	@Manager_ID = 6,
					@Std_ID = 20000 ,
					@Std_Name = 'Mohamed Abden',
					@City = 'El-Minia' ,
					@Street = 'Adnan',
					@Std_Email = 'm@mgmail.com',
					@Std_Gender = 'M',
					@Int_Name = 'Intake43_Round2' ,
					@Password = '23246'
					
------------SP Student Delete------------

CREATE PROCEDURE Proc_Delete_Student  @Manager_ID int, @Std_ID int
as 
begin TRY 
	if Not Exists(SELECT 1 from Vw_Manager_ID WHERE Mngr_Id = @Manager_ID)
	begin
		SELECT 'You do not have access to this table ' [Error Msg]
	end
	else 
	begin
		if Not Exists(SELECT 1 from Student WHERE Std_ID = @Std_ID )
		begin
			select 'This Student Id does not exist' as [Error Msg]
		end
		else 
		begin
			begin TRY 
				DELETE from Student WHERE Std_ID = @Std_ID
				SELECT ' Deleted Successfully ' as [Sucess Msg]
			end try
			begin CATCH 
				SELECT 'Could not delete this Student, something went wrong'
			end catch
		end
	end
end try 
begin catch 
	select 'Invalid Input' [Error Msg] 
end catch

Proc_Delete_Student  @Manager_ID = 6, @Std_ID = 20000

-----------------SP Student Update--------------------

CREATE PROCEDURE Proc_Update_Student_Mngr	@Manager_ID int,
											@Std_ID int ,
											@Std_Name varchar(40),
											@Std_Email varchar(100)
as 
begin try
	if Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @Manager_ID)
	begin
		if Exists(select 1 from Student where Std_ID = @Std_ID)
		begin
			if(@Std_Name = '' And @Std_Email != '')
			begin
				update Student set Std_Email = @Std_Email
				where Std_ID =  @Std_ID
				select 'Updata Done Successfully' [Sucess Msg]
			end
			else if (@Std_Name != '' And @Std_Email = '')
			begin
				update Student set Std_Name = @Std_Name
				where Std_ID =  @Std_ID
				select 'Updata Done Successfully' [Sucess Msg]
			end
			else if(@Std_Name != '' And @Std_Email != '')
			begin
				update Student set 
				Std_Name = @Std_Name , 
				Std_Email = @Std_Email
				where Std_ID =  @Std_ID
				select 'Updata Done Successfully' [Sucess Msg]
			end
			else
			begin
				select 'Can not Empty Student Name and his Email' [Error Msg]
			end
		end
		else
		begin
			select 'This Student Not Found ' [Error Msg] 
		end
	end
	else
	begin
		select 'You do not have access to this table' [Error Msg] 
	end
end try 
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Update_Student_Mngr	@Manager_ID = 6,
							@Std_ID = 20000 ,
							@Std_Name = '',
							@Std_Email = ''


