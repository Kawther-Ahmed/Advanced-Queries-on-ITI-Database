-----------------------------------<< AGGREGATE AND WINDOW FUNCTIONS >>-----------------------------------
/*Find Second highest total grade student for each department*/
SELECT *
FROM 
	(SELECT s.Dept_Id, s.St_Id, s.St_Fname, s.St_Lname, 
			ROW_NUMBER() OVER(PARTITION BY s.Dept_Id ORDER BY SUM(SC.Grade) DESC) AS highest_grade
	FROM Student s
	JOIN Stud_Course sc
	ON sc.St_Id = s.St_Id
	GROUP BY s.St_Id, s.St_Fname, s.St_Lname, s.Dept_Id) AS grade_table
WHERE highest_grade = 2

/*******************************************************/
/*Find Second Highest Instructor Salary for each Instructor Degree*/
SELECT *
FROM 
	(SELECT *, 
			ROW_NUMBER() OVER(PARTITION BY i.Ins_Degree ORDER BY i.Salary DESC) AS highest_salary
	FROM Instructor i
	WHERE i.Ins_Degree IS NOT NULL) AS instructor_salary
WHERE highest_salary = 2