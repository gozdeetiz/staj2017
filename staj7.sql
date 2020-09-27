DECLARE @EmplStatus int,
        @IsMarried bit,
        @WeeklyHours Decimal(6,2),
        @HourlySalary SmallMoney,
        @WeeklySalary SmallMoney;
SET @IsMarried = 1;
SET @EmplStatus = 2;
SET @WeeklyHours = 36.50;
SET @HourlySalary = 15.72;
SET @WeeklySalary = @WeeklyHours * @HourlySalary;
SELECT @EmplStatus AS [Empl Status],
       @IsMarried AS [Married?],
       @WeeklyHours AS Hours,
       @HourlySalary AS Hourly,
       @WeeklySalary AS Weekly;
GO

Declaration of date variable:
-hire_date DATE;
This variable can only have one of three values: TRUE, FALSE, NULL.
-enough_data BOOLEAN;
This number rounds to the nearest hundredth (cent).	
-total_revenue NUMBER (15,2);
This variable-length string will fit in a VARCHAR2 database column	
-long_paragraph VARCHAR2 (2000);
A constant with a very much unchanging date.
-next_tax_filing_date CONSTANT DATE := '15-APR-97';

1> DECLARE
2>  var_num1 number; 
3>  var_num2 number; 
4> BEGIN 
5>  var_num1 := 100; 
6>  var_num2 := 200; 
7>  DECLARE 
8>   var_mult number; 
9>   BEGIN 
10>    var_mult := var_num1 * var_num2; 
11>   END; 
12> END; 
13> / 
      
DECLARE 
 var_salary number(6); 
 var_emp_id number(6) = 1116; 
BEGIN
 SELECT salary 
 INTO var_salary 
 FROM employee 
 WHERE emp_id = var_emp_id; 
 dbms_output.put_line(var_salary); 
 dbms_output.put_line('The employee ' 
  	|| var_emp_id || ' has  salary  ' || var_salary); 
END; 
/

Set variable to 3.
term_limit NUMBER DEFAULT  3;

display all the information for those employees whose id is any id who earn the second highest salary.
SELECT * FROM employees WHERE employee_id IN 
(SELECT employee_id FROM employees WHERE salary =(SELECT MAX(salary) 
FROM employees WHERE salary < (SELECT MAX(salary) FROM employees)))

SELECT  employee_id,  first_name, last_name, salary,  
CASE WHEN salary >= 
(SELECT AVG(salary) 
FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END AS SalaryStatus 
FROM employees;

SELECT  employee_id,  first_name, last_name,  salary AS SalaryDrawn,  
ROUND((salary -(SELECT AVG(salary) FROM employees)),2) AS AvgCompare,  
CASE  WHEN salary >= 
(SELECT AVG(salary) 
FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END AS SalaryStatus 
FROM employees;

SELECT * FROM departments WHERE DEPARTMENT_ID IN
(SELECT DEPARTMENT_ID  FROM employees   WHERE EMPLOYEE_ID IN
(SELECT EMPLOYEE_ID  FROM job_history  GROUP BY EMPLOYEE_ID
HAVING COUNT(EMPLOYEE_ID) > 1) GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 7000)
