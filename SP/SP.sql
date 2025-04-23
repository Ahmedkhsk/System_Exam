/* Important Views */
create view Vw_Show_All_Instructor 
as
select * from Instructor

create view Vw_Show_Manger_ID
as
select Mngr_Id from Department

create view Vw_Training_Manager_Details
as
select I.Ins_Name , I.Ins_Email , I.Ins_Salary ,
I.City + ' - ' + I.Street As [Manager Adress] , D.Dept_Name , Dept_Location 
from Instructor I, Department D
where I.Ins_ID = Mngr_Id

create view Vw_Instructor_Works_Dept
as
select Ins_Name , Ins_Salary ,Dept_Name 
from Instructor I , Department D
where I.Dept_No = D.Dept_No


create view Vw_Show_All_Instructor_Phone
as
select * from Ins_Phone

create view Vw_Show_All_Instructor_Course
as
select * from Ins_Course

create view Vw_Show_All_InstructorName_CourseName_DeptName
as
select I.Ins_Name , C.Crs_Name , Dept_Name 
from Instructor I , Course C , Department D , Ins_Course InsCrs
where I.Ins_ID = InsCrs.Ins_ID 
And C.Crs_Id = InsCrs.Crs_ID 
And I.Dept_No = D.Dept_No

create view Vw_CountInstructor_ForAllDept
as
select   Dept_Name , count(Ins_ID) As [Number Of Instructor]
from  Instructor I, Department D
where I.Dept_No = D.Dept_No
group by Dept_Name


/* Show Instructors */
create procedure Proc_Show_Instructor_Details @id int
as 
begin try 
	if Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @id)
	begin
		select * from Vw_Show_All_Instructor 
	end
	else if Exists(select 1 from Instructor where Ins_ID = @id)
	begin
		select * from Instructor where Ins_ID = @id
	end
	else 
		select 'This ID Not Found' [Error Msg]
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch
Proc_Show_Instructor_Details  6

/* Insert Instructors */
create procedure Proc_Add_New_Instructor	@manegerId int ,
											@Ins_Id int ,
											@Ins_Name varchar(30) ,
											@Ins_Gender varchar(10) , 
											@Ins_Email varchar(50) , 
											@Ins_Salary int , 
											@Ins_City varchar(20) , 
											@Ins_Street varchar(30) ,
											@Ins_Password varchar(5) , 
											@Dept_No int
as 
begin try 
	if Not Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @manegerId)
	begin
		select 'You do not have access to this table ' [Error Msg]
	end
	else 
	begin
		if Exists(select 1 from Instructor where Ins_ID = @Ins_Id)
		begin
			select 'This ID Already Exists'
		end
		else
		begin
			begin try
				insert into Instructor
				values(	@Ins_Id , @Ins_Name , @Ins_Gender , 
						@Ins_Email , @Ins_Salary , @Ins_City , 
						@Ins_Street , @Ins_Password ,  @Dept_No)
				select 'Insert Done Successfully' As [Sucess Msg]
			end try
			begin catch 
				select 'Can not Insert This Data because there is Error'
			end catch
		end
	end
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Add_New_Instructor	@manegerId = 20 ,
						@Ins_Id = 22 ,
						@Ins_Name = 'Ahmed AbdAllah' ,
						@Ins_Gender = 'Male', 
						@Ins_Email = 'ahmed_abdallah@gmail.com' , 
						@Ins_Salary = 7000 , 
						@Ins_City = 'Giza' , 
						@Ins_Street = 'Tahrir' ,
						@Ins_Password = '12345' , 
						@Dept_No = 20
/* Delete Instructors */
create procedure Proc_Delete_Instructor @Manger_Id int , @Ins_Id int														
as 
begin try 
	if Not Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @Manger_Id)
	begin
		select 'You do not have access to this table ' [Error Msg]
	end
	else 
	begin
		if Not Exists(select 1 from Instructor where Ins_ID = @Ins_Id and Ins_ID != @Manger_Id)
		begin
			select 'This ID Not Found' As [Error Msg]
		end
		else 
		begin
			begin try 
				delete from Instructor where Ins_ID = @Ins_Id
				select 'Delete Done Successfully' As [Sucess Msg]
			end try
			begin catch
				select 'Can not Delete This Instructor Because he is Manager' As [Error Msg]
			end catch
		end
	end
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Delete_Instructor 6 , 22

/* Update Instructors */
create procedure Proc_Update_Instructor	@manegerId int ,
										@Ins_Id int ,
										@Ins_Name varchar(30) ,
										@Ins_Salary int
as 
begin try
	if Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @manegerId)
	begin
		if Exists(select 1 from Vw_Show_All_Instructor where Ins_ID = @Ins_Id)
		begin
			if(@Ins_Name = '' And @Ins_Salary != '')
			begin
				update Instructor set Ins_Salary = @Ins_Salary
				where Ins_ID =  @Ins_Id
				select 'Updata Done Successfully' [Sucess Msg]
			end
			else if(@Ins_Salary != '' And @Ins_Name != '')
			begin
				update Instructor set 
				Ins_Name = @Ins_Name , 
				Ins_Salary = @Ins_Salary
				where Ins_ID =  @Ins_Id
				select 'Updata Done Successfully' [Sucess Msg]
			end
			else if(@Ins_Salary = '' And @Ins_Name != '')
			begin
				update Instructor set Ins_Name = @Ins_Name
				where Ins_ID =  @Ins_Id
				select 'Updata Done Successfully' [Sucess Msg]
			end
			else 
			begin
				select 'Cant Instructor Name and His Salary Empty' [Error Msg]
			end
		end
		else 
		begin 
			select 'This Instructor Not Found ' [Error Msg] 
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

Proc_Update_Instructor	@manegerId = 6 ,
						@Ins_Id = 20 ,
						@Ins_Name = '' ,
						@Ins_Salary = 20000


/* Show Instructors Phones*/
create procedure Proc_Show_Instructor_Phones @id int
as 
begin try 
	if Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @id)
	begin
		select I.Ins_Name , P.Ins_Phone from 
		Vw_Show_All_Instructor_Phone P, Vw_Show_All_Instructor I
		where I.Ins_ID = P.Ins_ID
	end
	else if Exists(select 1 from Instructor where Ins_ID = @id)
	begin
		select I.Ins_Name , P.Ins_Phone from 
		Vw_Show_All_Instructor_Phone P, Vw_Show_All_Instructor I
		where I.Ins_ID = P.Ins_ID And I.Ins_ID = @id
	end
	else 
		select 'This ID Not Found' [Error Msg]
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Show_Instructor_Phones  12

/* Insert Instructors Phone*/
create procedure Proc_Add_New_Instructor_Phone	@manegerId int ,
												@Ins_Id int ,
												@Ins_Phone char(11)
as
begin try 
	if Not Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @manegerId)
	begin
		select 'You do not have access to this table ' [Error Msg]
	end
	else 
	begin
		begin try
			insert into Ins_Phone
			values(	@Ins_Id , @Ins_Phone)
			select 'Insert Done Successfully' As [Sucess Msg]
		end try
		begin catch 
			select 'Can not Insert This Data because there is Error'
		end catch
	end
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Add_New_Instructor_Phone	@manegerId = 6 ,
								@Ins_Id = 10 ,
								@Ins_Phone = '01122913362' 
/* Delete Instructors Phone */
create procedure Proc_Delete_Instructor_phone @Manger_Id int , @Ins_Phone char(11)														
as 
begin try 
	if Not Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @Manger_Id)
	begin
		select 'You do not have access to this table ' [Error Msg]
	end
	else 
	begin
		if Not Exists(select 1 from Vw_Show_All_Instructor_Phone where Ins_Phone = @Ins_Phone and Ins_ID != @Manger_Id)
		begin
			select 'This Phone Not Found' As [Error Msg]
		end
		else 
		begin
			begin try 
				delete from Ins_Phone where Ins_Phone = @Ins_Phone
				select 'Delete Done Successfully' As [Sucess Msg]
			end try
			begin catch
				select 'Can not Delete This Phone Because There is Error' As [Error Msg]
			end catch
		end
	end
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Delete_Instructor_phone 6 , '01022913362'

/* Update Instructors Phone*/
create procedure Proc_Update_Instructor_Phone	@manegerId int ,
												@Ins_Old_Phone char(11) ,
												@Ins_New_Phone char(11)
as 
begin try
	if Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @manegerId)
	begin
		if Exists(select 1 from Vw_Show_All_Instructor_phone where Ins_Phone =@Ins_Old_Phone)
		begin
			update Ins_Phone set Ins_Phone = @Ins_New_Phone
			where Ins_Phone = @Ins_Old_Phone
			select 'Update Done Sucessfully'
		end
		else
		begin
			select 'This Phone Not Found' [Error Msg]  
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

Proc_Update_Instructor_Phone @manegerId = 6 , 
@Ins_Old_Phone = '01112291334' , 
@Ins_New_Phone = '01222291334'


/* Show Instructors Course*/
create procedure Proc_Show_Instructor_Course @id int
as 
begin try 
	if Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @id)
	begin
		select I.Ins_Name , C.Crs_Name from 
		Vw_Show_All_Instructor I, Vw_Show_All_Instructor_Course IC , Course C
		where I.Ins_ID = IC.Ins_ID 
		And IC.Crs_ID = C.Crs_Id
	end
	else if Exists(select 1 from Instructor where Ins_ID = @id)
	begin
		select I.Ins_Name , C.Crs_Name from 
		Vw_Show_All_Instructor I, Vw_Show_All_Instructor_Course IC , Course C
		where I.Ins_ID = IC.Ins_ID 
		And IC.Crs_ID = C.Crs_Id And I.Ins_ID = 10
	end
	else 
		select 'This ID Not Found' [Error Msg]
end try
begin catch 
	select 'invalid Input' [Error Msg] 
end catch

Proc_Show_Instructor_Course 6

/* Insert Instructors Course */
alter procedure Proc_Add_New_Instructor_Course	@manegerId int ,
												@Ins_Id int ,
												@Crs_Id int
as
begin try 
	if Not Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @manegerId)
	begin
		print 'You do not have access to this table '
	end
	else 
	begin
		begin try
			insert into Ins_Course
			values(	@Ins_Id , @Crs_Id)
			print 'Insert Done Successfully'
		end try
		begin catch 
			print 'Can not Insert This Data because there is Error'
		end catch
	end
end try
begin catch 
	print 'invalid Input'
end catch

Proc_Add_New_Instructor_Course	@manegerId = 6 ,
								@Ins_Id = 20 ,
								@Crs_Id = 4
/* Delete Instructors Course */
alter procedure Proc_Delete_Instructor_Course @Manger_Id int , @Ins_Id int , @Crs_Id int														
as 
begin try 
	if Not Exists(select 1 from Vw_Show_Manger_ID where Mngr_Id = @Manger_Id)
	begin
		print 'You do not have access to this table '
	end
	else 
	begin
		if Not Exists(select 1 from Vw_Show_All_Instructor_Course where Ins_ID = @Ins_Id)
		begin
			print 'This Instructor Not Found in This Course'
		end
		else if Not Exists(select 1 from Vw_Show_All_Instructor_Course where Crs_ID = @Crs_Id)
		begin
			print 'This Course Not Belong this Branch'
		end
		else if Not Exists(select 1 from Vw_Show_All_Instructor_Course where Ins_ID = @Ins_Id  And Crs_ID = @Crs_Id)
		begin
			print 'Instructor Not Teach This Course'
		end
		else 
		begin
			begin try 
				delete from Ins_Course 
				where Ins_ID = @Ins_Id
				And Crs_ID = @Crs_Id
				print 'Delete Done Successfully'
			end try
			begin catch
				print 'Can not Delete This Content Because There is Error'
			end catch
		end
	end
end try
begin catch 
	print 'invalid Input'
end catch

Proc_Delete_Instructor_Course	@Manger_Id = 6 ,
								@Ins_Id = 20 ,
								@Crs_Id = 4


/* Create Non Clustred Index On Instructor Table */
create nonclustered index Ins_Name_Index
on Instructor(Ins_Name)

create nonclustered index Ins_Gender_Index
on Instructor(Ins_Gender)

create nonclustered index Ins_Email_Index
on Instructor(Ins_Email)

create nonclustered index Ins_Salary_Index
on Instructor(Ins_Salary)

create nonclustered index Ins_City_Index
on Instructor(City)

create nonclustered index Ins_Street_Index
on Instructor(Street)

/* Triggers */
create trigger Trig_Ins_Crs_Insert_Delete
on Ins_Course
after insert , delete
as
select * from Vw_Show_All_InstructorName_CourseName_DeptName

create table Instructor_Salary
(
	ID int , 
	Ins_Name nvarchar(30),
	OldSalary int, 
	NewSalary int ,
	ModifiedBy nvarchar(max),
	ModifiedDate date
)
create trigger Trig_Audit_Update_Ins_Salary
on Instructor 
after update
as
begin 
	if(update(Ins_Salary))
		begin
			insert into Instructor_Salary
			values((select Ins_ID from inserted) , 
					(select Ins_Name from inserted), 
					(select Ins_Salary from deleted), 
					(select Ins_Salary from inserted), 
					suser_name(), 
					getdate())
		end
end 