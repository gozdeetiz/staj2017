MySQL comes with the following data types for storing a date or a date/time value in the database:

DATE - format YYYY-MM-DD
DATETIME - format: YYYY-MM-DD HH:MI:SS
TIMESTAMP - format: YYYY-MM-DD HH:MI:SS
YEAR - format YYYY or YY
SQL Server comes with the following data types for storing a date or a date/time value in the database:

DATE - format YYYY-MM-DD
DATETIME - format: YYYY-MM-DD HH:MI:SS
SMALLDATETIME - format: YYYY-MM-DD HH:MI:SS
TIMESTAMP - format: a unique number

SELECT YEAR('2014/04/28');
Result: 2014

select extract (year  from hire_date) , count(*) from hr.employees  group by hire_date

select extract (year  from hire_date) , count(*) from hr.employees  group by hire_date
having distinct year(from hire_date)

WHERE CustomerName LIKE 'a%'	Finds any values that starts with "a"
WHERE CustomerName LIKE '%a'	Finds any values that ends with "a"
WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
WHERE CustomerName LIKE 'a_%_%'	Finds any values that starts with "a" and are at least 3 characters in length
WHERE ContactName  LIKE 'a%o'	Finds any values that starts with "a" and ends with "o"

select *from hr.employees where first_name like 'D%' or first_name like 'd%' 

select first_name,AVG(salary) from hr.employees where job_id='IT_PROG' group by first_name

select first_name ,department_id,count(*) from hr.employees 
  where department_id in (select department_id from hr.departments 
  where location_id in (select location_id from hr.locations where country_id = (select country_id from hr.countries 
  where country_name='Rome'))) group by first_name and department_id
  
select d.department_id,d.department_name,count(e.employee_id) as count
from hr.employees e inner join hr.departments d on E.DEPARTMENT_ID=D.DEPARTMENT_ID
group by D.DEPARTMENT_ID,D.DEPARTMENT_NAME

select  first_name, last_name, employee_id, job_id  
from hr.employees  where department_id = (select department_id  from hr.departments 
where location_id = (select location_id from hr.locations  where city like 'Toronto'))

select first_name ,count(*) from hr.employees 
where department_id in (select department_id from hr.departments 
where location_id in (select location_id from hr.locations where country_id = (select country_id from hr.countries 
where country_name='Roma'))) group by first_name

SELECT first_name FROM employees WHERE department_id IN 
(SELECT department_id FROM departments WHERE location_id IN 
(SELECT location_id FROM locations WHERE country_id =(SELECT country_id FROM countries 
WHERE country_name='United Kingdom')));

Remember this order:

1) SELECT (is used to select data from a database)
2) FROM (clause is used to list the tables)
3) WHERE (clause is used to filter records)
4) GROUP BY (clause can be used in a SELECT statement to collect data across multiple records and group the results by one or more columns)
5) HAVING (clause is used in combination with the GROUP BY clause to restrict the groups of returned rows to only those whose the condition is TRUE)
6) ORDER BY (keyword is used to sort the result-set)

select  employee_id,count(*) ,count(*) from hr.employees where extract(year from hire_date)=extract(year from SYSDATE) group by employee_id,hire_date

DECLARE @site_value INT;
SET @site_value = 15;

IF @site_value < 25
   PRINT 'TechOnTheNet.com';
ELSE
   PRINT 'CheckYourMath.com';
GO
  
  
select  employee_id,first_name,last_name,hire_date from hr.employees
case  when (year from hire_date)!=extract(year from SYSDATE)
      then '0'
      else 'date'
      End  
     

IF (Test condition or Expression)
BEGIN
  -- If the condition is TRUE then these statements will be executed
  True statements;
END
 
ELSE
BEGIN
   -- If the condition is FALSE then these statements will be executed
   False statements;
END


-- SQL If Else Example
 
--Declaring Number and Total Variables
DECLARE @Marks INT = 72 ;
 
IF @marks > = 50
BEGIN
   PRINT ' Congratulations ';
   PRINT ' You pass the Examination ';
END
ELSE
BEGIN
   PRINT ' You Failed ';
   PRINT ' Better Luck Next Time ';
END

DECLARE
  sales  NUMBER(8,2) := 50000;
  bonus  NUMBER(6,2);
  emp_id NUMBER(6) := 120;
BEGIN
   IF sales > 60000 THEN
      bonus := 2000;
   ELSIF sales > 35000 THEN
      bonus := 1000;
   ELSE
      bonus := 500;
   END IF;
   UPDATE employees SET salary = salary + bonus WHERE employee_id = emp_id;
END;
/