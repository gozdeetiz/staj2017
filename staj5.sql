INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
INSERT INTO table_name VALUES (value1, value2, value3, ...);

SELECT job_id,job_title,min_salary,max_salary from hr.jobs where min_salary>10000

select job_title,max_salary-min_salary DIFFERENCE from hr.jobs where max_salary between 10000 and 20000

select JOB_TITLE,substr(JOB_TITLE,1, INSTR(JOB_TITLE, ' ') -1) as first_word from hr.jobs

select JOB_ID, AVG(SALARY) from hr.employees group by JOB_ID having AVG(SALARY)>10000

select DEPARTMENT_ID from hr.employees where COMMISSION_PCT IS NOT NULL group by DEPARTMENT_ID HAVING COUNT(COMMISSION_PCT)>5

Display employee ID for employees who did more than one job in the past.
select EMPLOYEE_ID from hr.job_history group by EMPLOYEE_ID HAVING COUNT(*) > 1

Display department ID, year, and Number of employees joined.
select DEPARTMENT_ID, to_char(HIRE_DATE,'YYYY'), COUNT(EMPLOYEE_ID) from hr.employees 
group by DEPARTMENT_ID,to_char(HIRE_DATE, 'YYYY') order by DEPARTMENT_ID

select distinct DEPARTMENT_ID from hr.employees group by DEPARTMENT_ID, MANAGER_ID HAVING COUNT(EMPLOYEE_ID) > 5

Display department name and number of employees in the department.
select DEPARTMENT_NAME, COUNT(*) from hr.employees NATURAL JOIN DEPARTMENTS group by DEPARTMENT_NAME

Natural Join: Guidelines
- The associated tables have one or more pairs of identically named columns.
- The columns must be the same data type.
- Don’t use ON clause in a natural join.
Syntax:
SELECT * FROM table1 NATURAL JOIN table2

select JOB_TITLE, AVG(SALARY) from hr.employees natural join hr.jobs group by JOB_TITLE