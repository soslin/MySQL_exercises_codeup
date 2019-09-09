-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?

USE employees;

SELECT e.first_name, e.last_name, d.dept_name, s.salary
FROM salaries AS s
JOIN dept_manager AS m
	ON s.emp_no = m.emp_no
JOIN employees AS e
	ON m.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = m.dept_no
WHERE s.to_date = '9999-01-01' AND m.to_date = '9999-01-01'
ORDER BY d.dept_name;


SELECT AVG(s.salary), d.dept_name
FROM salaries AS s
JOIN dept_manager AS m
	ON s.emp_no = m.emp_no
JOIN departments AS d
	ON m.dept_no = d.dept_no
WHERE s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY d.dept_name;


USE world;

-- 2. What languages are spoken in Santa Monica?
SELECT l.language, l.percentage
	FROM countrylanguage AS l
    JOIN country AS c
		ON c.code = l.countrycode
	JOIN city AS cy
		ON cy.countrycode = l.countrycode
	WHERE cy.name = 'Santa Monica'
    ORDER BY percentage;
	 
     
   -- 3. How many different countries are in each region? 
   SELECT COUNT(*), region
   FROM country
   GROUP BY region
   ORDER BY COUNT(*);
   
   
  -- 4. What is the population for each region?  
  SELECT region, SUM(population)
  FROM country
  GROUP BY region
  ORDER BY SUM(population) DESC;


-- 5. What is the population for each continent?

SELECT continent, SUM(population)
FROM country
GROUP BY continent
ORDER BY SUM(population) DESC;
 
    
-- 6. What is the average life expectancy globally?
   SELECT AVG(lifeexpectancy)
   FROM country;
    
   -- 7. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
    
    SELECT AVG(lifeexpectancy), region
    FROM country
    GROUP BY region
    ORDER BY AVG(lifeexpectancy);
    
    SELECT AVG(lifeexpectancy), continent
    FROM country
    GROUP BY continent
    ORDER BY AVG(lifeexpectancy);
    
    -- Bonus 1Find all the countries whose local name is different from the official name
    SELECT name, localname
    FROM country
    WHERE name != localname;
    
    
   USE sakila;
   
    -- 1. Display the first and last names in all lowercase of all the actors.
    
    SELECT LOWER(first_name), LOWER(last_name)
    FROM actor;
    
    -- 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
    -- What is one query would you could use to obtain this information?
    
    SELECT actor_id, first_name, last_name
    FROM actor
    WHERE first_name = 'Joe';
    
    
    -- 3. Find all actors whose last name contain the letters "gen"
    SELECT first_name, last_name
    FROM actor
    WHERE last_name LIKE '%gen%';
    
    -- 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, 
    -- in that order.
    
    SELECT last_name, first_name
    FROM actor
    WHERE last_name LIKE '%li%'
    ORDEr BY last_name;
    
    
    -- 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
    SELECT country_id, country
    FROM country
    WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
    
    -- 6. List the last names of all the actors, as well as how many actors have that last name.
    SELECT last_name, COUNT(*)
    FROM actor
    GROUP BY last_name
    ORDER BY COUNT(*) DESC;
    
    
    -- 7. List last names of actors and the number of actors who have that last name, 
    -- but only for names that are shared by at least two actors
    SELECT last_name, COUNT(*)
    FROM actor
    GROUP BY last_name
    HAVING COUNT(last_name) > 1
    ORDER BY COUNT(*) DESC
    ;
    
    
    -- 8. You cannot locate the schema of the address table. Which query would you use to re-create it?
    
    DESCRIBE address;
    
    
    -- 9. Use JOIN to display the first and last names, as well as the address, of each staff member.
    SELECT s.first_name, s.last_name, a.address, a.address2, a.district, a.city_id, a.postal_code
    FROM staff AS s
    JOIN address AS a
		ON a.address_id = s.address_id;
    
    SELECT * FROM staff;
    
    
    -- 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.
    SELECT s.first_name, s.last_name, SUM(p.amount)
    FROM staff AS s
    JOIN payment AS p
		ON p.staff_id = s.staff_id
	WHERE p.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
    GROUP BY s.first_name, s.last_name;
    
    
    -- 11. List each film and the number of actors who are listed for that film.
    SELECT f.title, COUNT(fa.actor_id)
    FROM film AS f
    JOIN film_actor AS fa
		ON fa.film_id = f.film_id
	GROUP BY f.title
    ORDER BY COUNT(fa.actor_id) DESC;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    