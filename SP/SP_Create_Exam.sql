--Create Exam with random selection
alter procedure SP_Add_Exam
	@Instructor_Id int,
	@Crs_ID int, @Exam_No int,
	@Exam_Time int, @NumberOfMCQ_Question int,
	@NumerOf_TF_Question int,
	@Exam_Type varchar(20)
as
begin try
	if not exists (select * from Course where Crs_Id = @Crs_ID)
		begin
			select 'Selected course not exist' AS 'ErrorMessage'
		end
	else if not exists (
		select 1
		from Ins_Course
		where Crs_ID = @Crs_ID and Ins_Id = @Instructor_Id
		)
		begin
			select 'this Instructor is not teaching this course' AS 'ErrorMessage'
		end
	else
		begin
			insert into Exam(Exam_No,Exam_Date,Exam_Time,Exam_Type,Crs_ID)
			values (@Exam_No, convert(varchar, getdate(), 105),@Exam_Time, @Exam_Type, @Crs_ID)
			
			--Select MCQ
			insert into Exam_Questions(Exam_No,Ques_No)
			select top(@NumberOfMCQ_Question) @Exam_No, Ques_No
			from Question
			where Ques_Type = 'mcq,'
			order by newid() --questions are selected randomly from the Question table

			--Select T/F Questions
			insert into Exam_Questions(Exam_No,Ques_No)
			select top(@NumerOf_TF_Question) @Exam_No, Ques_No
			from Question
			where Ques_Type = 't/f,'
			order by newid() --questions are selected randomly from the Question table

			
			-- Show Added Exam
			select Q.*
			from Exam_Questions Exq, Question Q, Exam E
			where Exq.Exam_No = E.Exam_No and Exq.Ques_No = Q.Ques_No
				and Exq.Exam_No = @Exam_No
		end
end try
begin catch
	select error_message() AS errorMessage
end catch
--test Procedure
exec SP_Add_Exam @Instructor_Id =8 , @Exam_No = 6543210, @Crs_ID = 8, @Exam_Time = 15,
	@NumberOfMCQ_Question = 10, @NumerOf_TF_Question = 10,
	@Exam_Type = 'Corrective'
go
--Create Exam with Custom selection
alter procedure sp_add_custom_exam
    @instructor_id int,
    @crs_id int,
    @exam_no int,
    @exam_time int,
    @exam_type varchar(20),
    @mcq_questions nvarchar(max), 
    @tf_questions nvarchar(max)
as
begin try
    if not exists (select * from Course where Crs_Id = @crs_id)
    begin
        select 'selected course does not exist' as 'errormessage'
        return
    end

    if not exists (
        select 1
        from Ins_Course
        where Crs_ID = @crs_id and Ins_ID = @instructor_id
    )
    begin
        select 'this instructor is not teaching this course' as 'errormessage'
        return
    end

    insert into Exam (Exam_No, Exam_Date, Exam_Time, Exam_Type, Crs_ID)
    values (@exam_no, convert(varchar, getdate(), 105), @exam_time, @exam_type, @crs_id)

    insert into Exam_Questions (Exam_No, Ques_No)
    select @exam_no, value
    from string_split(@mcq_questions, ',')
    where value in (select Ques_No from Question where Ques_Type = 'mcq,')

    insert into Exam_Questions (Exam_No, Ques_No)
    select @exam_no, value
    from string_split(@tf_questions, ',')
    where value in (select Ques_No from Question where Ques_Type = 't/f,')

    -- show added exam questions
    select q.*
    from Exam_Questions exq
    join Question q on exq.Ques_No = q.Ques_No
    join Exam e on exq.Exam_No = e.Exam_No
    where exq.Exam_No = @exam_no
end try
begin catch
    select error_message() as errormessage
end catch
--test Procedure
exec sp_add_custom_exam @instructor_Id =13 , @Exam_No = 400400, @Crs_ID = 13, @Exam_Time = 15,
	@mcq_questions = '4,2,10,11,13,48,51,92,93,135', @tf_questions = '19,5,21,20,70,65,81,90,101,105',
	@Exam_Type = 'test'
go
--Student Score
alter procedure SP_Student_AnswerSheet
	@Std_ID int, @Exam_No int
as
begin try
	if not exists (select * from Exam where Exam_No = @Exam_No)
		begin
			select 'The Exam does not exist' AS 'ErrorMessage'
		end
	else if not exists (select * from Student where Std_ID = @Std_ID)
		begin
			select 'The Student does not exist' AS 'ErrorMessage'
		end
	else if not exists (select * from Std_Exam_Ans where (Std_ID = @Std_ID) and (Exam_No = @Exam_No))
		begin
			select 'This student did not attend this exam' AS 'ErrorMessage'
		end
	else
	begin
		--give student degree on his answer
		UPDATE StdEx
        SET Std_Score = CASE 
                            WHEN CH.IF_Correct = 1 THEN 1 
                            ELSE 0 
                        END
        FROM Std_Exam_Ans StdEx
        JOIN (
            SELECT Ques_No, Choice_ID, Choice_Text, IF_Correct,
                   ROW_NUMBER() OVER (PARTITION BY Ques_No ORDER BY Choice_ID) AS Choice_Number
            FROM Choices
        ) CH ON StdEx.Ques_No = CH.Ques_No AND StdEx.Std_Ans = CH.Choice_Number
        WHERE StdEx.Exam_No = @Exam_No AND StdEx.Std_ID = @Std_ID

		--Get number of Correct answers
		DECLARE @CorrectAns int
        SELECT @CorrectAns = SUM(Std_Score) * 5
        FROM Std_Exam_Ans
        WHERE Exam_No = @Exam_No AND Std_ID = @Std_ID

		SELECT Concat('Student With ID = ',+@Std_ID,' Get Score: ',+@CorrectAns, ' / 100', ' in Course ', +(Select Crs_Name from Exam inner join Course on Exam.Exam_No = @Exam_No where Exam.Crs_ID = Course.Crs_Id))	
		end
end try
begin catch
	select error_message() AS errorMessage	
end catch
--test
exec SP_Student_AnswerSheet @Exam_No = 987654, @Std_ID = 17
go
--Get Student Answer(Correct/Wrong)
alter procedure SP_StudentSolution
	@Exam_No int,
	@Std_ID int
as
begin try
	if not exists (select * from Exam where Exam_No = @Exam_No)
		begin
			select 'The Exam does not exist' AS 'ErrorMessage'
		end
	else if not exists (select * from Student where Std_ID = @Std_ID)
		begin
			select 'The Student does not exist' AS 'ErrorMessage'
		end
	else if not exists (select * from Std_Exam_Ans where (Std_ID = @Std_ID) and (Exam_No = @Exam_No))
		begin
			select 'This student did not attend this exam' AS 'ErrorMessage'
		end
	else
		begin
			select Q.Ques_No, Q.Ques_Text, C.Choice_Text [Correct Answer],
				case when StdEx.Std_Score = 1 then 'Correct Answer'
					 when StdEx.Std_Score = 0 then 'Wrong Answer'
				end as 'Student Answer State'
			from Std_Exam_Ans StdEx inner join Exam E
				on StdEx.Exam_No = E.Exam_No
				inner join Question Q on StdEx.Ques_No = Q.Ques_No
				inner join Choices C on Q.Ques_No = C.Ques_No and IF_Correct = 1
			where StdEx.Std_ID = @Std_ID and StdEx.Exam_No = @Exam_No
				and StdEx.Ques_No = C.Ques_No
		end
end try
begin catch
	select error_message() AS errorMessage
end catch
--test
exec SP_StudentSolution @Exam_No = 987654, @Std_ID = 17
go
--Exam Structure With Cursor
alter procedure SP_FullExam
	@Exam_ID int
as
begin try
	if not exists(select * from Exam where Exam_No = @Exam_ID)
	begin
			select 'The Exam does not exist' AS 'ErrorMessage'		
	end
	else
	begin
		declare @Content int
	create table #ShowExam(
		Questions varchar(max)
	)
	declare ExamCursor cursor
	for
		select Ques_No
		from Exam_Questions
		where Exam_No = @Exam_ID
	for read only
open ExamCursor
Fetch next from ExamCursor into @content
while @@FETCH_STATUS = 0 --Start looping
	begin
		--Show Questoin Text
		insert into #ShowExam
			select concat(Ques_No, ' - ', Ques_Text)
			from Question where Ques_No = @Content
		--Show Possible Choices of that Question
		
		insert into #ShowExam
			select CONCAT('( ',ROW_NUMBER() over (partition by Ques_No order by Choice_ID),
				' ) ', Choice_Text)
			from Choices
			where Ques_No = @Content
		--Space Between Coming Question
		insert into #ShowExam values ('   ---------------------    ')

		--work like Counter++
Fetch next from ExamCursor into @content
	end

Close ExamCursor
deallocate ExamCursor

Select *
from #ShowExam
	end
end try
begin catch
	select error_message() AS errorMessage	
end catch

--Test 
exec SP_FullExam @Exam_ID = 987654

--Student answers
go
create type StudentAnswers as table
(
    Ques_No int,
    Std_Answer int
)
go
ALTER PROCEDURE SP_Student_Ex_Answers
    @Exam_No INT,
    @Std_ID INT,
    @Answers StudentAnswers READONLY
AS
BEGIN TRY
    -- Check if the exam exists
    IF NOT EXISTS (SELECT * FROM Exam WHERE Exam_No = @Exam_No)
    BEGIN
        SELECT 'The Exam does not exist' AS 'ErrorMessage'
    END
    -- Check if the student exists
    ELSE IF NOT EXISTS (SELECT * FROM Student WHERE Std_ID = @Std_ID)
    BEGIN
        SELECT 'The Student does not exist' AS 'ErrorMessage'
    END
    ELSE
    BEGIN
        DECLARE @Exam_Type VARCHAR(50)
        DECLARE @Crs_ID INT

        SELECT @Exam_Type = Exam_Type, @Crs_ID = Crs_ID FROM Exam WHERE Exam_No = @Exam_No
        -- Check if the student has passed a test exam for the same course
        IF @Exam_Type = 'corrective' AND (
             SELECT sum(SEA.Std_Score)*5
            FROM Exam E
            JOIN Std_Exam_Ans SEA ON SEA.Exam_No = E.Exam_No
            WHERE SEA.Std_ID = 12
              AND E.Crs_ID = 4
              AND E.Exam_Type = 'test'
            
        ) > 50
        BEGIN
            SELECT 'You already passed the test exam for this course' AS 'ErrorMessage'
        END
        ELSE
        BEGIN
            DECLARE @ValidAnswers TABLE
            (
                Std_ID INT,
                Exam_No INT,
                Ques_No INT,
                Std_Ans INT
            )
            INSERT INTO @ValidAnswers (Std_ID, Exam_No, Ques_No, Std_Ans)
            SELECT @Std_ID, @Exam_No, A.Ques_No, A.Std_Answer
            FROM @Answers A
            JOIN Exam_Questions EQ ON A.Ques_No = EQ.Ques_No
            WHERE EQ.Exam_No = @Exam_No

            DECLARE @AnsweredQuestionsCount INT
            SELECT @AnsweredQuestionsCount = COUNT(*)
            FROM @ValidAnswers

            IF (@AnsweredQuestionsCount >= 20)
            BEGIN
                INSERT INTO Std_Exam_Ans (Std_ID, Exam_No, Ques_No, Std_Ans)
                SELECT Std_ID, Exam_No, Ques_No, Std_Ans
                FROM @ValidAnswers

                SELECT 'Answers successfully submitted' AS 'SuccessMessage'
            END
            ELSE
            BEGIN
                SELECT 'The student must answer at least 20 questions' AS 'ErrorMessage'
            END
        END
    END
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage
END CATCH

go
--Test
declare @Answers StudentAnswers

INSERT INTO @Answers (Ques_No, Std_Answer)
VALUES
    (8, 3),(26, 1),(29, 1),(30, 1),
	(41, 2), (64, 1), (75, 2), (77, 3),
	(83, 1), (106, 1), (155, 2), (182, 4),
	(189, 2), (193, 1), (209, 2), (212, 1),
    (218, 2), (269, 1), (295, 3), (297, 2)

exec SP_Student_Ex_Answers @Exam_No = 6543210, @Std_ID = 7, @Answers = @Answers
--Show the Exam
exec SP_FullExam @Exam_ID = 147258
--Student Score
exec SP_Student_AnswerSheet @Exam_No = 654321, @Std_ID = 7

exec SP_StudentSolution @Exam_No = 654321, @Std_ID = 7

