/* PRACTICE OF SQL*/

/*Step 1: Create a Database named ProductDB*/
CREATE database productDB;
USE productDB;

/*STEP 2 : Create a Table
Use the ProductDB database.
Create a table named Products with the following columns:
ProductID
ProductName
Category
Price
StockQuantity
ManufactureDate
ExpiryDate
SupplierName
*/
CREATE TABLE Products
(
ProductId INT,
ProductName VARCHAR (200),
Category VARCHAR (100),
Price INT,
StockQuanity INT,
ManufactureDate DATETIME,
ExpiryDate DATETIME,
SupplierName VARCHAR (200)
);
drop table Products;

/*STEP 3:- Add a column named Description to the Products table*/
ALTER TABLE Products
ADD COLUMN Description VARCHAR(100);

/*STEP 4:- Change the data type of the Category column*/
ALTER TABLE Products
MODIFY COLUMN Category CHAR(50);

/*STEP 5:- Remove the ExpiryDate column from the Products table.*/
ALTER TABLE Products
DROP COLUMN ExpiryDate;

/*STEP 6:- Add a unique constraint to the ProductName column.*/
ALTER TABLE Products
MODIFY COLUMN ProductName VARCHAR(500)UNIQUE;

/*STEP 7:- Remove the unique constraint from the ProductName column*/
ALTER TABLE Products
MODIFY COLUMN ProductName VARCHAR(200);

/*Rename the Price column to ProductPrice.*/
ALTER TABLE Products
CHANGE COLUMN Price Productprice INT;

SELECT * FROM Products;

/*DERIVED TABLE PRACTICE*/
use employees;
select * from employee_salary;

select name,designation,gender,month,year,AVG(salary) as avg_salary
from employee_salary
group by name, gender, designation,month,year;


SELECT emp_avg_sal.Name,
       emp_avg_sal.avg_salary
FROM (SELECT Name,
			 Designation,
             Gender,
             Year,
             AVG(Salary) as avg_salary
      FROM employee_salary
	  GROUP BY Name,
			   Designation,
			   Gender,
               Year) AS emp_avg_sal;
               
               
/*COMMON TABLE EXPRESSION PRACTICE*/
/*CAN YOU FIND THE AVERGAE SALARY OF ALL EMPLOYEES USING CTE's*/
WITH avg_salary_emp_cte AS
(
SELECT Name,
	   Designation,
	   Gender,
	   Year,
	   AVG(Salary) as avg_salary
FROM employee_salary
GROUP BY Name,
		 Designation,
		 Gender,
		 Year
)
select * from avg_salary_emp_cte;

/*CAN YOU FIND THE AVERAGE SALARY OF EACH DEPARTMENT USING CTE's*/
with avg_salary_dep_cte AS
(
SELECT Designation,
	   AVG(Salary) as avg_salary
FROM employee_salary
GROUP BY Designation
)
select * from avg_salary_dep_cte;

/*NOW LET US TRY TO MERGE BOTH THE ABOVE CTE's*/
/*HERE TO MERGE BOTH TABLES WE ARE USING JOIN CONDIITON AT THE LAST STEP*/
/*HERE WE HAVE 3 STEPS
1.CTE CREATION OF EMPLOYEE SALARY
2.CTE CREATION OF DESIGNATION AVG SALARY
3.JOIN BOTH CTE's BY USING JOIN CONDITION*/
WITH avg_salary_emp_cte AS
(
SELECT Name,
	   Designation,
	   Gender,
	   Year,
	   AVG(Salary) as avg_salary
FROM employee_salary
GROUP BY Name,
		 Designation,
		 Gender,
		 Year
),
avg_salary_des_cte AS
(
SELECT Designation,
	   AVG(Salary) as avg_salary
FROM employee_salary
GROUP BY Designation
)
/*NOTE: HERE WE HAVE TWO AVG SALARIES THEREFORE WE NEED TO USE ALIAS e.avg_salary and d.avg salary TO DIFFERENTIATE ACCORDINGLY*/
SELECT e.Name,
       e.avg_salary as emp_avg_salary,
       d.avg_salary as dep_avg_salary
FROM avg_salary_emp_cte e 
JOIN avg_salary_des_cte d 
	ON e.Designation = d.Designation;

SELECT *,
SUM(salary)OVER(PARTITION BY MONTH
				ORDER BY NAME) AS total_emp_salary
from employees.employee_salary;

SELECT *,
MIN(SALARY)OVER(partition by  designation
order by month) AS min_emp_salary
from employee_salary;

select * from employee_salary
limit 5;
