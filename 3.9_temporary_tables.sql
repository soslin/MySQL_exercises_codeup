USE bayes_829;

-- 1. create the employees_with_departments table

/* CREATE TEMPORARY TABLE employees_with_departments
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100; */


--  a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first 
-- name and last name columns 

DESCRIBE employees_with_departments;

/* a.  Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and 
last name columns */
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- b. Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
DESCRIBE employees_with_departments;

/* 2 Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the 
number of cents of the payment. */
USE bayes_829;

CREATE TEMPORARY TABLE payment_temp AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment;
DESCRIBE payment_temp;

ALTER TABLE payment_temp ADD cent_amount INT UNSIGNED;

UpDATE payment_temp
SET cent_amount = payment_temp.amount *100;
DESCRIBE payment_temp;