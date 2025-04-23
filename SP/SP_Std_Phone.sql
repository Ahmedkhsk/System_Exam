--proc Std_Phone--
create proc SP_dispaly_Std_Phone_Table_forTM 
  @INS_ID varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id  @INS_ID= @INS_ID

                  

							IF  EXISTS (SELECT 1 FROM Department WHERE Mngr_Id =  @INS_ID)
											BEGIN
												 select * from Std_Phone
							  
											 return;
											END
									else 
											BEGIN
												THROW 50003, 'ID is not a manager', 1;
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
  -------------------------------------------------
  create proc SP_dispaly_Std_Phone_Table_forST
  @ID_ST varchar(1000)
  as
  begin
			begin try
							exec  PS_validate_id @INS_ID=@ID_ST

                  

							IF  EXISTS (SELECT 1 FROM Student WHERE Std_ID = @ID_ST)
											BEGIN
												 select Std_Phone from Std_Phone
												 where  Std_ID =@ID_ST
							  
											 return;
											END
									else 
											BEGIN
												THROW 50003, 'ID is not a student ', 1;
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

  -------------------------------------------------
   create proc SP_dispaly_Std_Phone_Table 
   @user_id varchar(1000) , @role varchar(5)
   as
   begin
		if(lower(@role)in('m','s'))
				begin
						if(lower(@role)='m')
								begin
									 exec SP_dispaly_Std_Phone_Table_forTM		@INS_ID = @user_id
									 return
								end
						else
								begin
										exec SP_dispaly_Std_Phone_Table_forST	@ID_ST = @user_id
										return
								end

				end
		else
				begin
					print 'only TM and Student can show this data'
					return
				end
   end

   ---------------------------------------------------
   SP_dispaly_Std_Phone_Table 
   @user_id=2 , @role ='s'
   -------------------------------------------------------------------------------------------------------------------

  create PROCEDURE SP_Update_Std_Phone_Table
   @user_id VARCHAR(1000),
   @role VARCHAR(5),
   @Upd_phone VARCHAR(10),
   @old_phone VARCHAR(10),
   @id_stud VARCHAR(1000)
AS
BEGIN
    exec  PS_validate_id  @INS_ID= @user_id
    IF (LEN(@Upd_phone) != 10)
    BEGIN
        PRINT 'Please enter a valid phone number';
        RETURN;
    END
    
    -- Check if the role is either 'm' (manager) or 's' (student)
    IF (LOWER(@role) IN ('m', 's'))
    BEGIN
        -- If role is 'm', check if the instructor is a manager
        IF (LOWER(@role) = 'm')
        BEGIN 
            IF EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @user_id)
            BEGIN
                UPDATE Std_Phone 
                SET [Std_Phone] = @Upd_phone
                WHERE Std_ID = @id_stud AND Std_Phone = @old_phone;
                RETURN;
            END
        END 
        -- If role is 's', check if the student IDs match
        ELSE IF (LOWER(@role) = 's')
        BEGIN             
            IF (@id_stud != @user_id)
            BEGIN
                PRINT 'The student ID and  ID must be equal';
                RETURN;
            END   
            
            IF EXISTS (SELECT 1 FROM Student WHERE Std_ID = @id_stud)
            BEGIN
                UPDATE Std_Phone 
                SET [Std_Phone] = @Upd_phone
                WHERE Std_ID = @id_stud AND Std_Phone = @old_phone;
                RETURN;
            END
        END
    END
    ELSE
    BEGIN 
        PRINT 'Only Manager (m) and Student (s) roles can update this data';
        RETURN;
    END
END;
select *from Std_Phone
 exec SP_Update_Std_Phone_Table
   @user_id ='1',
   @role='m',
   @Upd_phone ='100000',
   @old_phone ='1001234567',
   @id_stud ='1'

   -------------------------------------------------------------------------------------------------------------------------------
alter PROCEDURE SP_Insert_Std_Phone_Table 
    @user_id VARCHAR(1000),
    @role VARCHAR(5),
    @STD_ID VARCHAR(1000),
    @phone VARCHAR(10) 
AS
BEGIN
      exec  PS_validate_id  @INS_ID= @user_id
    -- Check if the phone number length is valid
    IF (LEN(@phone) != 10)
    BEGIN
        PRINT 'Please enter a valid phone number';
        RETURN;
    END

    
    -- Check if the role is 'm' (manager) and if the user is a manager
    IF LOWER(@role) = 'm'
    BEGIN
        IF EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @user_id)
        BEGIN
				   -- Check if the student exists in the Student table
			IF NOT EXISTS (SELECT 1 FROM Student WHERE Std_ID = @STD_ID)
			BEGIN
				PRINT 'This student does not exist in the database';
				RETURN;
			END

			-- Check if the phone number already exists in the Std_Phone table
			IF EXISTS (SELECT 1 FROM Std_Phone WHERE Std_Phone = @phone)
			BEGIN
				PRINT 'The number already exists';
				RETURN;
			END

		         










            INSERT INTO Std_Phone (Std_ID, Std_Phone) -- Added Std_ID to the insert statement
            VALUES (@STD_ID, @phone);
        END
        ELSE
        BEGIN
            PRINT 'User is not a manager';
        END
    END
    ELSE
    BEGIN
        PRINT 'Only Manager (m) can insert into this table';
    END
END;
   -------------------------------
  exec SP_Insert_Std_Phone_Table 
    @user_id =2,
    @role ='m',
    @STD_ID ='1',
    @phone ='1233255001' 


----------------------------------------------------------------------
   alter proc SP_delete__Std_Phone_Table 
    @user_id varchar(1000),
      @role varchar(5),
	  @STD_ID  varchar(1000)
   as
   begin
		   if(lower(@role)='m')
				   begin
				    IF EXISTS (SELECT 1 FROM Department WHERE Mngr_Id = @user_id)
					begin 
					      	   -- Check if the student exists in the Student table
							IF NOT EXISTS (SELECT 1 FROM Student WHERE Std_ID = @STD_ID)
							BEGIN
								PRINT 'This student does not exist in the database';
								RETURN;
							END

							delete from Std_Phone
							where  Std_Phone=@STD_ID
					end
					  else
							begin
							 PRINT 'Only Manager (m) can insert  this table';

							  end

				   end

            else
					begin
					 PRINT 'Only Manager (m) can insert  this table';

					  end



   end

   --------------------------------------------------------------------------------------


    