select first_name,AVG(salary) from hr.employees where job_id='IT_PROG' group by first_name

select first_name,last_name from hr.employees  
where salary >( select AVG(salary) from hr.employees)--ortalama maaştan yüksek maaş alanların listesi

select employee_id, first_name , salary from hr.employees  
where salary >(select AVG (salary)  from hr.employees ) 
and  department_id in (select department_id from hr.employees );

select  employee_id,count(*) from hr.employees where to_char(HIRE_DATE,'YYYY')=to_char(SYSDATE, 'YYYY') group by employee_id

select first_name,salary,hire_date,round((sysdate-hire_date))  totaldays 
from employees where hire_date + to_dsinterval('10 10:00:00')<= date'2003-01-01';

The following PL/SQL block declares several variables and constants, then calculates a ratio using values selected from a database table:
DECLARE
   numerator   NUMBER;
   denominator NUMBER;
   the_ratio   NUMBER;
   lower_limit CONSTANT NUMBER := 0.72;
   samp_num    CONSTANT NUMBER := 132;
BEGIN
   SELECT x, y INTO numerator, denominator FROM result_table
      WHERE sample_id = samp_num;
   the_ratio := numerator/denominator;
   IF the_ratio > lower_limit THEN
      INSERT INTO ratio VALUES (samp_num, the_ratio);
   ELSE
      INSERT INTO ratio VALUES (samp_num, -1);
   END IF;
   COMMIT;
EXCEPTION
   WHEN ZERO_DIVIDE THEN
      INSERT INTO ratio VALUES (samp_num, 0);
      COMMIT;
   WHEN OTHERS THEN
      ROLLBACK;
END;

The PL/SQL block below uses %FOUND to select an action. The IF statement either inserts a row or exits the loop unconditionally. 
DECLARE
   CURSOR num1_cur IS SELECT num FROM num1_tab
      ORDER BY sequence;
   CURSOR num2_cur IS SELECT num FROM num2_tab
      ORDER BY sequence;
   num1     num1_tab.num%TYPE;
   num2     num2_tab.num%TYPE;
   pair_num NUMBER := 0;
BEGIN
   OPEN num1_cur;
   OPEN num2_cur;
   LOOP   -- loop through the two tables and get pairs of numbers
      FETCH num1_cur INTO num1;
      FETCH num2_cur INTO num2;
      IF (num1_cur%FOUND) AND (num2_cur%FOUND) THEN
         pair_num := pair_num + 1;
         INSERT INTO sum_tab VALUES (pair_num, num1 + num2);
      ELSE
         EXIT;
      END IF;
   END LOOP;
   CLOSE num1_cur;
   CLOSE num2_cur;
END;

The next example uses the same block. However, instead of using %FOUND in an IF statement, it uses %NOTFOUND in an EXIT WHEN statement.
DECLARE
   CURSOR num1_cur IS SELECT num FROM num1_tab
      ORDER BY sequence;
   CURSOR num2_cur IS SELECT num FROM num2_tab
      ORDER BY sequence;
   num1     num1_tab.num%TYPE;
   num2     num2_tab.num%TYPE;
   pair_num NUMBER := 0;
BEGIN
   OPEN num1_cur;
   OPEN num2_cur;
   LOOP   -- loop through the two tables and get
          -- pairs of numbers
      FETCH num1_cur INTO num1;
      FETCH num2_cur INTO num2;
      EXIT WHEN (num1_cur%NOTFOUND) OR (num2_cur%NOTFOUND);
      pair_num := pair_num + 1;
      INSERT INTO sum_tab VALUES (pair_num, num1 + num2);
   END LOOP;
   CLOSE num1_cur;
   CLOSE num2_cur;
END;

Declare @inserted table ([FirstName] varchar(50),[LastName] varchar(50), [ModifiedDate] datetime)

 Insert into [dbo].[Customer]([FirstName],[LastName],[ModifiedDate])
 Output inserted.FirstName, inserted.LastName, inserted.ModifiedDate
 Into @inserted
 Values('Ayse','Fatma',getdate());

 select * from @inserted
 
 Declare @deleted table ([CustomerID] int,[FirstName] varchar(50),[LastName] varchar(50), [ModifiedDate] datetime)

 delete from [dbo].[Customer]    
 Output deleted.CustomerID, deleted.FirstName, deleted.LastName, deleted.ModifiedDate
 Into @deleted
 output deleted.CustomerID, deleted.FirstName, deleted.LastName, deleted.ModifiedDate
 where CustomerID = 1

 select * from @deleted
 
You can use a trigger to print out some output from the debugging process. For example, you could code the trigger to invoke:

DBMS_OUTPUT.PUT_LINE('I got here:'||:new.col||' is the new value'); 7

Display 5th and 10th employees in Employees table.
declare
      cursor empc is
        select employee_id, first_name 
        from hr.employees;
        
begin
     for empr  in empc
     loop
         if empc%rowcount > 4 then
              dbms_output.put_line( empr.first_name);
              exit  when   empc%rowcount > 10;
         end if;
     end loop;
     
end;
Update salary of an employee based on department and commission percentage.
If department is 40 increase salary by 10%. If department is 70 then 15%, if
commission is more than .3% then 5% otherwise 10%.
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


create or replace function get_department_manager_name(deptId number)
return VARCHAR is
   v_name  hr.employees.first_name %type;
begin
   select first_name into v_name
   from hr.employees
   where  employee_id = ( select manager_id from hr.departments where department_id = deptId);
   return v_name;
end;


create or replace function get_employe_for_manager(manager number)/*sadece create kullanırsan her seferinde yeni bir fonksiyon üretmeye çalışıyo
                                                                   ve hata veriyo*/
reate or replace trigger trg_log_job_change
after update of job_id
on employees
for each row
declare
    v_enddate   date;
    v_startdate date;
begin
   -- find out whether the employee has any row in job_history table
   select max(end_date) into v_enddate
   from job_history
   where employee_id = :old.employee_id;

   if v_enddate is null then
      v_startdate := :old.hire_date;
   else
      v_startdate := v_enddate + 1;
   end if;

   insert into  job_history values (:old.employee_id, v_startdate, sysdate, :old.job_id, :old.department_id);
end;

