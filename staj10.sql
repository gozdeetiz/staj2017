25.08.2017
Konu:Join(tekrar),examples(tekrar)

select JOB_ID from hr.job_history where last_day(END_DATE)-START_DATE > 100 group by JOB_ID HAVING COUNT(*)>3
--select job_id from job_history where to_char(end_date-start_date,'DD')>100 group by job_id having count(*)>3

select DEPARTMENT_ID, to_char(HIRE_DATE,'YYYY'), COUNT(EMPLOYEE_ID) from hr.employees 
group by DEPARTMENT_ID,to_char(HIRE_DATE, 'YYYY') order by DEPARTMENT_ID

select DEPARTMENT_NAME, FIRST_NAME from hr.departments D join hr.employees E on (D.MANAGER_ID=E.EMPLOYEE_ID)

from hr.countries join hr.locations using (COUNTRY_ID) join hr.departments using (LOCATION_ID)

select *  from hr.employees E1 join hr.employees E2 on (E1.MANAGER_ID=E2.EMPLOYEE_ID) 
where E1.HIRE_DATE < E2.HIRE_DATE

select FIRST_NAME, COUNTRY_NAME from hr.employees join hr.departments using(DEPARTMENT_ID) 
join hr.locations using( LOCATION_ID) join hr.countries using ( COUNTRY_ID)

select * from hr.departments where DEPARTMENT_ID in ( select DEPARTMENT_ID from EMPLOYEES 
group by DEPARTMENT_ID having max(SALARY)>10000)

select COUNTRY_NAME, CITY, COUNT(DEPARTMENT_ID)
from hr.countries join hr.locations using (COUNTRY_ID) join departments using (LOCATION_ID) where DEPARTMENT_ID in 
(select DEPARTMENT_ID from hr.employees group by DEPARTMENT_ID 
having count(DEPARTMENT_ID)>5) group by COUNTRY_NAME, CITY

declare
    cursor empc is  select employee_id, department_id, commission_pct
     from hr.employees;     
    v_hike  number(2);
begin

    for empr in empc
    loop
         if  empr.department_id = 40 then
              v_hike := 10;
         elsif empr.department_id = 70 then
              v_hike := 15;
         elsif empr.commission_pct  > 0.30 then
              v_hike := 5;
         else
              v_hike := 10;
         end if;

         update hr.employees set salary = salary + salary * v_hike/100 
         where employee_id = empr.employee_id;
         
    end loop;
end;

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

CREATE OR REPLACE Function FindCourse
   ( name_in IN varchar2 )
   RETURN number
IS
   cnumber number;
   CURSOR c1
   IS
     SELECT course_number
     FROM courses_tbl
     WHERE course_name = name_in;
BEGIN
   OPEN c1;
   FETCH c1 INTO cnumber;
   if c1%notfound then
      cnumber := 9999;
   end if;
   CLOSE c1;
RETURN cnumber;      
END;

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
/
/*outer: 2 inner: 1
  outer: 2 inner: 2
  outer: 2 inner: 3*/