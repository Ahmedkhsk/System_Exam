--View to show each student and his department
alter view View_Student_Department
as 
--CTE Table(temporary result sets that are defined within
			--the execution scope)

select distinct Student.Std_ID, Student.Std_Name, DepartmentData.Depaertment_Name
from Student, (
				select stdCrs.Std_ID, d.Dept_Name Depaertment_Name
				from Std_Crs stdCrs INNER JOIN Course Crs
				ON stdCrs.Crs_ID = Crs.Crs_ID
   				INNER JOIN Ins_Course IC
				ON IC.Crs_Id = Crs.Crs_ID
				inner join Instructor I
				on IC.Ins_ID = I.Ins_ID
				LEFT JOIN Department D
				ON I.Dept_No = D.Dept_No
			) as DepartmentData
where Student.Std_ID = DepartmentData.Std_ID
--test
Select * from View_Student_Department


