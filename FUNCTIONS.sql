--------------------------------------<< FUNCTIONS >>--------------------------------------
/*Create a scalar function that takes a date and returns the Month name of that date. test (‘1/12/2009’)*/
GO
ALTER FUNCTION date_month(@input VARCHAR(20))
RETURNS VARCHAR(20)
BEGIN
	DECLARE @date date 
	SET @date = convert (date, @input)
	DECLARE @month VARCHAR(20)
	/*SELECT @month = FORMAT(CONVERT(DATE, @date), 'MMMM')*/
	/*SELECT @month = FORMAT(@date, 'MMMM')*/
	SELECT @month = DATENAME(month, @input)

	RETURN @month
END
GO
SELECT dbo.date_month('2009/12/1') AS My_Month


/*************************************************/
/*Create a multi-statements table-valued function that takes 2 integers and returns the values between them.*/
GO
CREATE FUNCTION table_valued_function (@x int, @y int)
RETURNS @t TABLE (numbers int)
AS
BEGIN
	DECLARE @counter int
	SET @counter = @x + 1
	WHILE (@counter < @y)
		BEGIN
			INSERT INTO @t VALUES(@counter)
			SET @counter += 1
		END
RETURN
END
GO
SELECT * FROM dbo.table_valued_function(10, 20)


/*************************************************/
/*Create a tabled valued function that takes Student No and returns Department Name with Student full name.*/
GO
CREATE FUNCTION student_full_data(@id int)
RETURNS TABLE
AS
RETURN (
	SELECT d.Dept_Name, s.St_Fname + ' ' + s.St_Lname Full_Name
	FROM Student s
	JOIN Department d
	ON s.Dept_Id = d.Dept_Id
	WHERE s.St_Id = @id
)
GO
SELECT * FROM student_full_data(7)


/*************************************************/
/*Create a scalar function that takes Student ID and returns a message to the user (use Case statement)
a.	If the first name and Last name are null then display 'First name & last name are null'
b.	If the First name is null then display 'first name is null'
c.	If the Last name is null then display 'last name is null'
d.	Else display 'First name & last name are not null'*/
GO
CREATE FUNCTION student_message(@id int)
RETURNS VARCHAR(100)
BEGIN
	DECLARE @f_name VARCHAR(20), @l_name VARCHAR(20)
	SELECT @f_name=s.St_Fname, @l_name=s.St_Lname
	FROM Student s
	WHERE s.St_Id = @id

RETURN
	CASE
		WHEN @f_name IS NULL THEN 'first name is null'
		WHEN @l_name IS NULL THEN 'last name is null'
		WHEN @f_name IS NULL AND @l_name IS NULL THEN 'First name & last name are null'
		ELSE 'First name & last name are not null'
	END
END
GO
SELECT dbo.student_message(5)
SELECT dbo.student_message(14)


/*************************************************/
/*Create a function that takes an integer that represents the format of the Manager hiring date 
and displays department name, Manager Name, and hiring date with this format.*/
GO
CREATE FUNCTION hiring_date(@format int)
RETURNS TABLE
AS
RETURN(
	SELECT d.Dept_Name, i.Ins_Name, convert(varchar, d.Manager_hiredate, @format) hiring_date
	FROM Department d
	JOIN Instructor i
	ON d.Dept_Manager = i.Ins_Id
)
GO
SELECT * FROM hiring_date(101)


/*************************************************/
/*Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table 
Note: Use the “ISNULL” function*/
GO
ALTER FUNCTION student_name(@string VARCHAR(100))
RETURNS @t TABLE (name VARCHAR(100))
AS
BEGIN
	IF @string='first name' 
		BEGIN
			INSERT INTO @t
			SELECT ISNULL(s.St_Fname, 'There is no first name')
			/*SELECT s.St_Fname*/
			FROM Student s
		END

	ELSE IF @string='last name'  
		BEGIN
			INSERT INTO @t
			SELECT ISNULL(s.St_Lname, 'There is no last name')
			/*SELECT s.St_Lname*/
			FROM Student s
		
		END
	ELSE IF @string='full name'  
		BEGIN
			INSERT INTO @t
			SELECT ISNULL(s.St_Fname + ' ' + s.St_Lname, 'There is no name') full_name
			/*SELECT s.St_Fname + ' ' + s.St_Lname full_name*/
			FROM Student s
		END
RETURN
END
GO
SELECT * FROM student_name('full name')


/*************************************************/
/*Write a query that returns the Student No and Student first name without the last char*/
SELECT s.St_Id, SUBSTRING(s.St_Fname, 1, LEN(s.St_Fname)-1) first_name
FROM Student s