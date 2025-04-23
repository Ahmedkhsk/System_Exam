
insert into [dbo].[Intake]
values ('Intake44_Round4','2024-06-20','2024-09-20')
--------------------------------------------------------------
-- to valide id 
  alter proc PS_validate_id 
  @INS_ID varchar(1000)
   as 
   begin 
         if  @INS_ID is null 
					begin 
						THROW 50001, 'All parameters must be provided.', 1;
							return;
					end 
							
		if  TRY_CONVERT(INT, @INS_ID) IS NULL
				begin 
					RAISERROR('ID must be an integer.', 16, 1);
					return;
				end 
   end 
   --------------------------------------------
   -- diplay all table if training manager
alter proc SP_dispaly_Intake_Table_forTM 
   @INS_ID varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id  @INS_ID= @INS_ID
							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id =  @INS_ID)
											BEGIN
												 select * from intake
							  
											 return;
											END
									else 
											BEGIN
												THROW 50003, 'ID does not exist or is not a manager', 1;
												  return;
												  end
			end try
			begin catch 
					DECLARE @ErrorMessage NVARCHAR(4000);
					SELECT 
							@ErrorMessage = ERROR_MESSAGE()

								PRINT 'Error Occurred: ' + @ErrorMessage;
								
			end catch
  end  
  ----------------------------------------------------------------
     --diplay last intake  table if student
  alter proc SP_dispaly_Intake_Table_forST 
  @STD_ID varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id @INS_ID=@STD_ID
							IF  EXISTS (SELECT 1 FROM Student WHERE Std_ID =  @STD_ID)
											BEGIN
													if EXISTS (SELECT 1 from Intake  where GETDATE() between [Int_Start_Date] and[Int_End_Date])
														begin
																  select * from Intake
																	 where GETDATE() between [Int_Start_Date] and[Int_End_Date]
																	  return;
														  end 
													else
															begin
															print 'There is currently no Intake'
															 return;
															end
							  
											
											END
									else 
											BEGIN
												THROW 50003, 'ID does not exist or is not a Student', 1;
												  return;
												  end
			end try
			begin catch 
					DECLARE @ErrorMessage NVARCHAR(4000);
					SELECT 
							@ErrorMessage = ERROR_MESSAGE()

								PRINT 'Error Occurred: ' + @ErrorMessage;
								
			end catch
  end  
  ---------------------------------------------------------------------
  --diplay last intake  table if ins and not TM 
create proc SP_dispaly_Intake_Table_forINS 
  @INS_ID varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id @INS_ID=@INS_ID

                  

							IF  EXISTS (SELECT 1 FROM Instructor  i  where  i.Ins_ID = @INS_ID)
                                                  
											BEGIN
											          if  EXISTS (SELECT 1 FROM Department  d  where  d.Mngr_Id = @INS_ID) 
													  begin 
													   select * from Intake
													    return;
													  end
													  else 
													  begin
													  select * from Intake
                                                     where GETDATE() between [Int_Start_Date] and[Int_End_Date]
													  return;
													  end
											END

									else 
											BEGIN
												THROW 50003, 'ID does not exist or is not a Instructor', 1;
												  return;
												  end
			end try
			begin catch 
					DECLARE @ErrorMessage NVARCHAR(4000);
					SELECT 
							@ErrorMessage = ERROR_MESSAGE()

								PRINT 'Error Occurred: ' + @ErrorMessage;
								
			end catch
  end  

----------------------------------------------------------------------------------------------------------



alter proc SP_DisplayIntake_Table
  @INS_ID varchar(1000),
 @role varchar(5)
  as
  begin
      if(lower( @role)='m')
				  begin
				  exec [dbo].[SP_dispaly_Intake_Table_forTM]  @INS_ID= @INS_ID
				 
				  return
				  end
	   else 
	   begin
				if(lower( @role)='s' or lower( @role)='i')
					  begin
								 if(lower( @role)='s')
								  begin 
									 exec [dbo].[SP_dispaly_Intake_Table_forST]  @INS_ID= @INS_ID
									
								   return
								  end
								  else 
								  begin
								   exec [dbo].[SP_dispaly_Intake_Table_forINS]  @INS_ID= @INS_ID
								  
								   return
								  end
								   return
				  
					  end
				else 
								 begin
									 print 'please enter s or m or i '
									
								   return
								  end
	  end
	  end


 




  exec SP_DisplayIntake_Table
 @ID_INS ='1',
 @role ='i'


-----------------------------------------------------------------------------------------------------
-- update if TM
 create proc SP_update_Intake_Table_forTM
 @INS_ID varchar(1000),
  @Int_Name_old varchar(30),
  @Int_Name_new varchar(30),
  @Int_Start_Date date,
 @Int_End_Date date

  as
  begin 
  begin try
					exec  PS_validate_id @INS_ID=@INS_ID

                  

							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @INS_ID)
									BEGIN
									    IF  EXISTS (SELECT 1 FROM Intake WHERE Int_Name = @Int_Name_old)
									       begin
												   update Intake
													set Int_Name= @Int_Name_new , Int_Start_Date= @Int_Start_Date ,Int_End_Date=@Int_End_Date
													where  Int_Name= @Int_Name_old
							  
													 return;
										    end
											else 
													 begin
													 THROW 50006, 'please enter INT_name correct', 1;
												  return;

													end
											
											END
									else 
											BEGIN
												THROW 50003, 'Only the training manager is allowed to modify this table', 1;
												  return;
												  end
			end try
			begin catch 
					DECLARE @ErrorMessage NVARCHAR(4000);
					SELECT 
							@ErrorMessage = ERROR_MESSAGE()

								PRINT 'Error Occurred: ' + @ErrorMessage;
								
			end catch

  end 
  -------------------------------------------------------------------------------
alter proc SP_update_Intake_Table
  @INS_ID varchar(1000),


  @Int_Name_old varchar(30),
  @Int_Name_new varchar(30),
  @Int_Start_Date date,
 @Int_End_Date date
 as 
 begin 
 exec SP_update_Intake_Table_forTM @INS_ID =@INS_ID, @Int_Name_old= @Int_Name_old, @Int_Name_new = @Int_Name_new ,  @Int_Start_Date = @Int_Start_Date ,
  @Int_End_Date= @Int_End_Date

		
 end
 -------------------------------------------
  exec SP_update_Intake_Table @ID_INS =1,
  @Int_Name_old ='Intake4333_Round1',
  @Int_Name_new ='Intake43_Round1',
  @Int_Start_Date ='2021-12-28',
 @Int_End_Date ='2022-03-06'
 ----------------------------------------------------------------------------------------------------------------
 alter proc SP_delete_Intake_Table_forTM
 @ID_INS varchar(1000),
  @Int_Name varchar(30)
  as
  begin 
  begin try
					exec  PS_validate_id @INS_ID=@ID_INS

                  

							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @ID_INS)
									BEGIN
									    IF  EXISTS (SELECT 1 FROM Intake WHERE Int_Name = @Int_Name)
									       begin
												   delete from Intake
													where  Int_Name= @Int_Name
							  
													 return;
										    end
											else 
													 begin
													 THROW 50006, 'please enter INT_name correct', 1;
												  return;

													end
											
											END
									else 
											BEGIN
												THROW 500010, 'Only the training manager is allowed to delete ', 1;
												  return;
												  end
			end try
			begin catch 
					DECLARE @ErrorMessage NVARCHAR(4000);
					SELECT 
							@ErrorMessage = ERROR_MESSAGE()

								PRINT 'Error Occurred: ' + @ErrorMessage;
								
			end catch

  end 

  ------------------------------------------------------------------------------------------
 alter proc SP_delete_Intake_Table
 @ID_INS varchar(1000),
  @Int_Name varchar(30)
  as
  begin  
   exec SP_delete_Intake_Table_forTM @ID_INS =@ID_INS,@Int_Name=@Int_Name
  end
  SP_delete_Intake_Table
 @ID_INS =1,
  @Int_Name ='bnm'
  --------------------------------------------------------------

 alter proc SP_insert_Intake_Table_forTM
 @INS_ID varchar(1000),
  @Int_Name_new varchar(30),
  @Int_Start_Date date,
 @Int_End_Date date

  as
  begin 
  begin try
					exec  PS_validate_id @INS_ID=@INS_ID

                  

							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @INS_ID)
									BEGIN
									    IF   not EXISTS (SELECT 1 FROM Intake WHERE Int_Name =  @Int_Name_new)
									       begin
												   insert into intake
												   values( @Int_Name_new,@Int_Start_Date,@Int_End_Date)
													
													 return;
										    end
											else 
													 begin
													 THROW 50006, 'intake name already exists. Please enter another name', 1;
												  return;

													end
											
											END
									else 
											BEGIN
												THROW 50003, 'Only the training manager is allowed to insert', 1;
												  return;
												  end
			end try
			begin catch 
					DECLARE @ErrorMessage NVARCHAR(4000);
					SELECT 
							@ErrorMessage = ERROR_MESSAGE()

								PRINT 'Error Occurred: ' + @ErrorMessage;
								
			end catch

  end 
  ----------------------------------------------------------------------
   create proc SP_insert_Intake_Table
 @INS_ID varchar(1000),
  @Int_Name_new varchar(30),
  @Int_Start_Date date,
 @Int_End_Date date
 as
 begin
  exec SP_insert_Intake_Table_forTM @INS_ID=@INS_ID,@Int_Name_new=@Int_Name_new,@Int_Start_Date=@Int_Start_Date,@Int_End_Date=@Int_End_Date
 end
 --------------
  
 ------------------------------------------------------------------------------------------------------------------------- 
 
