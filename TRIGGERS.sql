-------------------------------------<< TRIGGERS >>-------------------------------------
/*Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
Print a message for the user to tell him that he ‘can’t insert a new record in that table’*/

USE ITI_new
GO
ALTER TRIGGER prevent_insert_department
ON [dbo].[Department]
INSTEAD OF INSERT
AS
	SELECT 'Can’t insert a new record in that table'

INSERT INTO Department(Dept_Id) VALUES(100)
SELECT * FROM Department
DELETE FROM Department WHERE Dept_Id = 100
	

/*************************************************/
/*Create a trigger on student table after insert 
to add Row in a Student Audit table (Server User Name, Date, Note) 
where the note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”*/

GO
USE ITI_new
GO
CREATE TABLE Audit_table(
	ServerName varchar(max),
	InsertedDate date,
	Note varchar(max)
)
GO
ALTER TRIGGER insert_student
ON [dbo].[Student]
AFTER INSERT
AS
	DECLARE @Note varchar(max), @Id int
	SELECT @Id = St_Id FROM inserted
	SELECT @Note = CONCAT(SUSER_NAME(), ' Insert New Row with Key=', @Id,' in table Student')
	--SELECT @Note = St_Id FROM inserted

	INSERT INTO Audit_table VALUES (@@SERVERNAME, GETDATE(), @Note)
	SELECT * FROM Audit_table

INSERT INTO Student(St_Id) VALUES(5000)
DELETE FROM Student WHERE St_Id=5000