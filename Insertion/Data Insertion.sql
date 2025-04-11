use System_Exam;
-- -----------------------------------------------------
-- Data for table System_Exam.Branch
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Branch (BranchID, BranchName) VALUES (1, 'Cairo');
INSERT IGNORE INTO System_Exam.Branch (BranchID, BranchName) VALUES (2, 'Alexandria');
INSERT IGNORE INTO System_Exam.Branch (BranchID, BranchName) VALUES (3, 'Giza');
INSERT IGNORE INTO System_Exam.Branch (BranchID, BranchName) VALUES (4, 'Mansoura');
INSERT IGNORE INTO System_Exam.Branch (BranchID, BranchName) VALUES (5, 'Aswan');
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Track
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Track (TrackID, TrackName, BranchID) VALUES (1, 'Web Development', 1);
INSERT IGNORE INTO System_Exam.Track (TrackID, TrackName, BranchID) VALUES (2, 'Mobile Development', 1);
INSERT IGNORE INTO System_Exam.Track (TrackID, TrackName, BranchID) VALUES (3, 'Data Science', 2);
INSERT IGNORE INTO System_Exam.Track (TrackID, TrackName, BranchID) VALUES (4, 'Network Administration', 3);
INSERT IGNORE INTO System_Exam.Track (TrackID, TrackName, BranchID) VALUES (5, 'Cyber Security', 2);
INSERT IGNORE INTO System_Exam.Track (TrackID, TrackName, BranchID) VALUES (6, 'UI/UX Design', 1);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Intake
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Intake (IntakeID, IntakeName, TrackID) VALUES (1, 'September 2024', 1);
INSERT IGNORE INTO System_Exam.Intake (IntakeID, IntakeName, TrackID) VALUES (2, 'October 2024', 2);
INSERT IGNORE INTO System_Exam.Intake (IntakeID, IntakeName, TrackID) VALUES (3, 'November 2024', 3);
INSERT IGNORE INTO System_Exam.Intake (IntakeID, IntakeName, TrackID) VALUES (4, 'December 2024', 1);
INSERT IGNORE INTO System_Exam.Intake (IntakeID, IntakeName, TrackID) VALUES (5, 'January 2025', 4);
INSERT IGNORE INTO System_Exam.Intake (IntakeID, IntakeName, TrackID) VALUES (6, 'February 2025', 5);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Instructor
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Instructor (InstructorID, Name, Email, IsTrainingManager) VALUES (1, 'Ahmed Hassan', 'ahmed.hassan@example.com', 1);
INSERT IGNORE INTO System_Exam.Instructor (InstructorID, Name, Email, IsTrainingManager) VALUES (2, 'Sara Ahmed', 'sara.ahmed@example.com', 0);
INSERT IGNORE INTO System_Exam.Instructor (InstructorID, Name, Email, IsTrainingManager) VALUES (3, 'Mohamed Ali', 'mohamed.ali@example.com', 0);
INSERT IGNORE INTO System_Exam.Instructor (InstructorID, Name, Email, IsTrainingManager) VALUES (4, 'Fatima Ibrahim', 'fatima.ibrahim@example.com', 1);
INSERT IGNORE INTO System_Exam.Instructor (InstructorID, Name, Email, IsTrainingManager) VALUES (5, 'Omar Khaled', 'omar.khaled@example.com', 0);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Course
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Course (CourseID, CourseName, Description, MaxDegree, MinDegree, InstructorID) VALUES (1, 'JavaScript Fundamentals', 'Introduction to JavaScript programming language', 100, 60, 1);
INSERT IGNORE INTO System_Exam.Course (CourseID, CourseName, Description, MaxDegree, MinDegree, InstructorID) VALUES (2, 'React Framework', 'Building modern web applications with React', 100, 60, 2);
INSERT IGNORE INTO System_Exam.Course (CourseID, CourseName, Description, MaxDegree, MinDegree, InstructorID) VALUES (3, 'Mobile App Development', 'Creating applications for iOS and Android', 100, 60, 3);
INSERT IGNORE INTO System_Exam.Course (CourseID, CourseName, Description, MaxDegree, MinDegree, InstructorID) VALUES (4, 'Database Design', 'Principles of relational database design', 100, 50, 4);
INSERT IGNORE INTO System_Exam.Course (CourseID, CourseName, Description, MaxDegree, MinDegree, InstructorID) VALUES (5, 'Python for Data Science', 'Using Python for data analysis and visualization', 100, 60, 5);
INSERT IGNORE INTO System_Exam.Course (CourseID, CourseName, Description, MaxDegree, MinDegree, InstructorID) VALUES (6, 'Network Security', 'Fundamentals of securing computer networks', 100, 70, 4);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Questions
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Questions (QuestionID, QuestionText, Ques_Type, CorrectAnswer, BestAcceptedAnswer, CourseID) VALUES (1, 'What is JavaScript?', 'MCQ', 'A browser-based programming language', 'A browser-based programming language used for web development', 1);
INSERT IGNORE INTO System_Exam.Questions (QuestionID, QuestionText, Ques_Type, CorrectAnswer, BestAcceptedAnswer, CourseID) VALUES (2, 'Explain the concept of state in React', 'Essay', 'State is component-specific data storage', 'State is a JavaScript object that stores component data and determines the component\'s behavior', 2);
INSERT IGNORE INTO System_Exam.Questions (QuestionID, QuestionText, Ques_Type, CorrectAnswer, BestAcceptedAnswer, CourseID) VALUES (3, 'What are the key features of Flutter?', 'MCQ', 'Cross-platform development capabilities', 'Cross-platform native app development using a single codebase', 3);
INSERT IGNORE INTO System_Exam.Questions (QuestionID, QuestionText, Ques_Type, CorrectAnswer, BestAcceptedAnswer, CourseID) VALUES (4, 'Describe the purpose of normalization in database design', 'Essay', 'To reduce data redundancy', 'To organize data efficiently by eliminating redundancy and ensuring data integrity', 4);
INSERT IGNORE INTO System_Exam.Questions (QuestionID, QuestionText, Ques_Type, CorrectAnswer, BestAcceptedAnswer, CourseID) VALUES (5, 'How does NumPy differ from regular Python lists?', 'MCQ', 'NumPy arrays are more efficient for numerical operations', 'NumPy arrays are optimized for numerical computations and offer better performance', 5);
INSERT IGNORE INTO System_Exam.Questions (QuestionID, QuestionText, Ques_Type, CorrectAnswer, BestAcceptedAnswer, CourseID) VALUES (6, 'What is a firewall?', 'MCQ', 'A security device that monitors network traffic', 'A security system that monitors and controls incoming and outgoing network traffic', 6);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Exam
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Exam (ExamID, ExamType, StartTime, EndTime, TotalTime, AllowanceOptions, Year, CourseID, InstructorID) VALUES (1, 'Midterm', '2025-01-15 10:00:00', '2025-01-15 12:00:00', 120, 'No materials allowed', 2025, 1, 1);
INSERT IGNORE INTO System_Exam.Exam (ExamID, ExamType, StartTime, EndTime, TotalTime, AllowanceOptions, Year, CourseID, InstructorID) VALUES (2, 'Final', '2025-02-20 09:00:00', '2025-02-20 12:00:00', 180, 'Calculator allowed', 2025, 1, 1);
INSERT IGNORE INTO System_Exam.Exam (ExamID, ExamType, StartTime, EndTime, TotalTime, AllowanceOptions, Year, CourseID, InstructorID) VALUES (3, 'Midterm', '2025-01-16 10:00:00', '2025-01-16 12:00:00', 120, 'No materials allowed', 2025, 2, 2);
INSERT IGNORE INTO System_Exam.Exam (ExamID, ExamType, StartTime, EndTime, TotalTime, AllowanceOptions, Year, CourseID, InstructorID) VALUES (4, 'Quiz', '2025-01-10 09:00:00', '2025-01-10 10:00:00', 60, 'Open book', 2025, 3, 3);
INSERT IGNORE INTO System_Exam.Exam (ExamID, ExamType, StartTime, EndTime, TotalTime, AllowanceOptions, Year, CourseID, InstructorID) VALUES (5, 'Final', '2025-02-22 09:00:00', '2025-02-22 12:00:00', 180, 'Calculator allowed', 2025, 4, 4);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Choices
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (1, 'A browser-based programming language', 1, 1);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (2, 'A server-side programming language', 0, 1);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (3, 'A markup language', 0, 1);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (4, 'A database query language', 0, 1);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (5, 'Cross-platform development capabilities', 1, 3);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (6, 'Single platform focus', 0, 3);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (7, 'Limited UI components', 0, 3);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (8, 'Slow performance', 0, 3);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (9, 'NumPy arrays are more efficient for numerical operations', 1, 5);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (10, 'NumPy is slower than regular Python lists', 0, 5);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (11, 'NumPy can only handle integers', 0, 5);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (12, 'NumPy cannot be used for scientific computing', 0, 5);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (13, 'A security device that monitors network traffic', 1, 6);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (14, 'A type of computer virus', 0, 6);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (15, 'A hardware encryption device', 0, 6);
INSERT IGNORE INTO System_Exam.Choices (ChoiceID, ChoiceText, IF_Correct, QuestionID) VALUES (16, 'A password manager', 0, 6);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Student
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (1, 'Amr Mohamed', 'amr.mohamed@example.com', 1);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (2, 'Layla Mahmoud', 'layla.mahmoud@example.com', 1);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (3, 'Khaled Tamer', 'khaled.tamer@example.com', 2);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (4, 'Aisha Salem', 'aisha.salem@example.com', 3);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (5, 'Youssef Hamdy', 'youssef.hamdy@example.com', 4);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (6, 'Nour Alaa', 'nour.alaa@example.com', 2);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (7, 'Adel Magdy', 'adel.magdy@example.com', 5);
INSERT IGNORE INTO System_Exam.Student (StudentID, Name, Email, IntakeID) VALUES (8, 'Yasmin Samir', 'yasmin.samir@example.com', 6);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Student_Answers
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (1, 'A browser-based programming language', 10, 1, 1, 1, 1);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (2, 'State is used to store component data that can change over time', 15, 0, 1, 2, 1);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (3, 'Cross-platform development with native performance', 8, 0, 1, 3, 1);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (4, 'A browser-based programming language', 5, 1, 1, 1, 2);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (5, 'State allows React components to create and manage their own data', 18, 1, 1, 2, 2);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (6, 'A hardware security system', 0, 0, 3, 6, 4);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (7, 'A security device that monitors network traffic', 20, 1, 4, 6, 5);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (8, 'Normalization is the process of organizing data to reduce redundancy', 22, 1, 4, 4, 5);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (9, 'State is a JavaScript object that stores component data', 13, 0, 2, 2, 3);
INSERT IGNORE INTO System_Exam.Student_Answers (StudentAnswerID, Std_Answer, Mark, IsCorrect, StudentID, QuestionID, ExamID) VALUES (10, 'NumPy provides efficient arrays for numerical operations', 15, 1, 5, 5, 5);
COMMIT;

-- -----------------------------------------------------
-- Data for table System_Exam.Exam_Question
-- -----------------------------------------------------
START TRANSACTION;
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (1, 1, 10);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (1, 2, 20);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (1, 3, 10);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (2, 1, 5);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (2, 2, 20);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (2, 3, 15);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (2, 4, 20);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (3, 2, 15);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (3, 5, 15);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (4, 3, 20);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (4, 6, 20);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (5, 4, 25);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (5, 5, 15);
INSERT IGNORE INTO System_Exam.Exam_Question (ExamID, QuestionID, Marks) VALUES (5, 6, 10);
COMMIT;

