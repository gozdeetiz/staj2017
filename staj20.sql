Tarih:19.09.2017
Konu:SQL tekrarı(devam)
select firstName from employees where departmentID In (select departmentID from departments where locationID In 
(select locationID from locations where countryID=(select countryID from countries where countryName='United Kingdom'))

select firstName,lastName from employees where managerID In (select employeeID from employees where departmentID IN
(select departmentID from departments where locationID IN (select locationID from locations where countryID='US')))

select *from departments where departmentID In (select departmentID from employees where employeeID In (select employeeID 
from jobHistory group by employeeID having count(employeeID)>1) group by departmentID having Max(salary)>7000)

select first_name ||'  ' || last_name AS Manager_name,department_id from employees 
where employee_id IN (select manager_id from employees  group by manager_id having count(*)>=4)

select *from employees m where  2 = (select count(distinct salary ) 
from employees where  salary <= m.salary);--2.lowest salary

select department_id,job_id, first_name || ' ' || last_name AS Employee_name, salary 
from employees a where salary =(select MAX(salary) from employees where department_id = a.department_id)

select employee_id,first_name ||' '|| last_name As Employee_Name,email ||'-'|| phone_number As Contact_Informstion,hire_date,job_id ||'-'||salary As Job_Information
from employees where employee_id NOT IN (select employee_id from job_history) order by employee_id

SELECT INITCAP(FIRST_NAME), INITCAP(LAST_NAME) FROM EMPLOYEES order by INITCAP(FIRST_NAME)

SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE LAST_NAME like '__%b%'

SELECT UPPER(FIRST_NAME), LOWER(EMAIL) FROM EMPLOYEES WHERE UPPER(FIRST_NAME)= UPPER(EMAIL)

SELECT DEPARTMENT_ID,job_id, AVG(SALARY) FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL GROUP BY DEPARTMENT_ID,job_id

SELECT count(employee_id),TO_CHAR(HIRE_DATE,'YYYY') FROM EMPLOYEES GROUP BY TO_CHAR(HIRE_DATE,'YYYY') 
HAVING COUNT(EMPLOYEE_ID) > 10

SELECT TO_CHAR(HIRE_DATE,'YYYY'),count(employee_id) FROM EMPLOYEES 
GROUP BY TO_CHAR(HIRE_DATE,'YYYY') order by TO_CHAR(HIRE_DATE,'YYYY')

SELECT FIRST_NAME, COUNTRY_NAME FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID) 
JOIN LOCATIONS USING( LOCATION_ID) 
JOIN COUNTRIES USING ( COUNTRY_ID)

SELECT COUNTRY_NAME, CITY, COUNT(DEPARTMENT_ID)
FROM COUNTRIES JOIN LOCATIONS USING (COUNTRY_ID) JOIN DEPARTMENTS USING (LOCATION_ID) 
WHERE DEPARTMENT_ID IN 
    (SELECT DEPARTMENT_ID FROM EMPLOYEES 
     GROUP BY DEPARTMENT_ID 
     HAVING COUNT(DEPARTMENT_ID)>5)
GROUP BY COUNTRY_NAME, CITY;

SELECT FIRST_NAME, JOB_TITLE, START_DATE, END_DATE
FROM JOB_HISTORY JH JOIN JOBS J USING (JOB_ID) JOIN EMPLOYEES E  ON ( JH.EMPLOYEE_ID = E.EMPLOYEE_ID)
WHERE COMMISSION_PCT IS NULL
  
select distinct to_char(HIRE_DATE,'YYYY'),count(*) from hr.employees group by to_char(HIRE_DATE,'YYYY') 
order by to_char(HIRE_DATE,'YYYY')
  
SELECT  employee_id,  first_name, last_name,  salary AS SalaryDrawn,  
ROUND((salary -(SELECT AVG(salary) FROM employees)),2) AS AvgCompare,  
CASE  WHEN salary >=(SELECT AVG(salary) FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END AS SalaryStatus 
FROM employees 

BEGIN
  <<outer_loop>>
  FOR i IN 1..3 LOOP
    <<inner_loop>>
    FOR i IN 1..3 LOOP
      IF outer_loop.i = 2 THEN
        DBMS_OUTPUT.PUT_LINE
          ('outer: ' || TO_CHAR(outer_loop.i) || ' inner: '
           || TO_CHAR(inner_loop.i));
      END IF;
    END LOOP inner_loop;
  END LOOP outer_loop;
END;

CREATE OR REPLACE TRIGGER t
  BEFORE
    INSERT OR
    UPDATE OF salary, department_id OR
    DELETE
  ON employees
BEGIN
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('Inserting');
    WHEN UPDATING('salary') THEN
      DBMS_OUTPUT.PUT_LINE('Updating salary');
    WHEN UPDATING('department_id') THEN
      DBMS_OUTPUT.PUT_LINE('Updating department ID');
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting');
  END CASE;
END;
/

DECLARE
  x    INTEGER := 2;
  Y    INTEGER := 5;
  high INTEGER;
BEGIN
  IF (x > y)       -- If x or y is NULL, then (x > y) is NULL
    THEN high := x;  -- run if (x > y) is TRUE
    ELSE high := y;  -- run if (x > y) is FALSE or NULL
  END IF;
  
  IF NOT (x > y)   -- If x or y is NULL, then NOT (x > y) is NULL
    THEN high := y;  -- run if NOT (x > y) is TRUE
    ELSE high := x;  -- run if NOT (x > y) is FALSE or NULL
  END IF;
END;
/

DECLARE
  null_string  VARCHAR2(80) := TO_CHAR('');
  address      VARCHAR2(80);
  zip_code     VARCHAR2(80) := SUBSTR(address, 25, 0);
  name         VARCHAR2(80);
  valid        BOOLEAN      := (name != '');
BEGIN
  NULL;
END;
/

  
  
  