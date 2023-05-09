-----------------------------------<< INDEXES AND CURSORS >>-----------------------------------
/*Create an index on column (Hiredate) that allow u to cluster 
the data in the table Department. What will happen?*/
USE ITI_new
CREATE CLUSTERED INDEX in1
ON Department(Manager_hiredate)

DROP INDEX in1 ON Department


/*******************************************************/
/*Create an index that allows you to enter unique ages 
in the student table. What will happen?*/
--There is more than one NULL
CREATE UNIQUE NONCLUSTERED INDEX in2
ON [dbo].[Student](St_Age)


/*******************************************************/
/*create a non-clustered index on column(Dept_Manager) 
that allows you to enter a unique instructor id in the table Department.*/
CREATE UNIQUE NONCLUSTERED INDEX in3
ON [dbo].[Department](Dept_Manager)


/*****************************CURSOR*****************************/
/*In ITI database Count times that amr apper after ahmed in student table 
in st_Fname column (using the cursor)*/
DECLARE c1 CURSOR
FOR
	SELECT St_Fname
	FROM Student
	WHERE St_Fname IS NOT NULL

FOR READ ONLY
DECLARE @exist_ahmed INT = 0, @counter INT = 0, @name VARCHAR(50)
OPEN c1
FETCH c1 INTO @name
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@name = 'Ahmed')
			BEGIN
				SET @exist_ahmed = 1
			END
		IF (@name = 'Amr' AND @exist_ahmed = 1)
			BEGIN
				SET @counter = @counter + 1
			END
		FETCH c1 INTO @name
	END
SELECT @counter counter_of_amr
CLOSE c1
DEALLOCATE c1


/*******************************************************/
/*In ITI database Count times that amr apper after ahmed in student table 
in st_Fname column (using the cursor)*/
--Must be Ahmed then Amr in the next row
DECLARE cc1 CURSOR
FOR
	SELECT St_Fname
	FROM Student
	WHERE St_Fname IS NOT NULL

FOR READ ONLY
DECLARE @current_name VARCHAR(50), @previous_name VARCHAR(50), @amr_counter INT = 0
OPEN cc1
FETCH cc1 INTO @current_name
WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@current_name = 'Amr' AND @previous_name = 'Ahmed')
			BEGIN
				SET @amr_counter = @amr_counter + 1
			END

		SET @previous_name = @current_name
		FETCH cc1 INTO @current_name
	END
SELECT @amr_counter counter_of_amr
CLOSE cc1
DEALLOCATE cc1

