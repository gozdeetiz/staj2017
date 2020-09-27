Tarih:18.09.2017
->>Konu:SQL tekrarı
select o.orderID,o.orderDate,c.customerName from customers
where customers As c,orders As o where c.customerName='Around the horn' and c.customerID=o.customerID

select orders.orderID,orders.orderDate,customers.customerName from orders 
inner join customers On orders.customerID=customers.customerID

select orders.orderID,orders.customerName,shippers.shipperName
from((orders inner join customers on orders.customerID=customers.customerID)inner
join shippers on orders.shipperID=shippers.shipperID)

select customers.customerName,orders.orderID from customers 
left join orders on customers.customerID=orders.customerID order by customers.customerName
/*The left join keyword returns all records from the left table(customers) even if there
are no matches in the right table(orders)*/
select orders.orderID, employees.lastName, employees.firstName from orders
right join employees on orders.employeeID = employees.employeeID order by orders.orderID;
/*The right join keyword returns all records from the right table(employees) even if 
there are no matches in the left table (Orders).*/

select a.customerName As CustomerName1,b.customerName As CustomerName2,A.city
from customers a,customers b where a.customerID<>b.customerID and a.city=b.city
order by a.city

select city,country from customers where country='Germany'
union select city,country from suppliers where country='Germany' order by city;

select 'Customer' As type_,contactName,city,country from customers union
select 'Supplier',contactName,city,country from suppliers

select count(customerID),country from customers group by country
--country ye göre customerID sayısı

select shippers.shipperName,count(orders.orderID) As numberOfOrders from orders left join
shippers on orders.shipperID=shippers.shipperID group by shipperName

select count(customerID),country from customers group by country having count(customerID)>5
order by count (customerID)

select employees.lastName,count(orders.orderID) As numberOfOrders from(orders inner join
employees on orders.employeeID=employees.employeeID group by lastName having count(orders.orderID)>10

select employees.lastname,count(orders.ordersID) As numberOfOrders from orders inner join
employees on orders.employeeID=employees.employeeID where lastName='Davolio' or lastName='Fuller'
group by lastName having count(orders.orderID)>25

select supplierName from suppliers where exists(select productName from products wheres
supplierID=suppliers.supplierID and price<20)

select firstName,lastNames,salary,depatmentID from employees where salary In
(select min(salary) from employees group by depatmentID)

select employeeID,firstName,lastName from employees where
salary>(select avg(salary) from employees)

select *from employees where employee_id In(select employee_id from employees where salary=(select 
max(salary) from employees where salary<(select max(salary) from employees
--max salary'den küçük en büyük(2.en büyük) salary

select employeeID,firstName,salary from employees where salary>(select avg(salary) from employees)
and depatmentID in(select departmentID from employees where firstName like '%J')

select employeeID,firstName,lastName,jobID from employees where salary<Any(select salary from employees where 
jobID='MK_MAN') and jobID<> 'MK_MAN'

select departments.departmentID,result1.total from departments(select employees.departmentID,
sum(employees.salary) total from employees group by departmentID) result1
where result1.departmentID=departments.departmentID

***select employeeID,firstName,lastName
CASE jobID
when 'ST_MAN' THEN 'Salesman'
when 'It_prog' then 'Developer'
else jobID
end as designation,salary from employees

select employeeID,firstName,lastName,salary
case when salary>=(select avg(salary) from employees) Then 'High'
else 'Low'
end as salarystatus from employees

select employeeID,firstName,lastName,salary As SalaryDrawn,round((salary-<<(select avg(salary)
from employees)),2) As AvgCompare 
Cae when salary>=(select avg(salary) from employees ) Then 'High'
else 'Low'
end as salarystatus from employees

select firstName from employees where departmentID in (select departmentID from departments where 
locationID in(select locationID from locations where countryID=(select countryID from countries
where countryname='United Kingdom')))

select firstName ||''|| lastName as Full_Name,hiredate from employees where 
hiredate>(select hiredate from employees where employeeID=165)

SELECT *FROM departments WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM employees
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM job_history GROUP BY EMPLOYEE_ID HAVING COUNT(EMPLOYEE_ID) > 1) GROUP BY 
departmentID HAVING MAX(SALARY) > 7000)

SELECT * FROM departments WHERE department_id IN (SELECT department_id 
FROM employees GROUP BY department_id HAVING MIN(salary)>=8000)

SELECT * FROM jobs WHERE job_id IN (SELECT job_id FROM employees WHERE employee_id IN 
(SELECT employee_id FROM job_history WHERE job_id='SA_REP'))


