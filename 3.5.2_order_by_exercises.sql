USE employees;
DESCRIBE employees;

-- Modify your first query to order by first name.  
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name; 

-- Update the query to order by first name and then last name. 
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name;

-- Change the order by clause so that you order by last name before first name
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name, first_name;

-- Update your queries for employees with 'E' in their last name to sort the results by their employee number
SELECT emp_no, first_name, last_name FROM employees WHERE last_name LIKE 'E%' ORDER BY emp_no;

-- Now reverse the sort order for both previous queries
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name DESC, first_name DESC;
SELECT emp_no, first_name, last_name FROM employees WHERE last_name LIKE 'E%' ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last.
SELECT first_name, last_name, hire_date, birth_date FROM employees WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND birth_date LIKE '%12-25' ORDER BY birth_date ASC, hire_date DESC;