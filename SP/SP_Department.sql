--Table Department
	--Select
create procedure Show_Departments
as
begin
	select * from Department
end
--test
exec Show_Departments

	--insert
alter Procedure Insert_Department
	@User_ID int,
	@Dept_No int,
	@Dept_Name varchar(30),
	@Dept_Location varchar(20),
	@Mngr_Id int
as
begin try
	if (@User_ID != 1)
	begin
			select 'You Do not have permission to this' AS 'ErrorMessage'		
	end
	else if not exists (select * from Instructor where Ins_ID = @Mngr_Id)
	begin
		select 'The manager you try to assign does not exist' AS 'ErrorMessage'
	end
	else
	begin
		insert into Department
		values (@Dept_No,@Dept_Name,@Dept_Location,@Mngr_Id)
	end
end try
begin catch
		select error_message() AS errorMessage
end catch
--test
exec Insert_Department @User_ID = 1, @Dept_No = 70, @Dept_Name = 'Machine Learning',
		@Dept_Location = 'Smart Village', @Mngr_Id = 50

	--Update
	--Only Allow to Change the manager 
alter Procedure Update_Departments
	@User_ID int,
	@Dept_No int,
	@NewManagerID int
as
begin try
	if (@User_ID != 1)
	begin
			select 'You Do not have permission to this' AS 'ErrorMessage'		
	end
	else if not exists (select * from Instructor where Ins_ID = @NewManagerID)
	begin
		select 'The manager you try to assign does not exist' AS 'ErrorMessage'
	end
	else
	begin
		update Department
		set Mngr_Id = @NewManagerID
		where Dept_No = @Dept_No
	end
end try
begin catch
		select error_message() AS errorMessage
end catch
--test
Exec Update_Departments @User_ID = 1, @Dept_No = 20, @NewManagerID = 50

	--Delete
alter procedure Delete_Department
    @User_ID int,
	@dept_no int
as
begin try
	if (@User_ID != 1)
	begin
			select 'You Do not have permission to this' AS 'ErrorMessage'		
	end
	else if not exists (select * from Department where Dept_No = @dept_no)
	begin
			select 'Selected Departmed Does Not exist' AS 'ErrorMessage'		
	end
	else
	begin
		delete from department
		where dept_no = @dept_no
	end
end try
begin catch
	select error_message() AS errorMessage
end catch
--test
Exec Delete_Department @User_ID = 1, @Dept_No = 70

--Student info by Dept Number
create procedure GetStdInfoByDeptNo
	@Dept_No int
as
begin try
	if not exists(select * from Department where Dept_No = @Dept_No)
	begin
            select 'Selected department does not exist' as 'ErrorMessage'
	end
	else
	begin
		select s.* 
		from Student s left join (
			select distinct sc.Std_ID, d.Dept_No
		    from Std_Crs sc join Course Crs
			on sc.Crs_ID = Crs.Crs_ID
			inner join Ins_Course IC
			on IC.Crs_Id = Crs.Crs_ID
			inner join Instructor I
			on IC.Ins_ID = I.Ins_ID
			left join Department D
			on I.Dept_No = D.Dept_No
		
		) as StdDepartment
		on s.Std_ID = StdDepartment.Std_ID
		where StdDepartment.Dept_No = @Dept_No
	end
end try
begin catch
	select ERROR_MESSAGE() as errorMessage
end catch
--test
GetStdInfoByDeptNo @Dept_No = 303

--Department and instructor details by id
alter procedure DetailsCoursesStudentbyInstuctorID
 @Ins_ID int
as
begin try
	if not exists (select * from Instructor where Ins_ID = @Ins_ID)
		begin
            select 'Selected ID does not exist' as 'ErrorMessage'
        end
	else
	begin
		select D.Dept_Name as Department_Name, I.Ins_Name as Instructor_Name,
		C.Crs_Name as Course_Name, count(distinct StdC.Std_ID) as student_number
		from   Instructor I ,Student S,Course C, Std_Crs StdC, Department D, Ins_Course InsC
		where  InsC.Crs_ID = C.Crs_Id and InsC.Ins_ID = I.Ins_ID and C.Crs_Id = StdC.Crs_ID
		and StdC.Std_ID = S.Std_ID and D.Dept_No = I.Dept_No
		and I.Ins_ID = 20
		
		group by C.Crs_Name, D.Dept_Name, I.Ins_Name
	end
end try
begin catch
	select ERROR_MESSAGE() AS errorMessage
end catch

--test
exec DetailsCoursesStudentbyInstuctorID @Ins_ID = 20
