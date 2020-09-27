IF new_balance < minimum_balance THEN
  overdrawn := TRUE;
ELSE
  overdrawn := FALSE;
END IF;

overdrawn := new_balance < minimum_balance;

IF overdrawn THEN
  RAISE insufficient_funds;
END IF;

DECLARE
  PROCEDURE p (
    sales  NUMBER,
    quota  NUMBER,
    emp_id NUMBER
  )
  IS
    bonus    NUMBER := 0;
    updated  VARCHAR2(3) := 'No';
  BEGIN
    IF sales > (quota + 200) THEN
      bonus := (sales - quota)/4;
 
      UPDATE employees
      SET salary = salary + bonus 
      WHERE employee_id = emp_id;
 
      updated := 'Yes';
    END IF;
 
    DBMS_OUTPUT.PUT_LINE (
      'Table updated?  ' || updated || ', ' || 
      'bonus = ' || bonus || '.'
    );
  END p;
BEGIN
  p(10100, 10000, 120);
  p(10500, 10000, 121);
END;
/*Table updated?  No, bonus = 0.
Table updated?  Yes, bonus = 125.*/

DECLARE
  PROCEDURE p (
    sales  NUMBER,
    quota  NUMBER,
    emp_id NUMBER
  )
  IS
    bonus  NUMBER := 0;
  BEGIN
    IF sales > (quota + 200) THEN
      bonus := (sales - quota)/4;
    ELSE
      IF sales > quota THEN
        bonus := 50;
      ELSE
        bonus := 0;
      END IF;
    END IF;
 
    DBMS_OUTPUT.PUT_LINE('bonus = ' || bonus);
 
    UPDATE employees
    SET salary = salary + bonus 
    WHERE employee_id = emp_id;
  END p;
BEGIN
  p(10100, 10000, 120);
  p(10500, 10000, 121);
  p(9500, 10000, 122);
END;
/

Loop statements run the same statements with a series of different values. The loop statements are:

Basic LOOP
FOR LOOP
Cursor FOR LOOP
WHILE LOOP
The statements that exit a loop are:

EXIT
EXIT WHEN
The statements that exit the current iteration of a loop are:

CONTINUE
CONTINUE WHEN

DECLARE
  x NUMBER := 0;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE ('Inside loop:  x = ' || TO_CHAR(x));
    x := x + 1;
    IF x > 3 THEN
      EXIT;
    END IF;
  END LOOP;
  -- After EXIT, control resumes here
  DBMS_OUTPUT.PUT_LINE(' After loop:  x = ' || TO_CHAR(x));
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE ('lower_bound < upper_bound');
 
  FOR i IN 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
 
  DBMS_OUTPUT.PUT_LINE ('lower_bound = upper_bound');
 
  FOR i IN 2..2 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
 
  DBMS_OUTPUT.PUT_LINE ('lower_bound > upper_bound');
 
  FOR i IN 3..1 LOOP
    DBMS_OUTPUT.PUT_LINE (i);
  END LOOP;
END;
/