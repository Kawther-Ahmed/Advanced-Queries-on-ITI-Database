------------------------------------<< VIEWS >>------------------------------------
/**/
/*Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department “. */
GO
CREATE VIEW instructor_department AS
	SELECT Ins_Name, Dept_Name
	FROM Instructor inst
	JOIN Department dept
	ON inst.Dept_Id = dept.Dept_Id
	WHERE dept.Dept_Name = 'SD' OR dept.Dept_Name = 'Java'
GO
SELECT * FROM instructor_department


/*************************************************/
/*Create a view “V1” that displays student data for the student who lives in Alex or Cairo.
Note: Prevent the users to run the following query Update V1 set st_address=’tanta’  Where st_address=’alex’*/

GO
CREATE VIEW V1 AS
	SELECT *
	FROM Student stud
	WHERE stud.St_Address IN ('Alex', 'Cairo')
	WITH CHECK OPTION
GO
SELECT * FROM V1


/*************************************************/
/*Create a view that displays the student’s full name, course name if the student has a grade of more than 50.*/
GO
CREATE VIEW student_data AS
	SELECT stud.St_Fname + ' ' + stud.St_Lname full_name, crs.Crs_Name course_name
	FROM Student stud
	JOIN Stud_Course stud_c
	ON stud_c.St_Id = stud.St_Id
	JOIN Course crs
	ON stud_c.Crs_Id = crs.Crs_Id
	WHERE stud_c.Grade > 50
GO
SELECT * FROM student_data


/*************************************************/
/*Create an Encrypted view that displays manager names and the topics they teach. 
(Hint :To Find Instructor who work as manger using Manage Relation Ship between instructor 
and department PK =[dbo].[Instructor]. [Ins_Id] FK =[dbo].[Department]. [Dept_Manager]  )*/
GO
ALTER VIEW manager_view
WITH ENCRYPTION
AS
	SELECT ins.Ins_Name Manager, topi.Top_Name Topic_Name
	FROM Instructor ins
	JOIN Department dept
	ON dept.Dept_Manager = ins.Ins_Id
	JOIN Ins_Course ins_crs
	ON ins_crs.Ins_Id = ins.Ins_Id
	JOIN Course crs
	ON ins_crs.Crs_Id = crs.Crs_Id
	JOIN Topic topi
	ON crs.Top_Id = topi.Top_Id
GO
SELECT * FROM manager_view

/*************************************************/