


create  proc SP_Display_Std_Crs_Tablefor_TM
 @INS_ID varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id @INS_ID=@INS_ID
							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @INS_ID)
											BEGIN
												 select * from Std_Crs
							  
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
 
 ---------------------------------------------------------------
  
 -------------------

  alter proc SP_dispalyStd_Crs_forST 
  @ID_STD varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id @INS_ID= @ID_STD
							IF  EXISTS (SELECT 1 FROM Student WHERE Std_ID =  @ID_STD)
											BEGIN
												  select  s.Std_ID, c.Crs_Name from Std_Crs  s, Course c 
                                                     where  s.Crs_ID= c.Crs_Id    and Std_ID= @ID_STD
							  
											 return;
											END
									else 
											BEGIN
												THROW 50003, 'ID does not exist ', 1;
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
 
 SP_dispalyStd_Crs_forST   @ID_STD=123

 ------------------------------------------------
alter  proc SP_dispalyStd_Crs_forINS 

 
 @INS_ID varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id  @INS_ID = @INS_ID 

                  

							IF  EXISTS (SELECT 1 FROM Instructor  i  where  i.Ins_ID =  @INS_ID )
                                                  
											BEGIN
											         
													
													  select s.Crs_ID,s.Std_ID  , cc.Crs_Name  from Std_Crs  s,[dbo].[Ins_Course] c ,Course cc
													  where  s.Crs_ID =c.Crs_ID and c.Ins_ID= @INS_ID  and c.Crs_ID= cc.Crs_Id
                                                     
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
   exec SP_dispalyStd_Crs_forINS  @INS_ID =2
  -----------------------------------------------------------
  alter proc SP_DisplayStd_Crs_Table
 @ID_user varchar(1000),
 @role varchar(5)
  as
  begin
      if(lower( @role)='m')
				  begin
				  exec  SP_Display_Std_Crs_Tablefor_TM @INS_ID=@ID_user
				 
				  return
				  end
	   else 
	   begin
				if(lower( @role)='s' or lower( @role)='i')
					  begin
								 if(lower( @role)='s')
								  begin 
								   exec SP_dispalyStd_Crs_forST 
                                           @ID_STD =@ID_user
									
									
								   return
								  end
								  else 
								  begin
								   exec SP_dispalyStd_Crs_forINS   @INS_id=@ID_user
								  
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


exec SP_DisplayStd_Crs_Table
 @ID_user =2,@role ='i'
 ----------------------------------------------------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------
-- update if TM
alter PROCEDURE SP_Std_Crs_UPDATE_forTM
    @INS_ID VARCHAR(1000),
	 @std_ID VARCHAR(1000),
    @crs_ID VARCHAR(1000),
   
    @newcrs_ID VARCHAR(1000),
    @newstd_ID VARCHAR(1000)
AS
BEGIN
    BEGIN TRY
        -- Validate the instructor ID
        EXEC PS_validate_id @INS_ID = @INS_ID;
		 EXEC PS_validate_id @INS_ID = @crs_ID;
		  EXEC PS_validate_id @INS_ID = @crs_ID;
		   EXEC PS_validate_id @INS_ID = @newstd_ID;

        -- Check if the instructor is a manager
        IF EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @INS_ID)
        BEGIN
            -- Update the Std_Crs table
            UPDATE Std_Crs
            SET Crs_ID = @newcrs_ID, Std_ID = @newstd_ID
            WHERE Crs_ID = @crs_ID AND Std_ID = @std_ID;

            RETURN;
        END
        ELSE 
        BEGIN
            THROW 50006, 'ID is not a manager', 1;
            RETURN;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error Occurred: ' + @ErrorMessage;
    END CATCH
END;
 -------------------------------------------------------------------------------
 create  proc SP_update_std_crs_Table
@INS_ID varchar(1000),
  @crs_ID varchar(1000),
  @std_ID varchar(1000),
   @newcrs_ID varchar(1000),
  @newstd_ID varchar(1000)
 as 
 begin 
 exec SP_Std_Crs_UPDATE_forTM @INS_ID =@INS_ID, @crs_ID= @crs_ID, @std_ID = @std_ID ,  @newcrs_ID = @newcrs_ID ,
  @newstd_ID= @newstd_ID

		
 end
 ---------------------------------------
 create proc SP_delete_Std_Crs_Table_forTM
 @INS_ID varchar(1000),
 @Std_ID varchar(1000),
  @Crs_ID varchar(1000)
  as
  begin 
  begin try
					exec  PS_validate_id  @INS_ID= @INS_ID
					exec  PS_validate_id  @INS_ID= @Std_ID
					exec  PS_validate_id  @INS_ID= @Std_ID

                  

							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id =  @INS_ID)
									BEGIN
									    IF  EXISTS (SELECT 1 FROM Intake WHERE Int_Name = @Crs_ID)
									       begin
												   delete from Std_Crs
													where  Std_ID= @Std_ID and Crs_ID=@Crs_ID
							  
													 return;
										    end
											else 
													 begin
													 THROW 50006, 'please enter Crs_ID', 1;
												  return;

													end
											
											END
									else 
											BEGIN
												THROW 50003, 'Only the training manager is allowed to delete ', 1;
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




 ---------
   alter proc SP_delete_Std_Crs_Table
 @INS_ID varchar(1000),
 @Std_ID varchar(1000),
  @Crs_ID varchar(1000)
  as
  begin
   exec SP_delete_Std_Crs_Table_forTM
 @INS_ID =@INS_ID,
 @Std_ID =@Std_ID,
  @Crs_ID =@Crs_ID
  end
  ---------------------------------------------------------------
  alter PROCEDURE SP_Insert_Std_Crs_TableforTM
    @INS_ID VARCHAR(1000),
    @crs_ID VARCHAR(1000),
    @std_ID VARCHAR(1000)
AS
BEGIN
    BEGIN TRY
       
        EXEC PS_validate_id @INS_ID = @INS_ID;

        
        IF EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @INS_ID)
        BEGIN
            -- Check if  Crs_ID and Std_ID already exists
            IF NOT EXISTS (SELECT 1 FROM Std_Crs WHERE Crs_ID = @crs_ID AND Std_ID = @std_ID)
            BEGIN
			    IF  not EXISTS (SELECT 1 FROM Student WHERE Std_ID = @std_ID)
				       begin 
					   print ' ID student does not exist in the database'
					   end
                -- Insert into Std_Crs table
                INSERT INTO Std_Crs (Crs_ID, Std_ID)
                VALUES (@crs_ID, @std_ID);
            END
            ELSE 
            BEGIN
                PRINT ' Crs_ID and Std_ID already exists';
                RETURN;
            END
        END
		else 
		begin 
		print 'id not a manager'
		end

       
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        SELECT @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error Occurred: ' + @ErrorMessage;
    END CATCH
END;
----------------------------------------------------------------------
   create proc SP_insert_STD_CRS_Table
   @INS_ID VARCHAR(1000),
    @crs_ID VARCHAR(1000),
    @std_ID VARCHAR(1000)
 as
 begin
  exec SP_Insert_Std_Crs_Table
    @INS_ID =@INS_ID,
    @crs_ID =@crs_ID,
    @std_ID = @std_ID
 end
 --------------
 



