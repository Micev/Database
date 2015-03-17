
						-- selec with mouse simple sqlQuery and press F5 -- 

--Problem 1.	Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees)

--Problem 2.	Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary <= (SELECT MIN(Salary) FROM Employees) * 1.10

--Problem 3.	Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
SELECT 
	e.FirstName + ' ' + ISNULL(e.MiddleName + ' ', '') + e.LastName as [full name],
	e.Salary,
	d.Name
FROM Employees e JOIN Departments d 
ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary = 
	(SELECT MIN(Salary) FROM Employees
	WHERE DepartmentID = e.DepartmentID)

--Problem 4.	Write a SQL query to find the average salary in the department #1.
SELECT
	AVG(Salary) as [Average Salary for department#1]
FROM Employees e
WHERE e.DepartmentID = 1

--Problem 5.	Write a SQL query to find the average salary in the "Sales" department.
SELECT
	AVG(Salary) as [Average Salary for "Sales"]
FROM Employees e JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

--Problem 6.	Write a SQL query to find the number of employees in the "Sales" department.
SELECT
	COUNT(*) as [Sales Employees Count]
FROM Employees e JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

--Problem 7.	Write a SQL query to find the number of all employees that have manager.
SELECT
	COUNT (ManagerID)
FROM Employees

--Problem 8.	Write a SQL query to find the number of all employees that have no manager.
SELECT
	COUNT (*) - COUNT(ManagerID)
FROM Employees

--Problem 9.	Write a SQL query to find all departments and the average salary for each of them.
SELECT
	d.Name AS [Department name],
	AVG(e.Salary) as [Average Salary]
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name

--Problem 10.	Write a SQL query to find the count of all employees in each department and for each town.
SELECT
	t.Name AS [Town],
	d.Name AS [Department],
	COUNT(*) AS [Employee Count]
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
JOIN Addresses a
	ON e.AddressID = a.AddressID
JOIN Towns t
	ON a.TownID = t.TownID
GROUP BY	d.Name,t.Name
ORDER BY d.Name

--Problem 11.	Write a SQL query to find all managers that have exactly 5 employees.
SELECT
	emp.FirstName,
	emp.LastName,
	COUNT(emp.ManagerID) as [Employees Count]
FROM Employees e
	JOIN Employees emp 
		ON e.ManagerID = emp.EmployeeID

GROUP BY emp.FirstName, emp.LastName, emp.ManagerID
HAVING COUNT(e.EmployeeID) = 5

--Problem 12.	Write a SQL query to find all employees along with their managers.
SELECT
	e.FirstName,
	e.LastName,
	ISNULL(emp.FirstName + ' ' + emp.LastName, 'no-manager') as [Manager]
FROM Employees e
	LEFT OUTER JOIN Employees emp 
		ON e.ManagerID = emp.EmployeeID

--Problem 13.	Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. 
SELECT
       FirstName, LastName
FROM Employees 
WHERE LEN(LastName) = 5

--Problem 14.	Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds". 
SELECT
	CONVERT(NVARCHAR, GETDATE(), 4) + ' ' + 
	CONVERT(NVARCHAR, GETDATE(), 114) AS DateTIme

--Problem 15.	Write a SQL statement to create a table Users.
CREATE TABLE Users
(
        UserId INT PRIMARY KEY IDENTITY NOT NULL,
        Username VARCHAR(100) NOT NULL UNIQUE,
        Password VARCHAR(100),
        FullName nvarchar(100) NULL,
        LastLoggedIn datetime,
        CONSTRAINT check_Password CHECK (LEN(Password) > 5)
)
GO
--Problem 16.	Write a SQL statement to create a view that displays the users from the Users table that have been in the system today.
CREATE VIEW vLoggedUserToday AS
SELECT * FROM Users
WHERE DAY(LastLoggedIn) = DAY(GETDATE())
GO

--Problem 17.	Write a SQL statement to create a table Groups. 
CREATE TABLE Groups
(
        Id INT PRIMARY KEY IDENTITY NOT NULL,
        Name VARCHAR(50) UNIQUE NOT NULL
)
GO

--Problem 18.	Write a SQL statement to add a column GroupID to the table Users.
ALTER TABLE Users
ADD GroupId INT NOT NULL,
FOREIGN KEY(GroupId) REFERENCES Groups(Id)

--Problem 19.	Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Groups VALUES ('Owner')
INSERT INTO Groups VALUES ('Admin')
INSERT INTO Groups VALUES ('User')
 
INSERT INTO Users VALUES ('Gosho', '123456', ' Gosho Peshev',  GETDATE(),1)
INSERT INTO Users VALUES ('Vaso', '123456', ' Vaso Peshev',  GETDATE(),2)

--Problem 20.	Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users SET Username = 'Gosho update'
WHERE UserId = 1

--Problem 21.	Write SQL statements to delete some of the records from the Users and Groups tables.
DELETE FROM Users
WHERE UserId = 2
GO

-- Problem 22.  Write SQL statements to insert in the Users table the names of all employees from the Employees table.
 INSERT INTO Users
SELECT LEFT(FirstName, 1) + LOWER(LastName) + ISNULL(LEFT(MiddleName, 1), ''), LEFT(FirstName, 1) + LEFT(LOWER(LastName) + 'pass', 5),
FirstName + ' ' + LastName, GETDATE(),1 FROM Employees
GO

-- Problem 23.  Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010. 
ALTER TABLE Users
ALTER COLUMN Password VARCHAR(20) NULL
 
UPDATE Users SET Password = NULL
WHERE LastLoggedIn <= '2010-03-10'

-- Problem 24.  Write a SQL statement that deletes all users without passwords (NULL password).
DELETE FROM Users
WHERE Password IS NULL

-- Problem 25.  Write a SQL query to display the average employee salary by department and job title.
SELECT dep.Name AS [Department Name], emp.JobTitle, AVG(emp.Salary) AS [Average Salary] 
FROM Employees emp
INNER JOIN Departments dep ON emp.DepartmentID = dep.DepartmentID
GROUP BY dep.Name, emp.JobTitle
ORDER BY emp.JobTitle

-- Problem 26.  Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it.
SELECT 
	dep.Name AS [Department Name],
	emp.JobTitle, 
	emp.FirstName, 
	MIN(emp.Salary) AS [Minmum Salary]
FROM Employees emp
INNER JOIN Departments dep ON emp.DepartmentID = dep.DepartmentID
GROUP BY dep.Name, emp.JobTitle, emp.FirstName, emp.LastName
ORDER BY dep.Name

-- Problem 27.  Write a SQL query to display the town where maximal number of employees work.
SELECT TOP 1 * 
FROM (SELECT t.Name, COUNT(*) AS [EmployeeCount] 
	FROM Employees emp
		JOIN Addresses ads ON ads.AddressID = emp.AddressID
		JOIN Towns t ON t.TownID = ads.TownID
	GROUP BY t.Name) ec
ORDER BY ec.EmployeeCount DESC

-- Problem 28.  Write a SQL query to display the number of managers from each town.
SELECT t.Name, COUNT(*) as [Manager Count] FROM Employees emp
INNER JOIN Addresses ads ON ads.AddressID = emp.AddressID
INNER JOIN Towns t ON t.TownID = ads.TownID
WHERE emp.ManagerID IS NOT NULL
GROUP BY t.Name

-- Problem 29.  Write a SQL to create table WorkHours to store work reports for each employee.
 CREATE TABLE WorkHours
(
        Id INT PRIMARY KEY IDENTITY NOT NULL,
        TaskDate datetime NULL,
        Task nvarchar(125) NOT NULL,
        Hours SMALLINT NOT NULL,
        Comments ntext NULL
)
GO
 
ALTER TABLE WorkHours
ALTER COLUMN Comments VARCHAR(MAX) NULL

-- Problem 30.  Issue few SQL statements to insert, update and delete of some data in the table.
 
INSERT INTO WorkHours VALUES (GETDATE(), 'Lorem ipsum dolor sit amet', 4, 'Duis condimentum fringilla augue ut ornare')

UPDATE WorkHours SET TaskDate = DATEADD(MONTH, 2, GETDATE()) WHERE Id = 1

DELETE FROM WorkHours WHERE Id = 1

-- Problem 31.	Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
CREATE TABLE WorkHoursLogs
(
        Id int PRIMARY KEY IDENTITY NOT NULL,
		Message nvarchar(150) NOT NULL,
		DateOfChange datetime NOT NULL
)

GO

CREATE TRIGGER  tr_WorkHoursInsert 
ON WorkHours
 FOR INSERT
AS 
	INSERT INTO WorkHoursLogs (Message, DateOfChange)
	VALUES('Added row', GETDATE ( ))
GO

CREATE TRIGGER  tr_WorkHoursDelete 
ON WorkHours
 FOR DELETE
AS 
	INSERT INTO WorkHoursLogs (Message, DateOfChange)
	VALUES('Deleted row', GETDATE ( ))
GO

CREATE TRIGGER  tr_WorkHoursUpdate
ON WorkHours
 FOR UPDATE
AS 
	INSERT INTO WorkHoursLogs (Message, DateOfChange)
	VALUES('Update row', GETDATE ( ))
GO

INSERT INTO WorkHours (Id, TaskDate, Task, Hours)
	VALUES(10, GETDATE ( ), 'Work Hard', 10)

INSERT INTO WorkHours (Id, TaskDate, Task, Hours)
	VALUES(11, GETDATE ( ), 'Hard work', 100)

DELETE WorkHours
WHERE Id = 10

UPDATE WorkHours
SET Task = 'Hour Work'
WHERE Id = 11

SELECT * FROM WorkHoursLogs

-- Problem 32.  Start a database transaction, delete all employees from the 'Sales' department along with all dependent records from the pother tables. At the end rollback the transaction.
BEGIN TRAN;

DELETE Employees 
FROM Employees e JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales';

ROLLBACK TRAN;

-- Problem 33.  Start a database transaction and drop the table EmployeesProjects.
BEGIN TRAN
DROP TABLE EmployeesProjects
ROLLBACK
SELECT * FROM EmployeesProjects

-- Problem 34.  Find how to use temporary tables in SQL Server.
 
DECLARE @tempEmplProjTable TABLE
(
        EmployeeID INT NOT NULL,
        ProjectID INT NOT NULL
)
INSERT INTO @tempEmplProjTable
        SELECT EmployeeID, ProjectID FROM EmployeesProjects
DROP TABLE EmployeesProjects
CREATE TABLE EmployeesProjects
(
        EmployeeID INT NOT NULL,
        ProjectID INT NOT NULL
)
INSERT INTO EmployeesProjects
        SELECT * FROM @tempEmplProjTable
GO
