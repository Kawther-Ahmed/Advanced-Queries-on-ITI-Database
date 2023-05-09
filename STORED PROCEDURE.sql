--------------------------------------<< STORED PROCEDURE >>--------------------------------------
/*Create a stored procedure to show the number of students per department.[use ITI DB]*/

USE ITI_new
GO
CREATE PROC show_student_number
AS
	SELECT d.Dept_Name, COUNT(s.St_Id)
	FROM Department d, Student s
	WHERE s.Dept_Id = d.Dept_Id
	GROUP BY d.Dept_Name
GO
show_student_number

/*************************************************/
