-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query

SELECT first_name, last_name, birth_date
FROM employees
WHERE hire_date = (
	SELECT hire_date
    FROM employees
	WHERE emp_no = 101010);
    

-- 2. Find all the titles held by all employees with the first name Aamod

SELECT count(title), title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod')
GROUP by title;

SELECT COUNT(*), SUM(title_count) FROM
(SELECT count(title) as title_count
FROM titles
WHERE emp_no IN (
	SELECT emp_no
    FROM employees
    WHERE first_name = 'Aamod')
GROUP by title)AS a;


-- 3. How many people in the employees table are no longer working for the company?
SELECT COUNT(emp_no)
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
    FROM dept_emp
    WHERE to_date = '9999-01-01');



-- 4. Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
    FROM dept_manager
    WHERE to_date = '9999-01-01')
    AND gender = 'F';

    
-- 5. Find all the employees that currently have a higher than average salary.
SELECT e.first_name,e.last_name,s.salary
FROM employees AS e
JOIN salaries AS s 
	ON (e.emp_no=s.emp_no)
WHERE s.salary>(
	SELECT AVG(salary)
	FROM salaries) 
AND s.to_date = '9999-01-01';

-- 6. How many current salaries are within 1 standard deviation of the highest salary? 
USE employees;
SELECT COUNT(*),
COUNT(*)/(SELECT COUNT(*) FROM salaries WHERE to_date>NOW())*100
FROM salaries
WHERE to_date>NOW() AND salary >(SELECT MAX(salary)-STDDEV(salary) FROM salaries);

