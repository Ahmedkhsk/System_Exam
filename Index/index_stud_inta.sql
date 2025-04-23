--Create Non Clustred Index On Intake Table
create nonclustered index index_Int_Start_Date
on intake(Int_Start_Date)

create nonclustered index index_Int_End_Date
on intake(Int_End_Date)
-----------------------------------------------------------------


--Create Non Clustred Index On studentTable
create nonclustered index index_student_std_Name
on student(std_Name)

create nonclustered index index_student_std_Gender
on student(std_Gender)

create nonclustered index index_student_std_Email
on student(std_Email)
create nonclustered index index_student_City
on student(City)

create nonclustered index index_student_Street
on student(Street)

