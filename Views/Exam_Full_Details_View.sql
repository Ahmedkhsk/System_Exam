alter view Vw_Exam_Full_Details
as
select distinct E.Exam_No , E.Exam_Date , E.Exam_Type , E.Exam_Time ,
B.Branch_Name , B.Intake_Name , 
T.Track_Name , 
C.Crs_Name 
from Branch B, Intake Intk, Track T , Student S , Course C , Std_Crs SC , Exam E
where B.Intake_Name = Intk.Int_Name 
and T.Intake_Name = Intk.Int_Name 
and S.Int_Name = Intk.Int_Name
and SC.Crs_ID = C.Crs_Id
and C.Crs_Id = E.Crs_ID
--test
select * from Vw_Exam_Full_Details