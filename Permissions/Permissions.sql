--Student
DENY EXECUTE ON OBJECT:: [dbo].[Insert_Department] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Delete_Department] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Show_Departments] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Update_Departments] TO student
DENY EXECUTE ON OBJECT:: [dbo].[SP_Add_Exam] TO student
DENY EXECUTE ON OBJECT:: [dbo].[SP_StudentSolution] TO student
DENY EXECUTE ON OBJECT:: [dbo].[DetailsCoursesStudentbyInstuctorID] TO student
DENY EXECUTE ON OBJECT:: [dbo].[GetStdInfoByDeptNo] TO student;
DENY SELECT ON OBJECT:: [dbo].[View_Student_Department] TO student;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Student_AnswerSheet]TO student;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_FullExam] TO student;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Student_Ex_Answers] TO student;


-- Instructor
DENY EXECUTE ON OBJECT:: [dbo].[Insert_Department] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Delete_Department] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Show_Departments] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Update_Departments] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Add_Exam] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[SP_StudentSolution] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[DetailsCoursesStudentbyInstuctorID] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[GetStdInfoByDeptNo] TO instructor;
GRANT SELECT ON OBJECT:: [dbo].[View_Student_Department] TO instructor;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Student_AnswerSheet]TO instructor;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_FullExam] TO instructor;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Student_Ex_Answers] TO instructor;
-- Manager
GRANT EXECUTE ON OBJECT:: [dbo].[Insert_Department] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[Delete_Department] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[Show_Departments] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[Update_Departments] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Add_Exam] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_StudentSolution] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[DetailsCoursesStudentbyInstuctorID] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[GetStdInfoByDeptNo] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[View_Student_Department] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Student_AnswerSheet]TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_FullExam] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Student_Ex_Answers] TO manager;

--Student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Details] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Update_Instructor] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Phones] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor_Phone] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor_phone] TO student
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Update_Instructor_Phone] TO student;
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Course] TO student;
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor_Course]TO student;
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor_Course] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Exam_Full_Details] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_CountInstructor_ForAllDept] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_All_InstructorName_CourseName_DeptName] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Instructor_Works_Dept] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Training_Manager_Details] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor_Course] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor_Phone] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_Manger_ID] TO student;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor] TO student;


-- Instructor
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Details] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Update_Instructor] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Phones] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor_Phone] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor_phone] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Update_Instructor_Phone] TO instructor;
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Course] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor_Course]TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor_Course] TO instructor;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Exam_Full_Details] TO instructor;
DENY SELECT ON OBJECT:: [dbo].[Vw_CountInstructor_ForAllDept] TO instructor;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_All_InstructorName_CourseName_DeptName] TO instructor;
DENY SELECT ON OBJECT:: [dbo].[Vw_Instructor_Works_Dept] TO instructor;
DENY SELECT ON OBJECT:: [dbo].[Vw_Training_Manager_Details] TO instructor;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor_Course] TO instructor;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor_Phone] TO instructor;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_Manger_ID] TO instructor;
DENY SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor] TO instructor;

-- Manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Details] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Update_Instructor] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Phones] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor_Phone] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor_phone] TO manager
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Update_Instructor_Phone] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Show_Instructor_Course] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Add_New_Instructor_Course]TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[Proc_Delete_Instructor_Course] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Exam_Full_Details] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_Instructor_Salary_Tab] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_CountInstructor_ForAllDept] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_All_InstructorName_CourseName_DeptName] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Instructor_Works_Dept] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Training_Manager_Details] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor_Course] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor_Phone] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_Manger_ID] TO manager;
GRANT SELECT ON OBJECT:: [dbo].[Vw_Show_All_Instructor] TO manager;


-- Instructor
GRANT EXECUTE ON OBJECT:: [dbo].[SP_DisplayIntake_Table] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forINS] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispalyStd_Crs_forINS] TO instructor
GRANT EXECUTE ON OBJECT:: [dbo].[SP_DisplayStd_Crs_Table] TO instructor;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table] TO instructor;

DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forTM] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_update_Intake_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_delete_Intake_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table_forTM] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Insert_Std_Phone_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_delete__Std_Phone_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Update_Std_Phone_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Display_Std_Crs_Tablefor_TM] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_update_std_crs_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_delete_Std_Crs_Table] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Insert_Std_Crs_TableforTM] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispalyStd_Crs_forST] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forST] TO instructor;
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table] TO instructor;



-- Manager

GRANT EXECUTE ON OBJECT:: [dbo].[SP_DisplayIntake_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forTM] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_update_Intake_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_delete_Intake_Table] TO manager;

GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table_forTM] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Insert_Std_Phone_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_delete__Std_Phone_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Update_Std_Phone_Table] TO manager;

GRANT EXECUTE ON OBJECT:: [dbo].[SP_DisplayStd_Crs_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Display_Std_Crs_Tablefor_TM] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_update_std_crs_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_delete_Std_Crs_Table] TO manager;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Insert_Std_Crs_TableforTM] TO manager;

DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forINS] TO manager
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispalyStd_Crs_forINS] TO manager
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispalyStd_Crs_forST] TO manager
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forST] TO manager
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table] TO manager;



--Student
GRANT EXECUTE ON OBJECT:: [dbo].[SP_Update_Std_Phone_Table] TO student
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispalyStd_Crs_forST] TO student
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forST] TO student

GRANT EXECUTE ON OBJECT:: [dbo].[SP_DisplayIntake_Table] TO Student;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table] TO Student;
GRANT EXECUTE ON OBJECT:: [dbo].[SP_DisplayStd_Crs_Table] TO Student;


DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forINS] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispalyStd_Crs_forINS] TO instructor
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Intake_Table_forTM] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_update_Intake_Table] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_delete_Intake_Table] TO Student;
							   
DENY EXECUTE ON OBJECT:: [dbo].[SP_dispaly_Std_Phone_Table_forTM] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Insert_Std_Phone_Table] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_delete__Std_Phone_Table] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Update_Std_Phone_Table] TO Student;
							  
DENY EXECUTE ON OBJECT:: [dbo].[SP_Display_Std_Crs_Tablefor_TM] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_update_std_crs_Table] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_delete_Std_Crs_Table] TO Student;
DENY EXECUTE ON OBJECT:: [dbo].[SP_Insert_Std_Crs_TableforTM] TO Student;
