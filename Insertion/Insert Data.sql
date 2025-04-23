-- insert Course data  
Bulk insert Course
From 'C:\ITI\SQL\Course.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Intake data
Bulk insert Intake
From 'C:\ITI\SQL\Intake.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Question data  
Bulk insert Question
From 'C:\ITI\SQL\Question.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Branch data  
Bulk insert Branch
From 'C:\ITI\SQL\Branch.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Track data  
Bulk insert Track
From 'C:\ITI\SQL\Track.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Choices data  
Bulk insert Choices
From 'C:\ITI\SQL\Choices.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Exam data  
Bulk insert Exam
From 'C:\ITI\SQL\Exam.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Exam_Questions data  
Bulk insert Exam_Questions
From 'C:\ITI\SQL\Exam_Questions.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Student data  
Bulk insert Student
From 'C:\ITI\SQL\Student.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Std_Phone data  
Bulk insert Std_Phone
From 'C:\ITI\SQL\Student_Phone.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Std_Course data  
Bulk insert Std_Crs
From 'C:\ITI\SQL\Student_Course.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Std_Exam_Ans data  
Bulk insert Std_Exam_Ans
From 'C:\ITI\SQL\Std_Exam_Ans.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Instructor data  
Bulk insert Instructor
From 'C:\ITI\SQL\Instructor.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Department data  
Bulk insert Department
From 'C:\ITI\SQL\Department.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Ins_Phone data  
Bulk insert Ins_Phone
From 'C:\ITI\SQL\Ins_Phone.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
-- Insert Ins_Course data  
Bulk insert Ins_Course
From 'C:\ITI\SQL\Ins_Course.csv'
with (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)