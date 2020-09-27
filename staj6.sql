Soruların bir kısmına tekrar baktım,araştırma yaptım,SQL e çalıştım.
Aldığım notlar:

CREATE DATABASE databasename;
Tip:Make sure you have admin privilege before creating any database. Once a database is created,
     you can check it in the list of databases with the following SQL command: SHOW DATABASES;

DROP DATABASE databasename;

CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
)---the type of data the column can hold (e.g. varchar, integer, date, etc.)

CREATE TABLE new_table_name AS
    SELECT column1, column2,...
    FROM existing_table_name
    WHERE ....;---using another table
	

DROP TABLE Shippers;
TRUNCATE TABLE table_name;---is used to delete the data inside a table, but not the table itself.

The ALTER TABLE statement is used to add, delete, or modify columns in an existing table,
    is also used to add and drop various constraints on an existing table
	
ALTER TABLE table_name
ALTER COLUMN column_name datatype;

ALTER TABLE Persons ADD DateOfBirth date;->->->ALTER TABLE Persons ALTER COLUMN DateOfBirth year;
ALTER TABLE Persons DROP COLUMN DateOfBirth;

CREATE TABLE table_name (
    column1 datatype constraint,/*SQL constraints are used to specify rules for the data in a table.
	                            Constraints are used to limit the type of data that can go into a table.
								This ensures the accuracy and reliability of the data in the table. If there is any violation between the constraint and the data action, 
								the action is aborted.*/
    column2 datatype constraint,
    column3 datatype constraint,
);

NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Uniquely identifies a row/record in another table
CHECK - Ensures that all values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column when no value is specified
INDEX - Use to create and retrieve data from the database very quickly

select COUNTRY_NAME, CITY, COUNT(DEPARTMENT_ID)
from hr.countries join hr.locations using (COUNTRY_ID) join departments using (LOCATION_ID) where DEPARTMENT_ID in 
(select DEPARTMENT_ID from hr.employees group by DEPARTMENT_ID 
having count(DEPARTMENT_ID)>5) group by COUNTRY_NAME, CITY

Display details of current job for employees who worked as IT Programmers in the past. 
select * from hr.jobs where JOB_ID in 
   (select JOB_ID from hr.employees where EMPLOYEE_ID in 
   (select EMPLOYEE_ID from hr.job_history  where JOB_ID='IT_PROG'))
   
IF EXISTS (SELECT * FROM table_name WHERE id = ?)
BEGIN
--do what needs to be done if exists
END
ELSE
BEGIN
--do what needs to be done if not
END

DECLARE @<Değişken_Adı> <Değişken_tipi>
DECLARE @site_value INT;
SET @site_value = 10;

DECLARE @AD VARCHAR(20)
SET @AD = 'Nancy'
SELECT * FROM Northwind.dbo.Employees WHERE FirstName = @AD;

print '...'

Here is an example:

1> DECLARE @NumberOfPages SMALLINT;
2> SET @NumberOfPages = 16;
3> SELECT @NumberOfPages AS [Number of Pages];
4> GO
Number of Pages
---------------
             16

(1 rows affected)
