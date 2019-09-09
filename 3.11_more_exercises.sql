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
    
    -- Bonus 1. Find all the countries whose local name is different from the official name
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
    
    
    -- 12. How many copies of the film Hunchback Impossible exist in the inventory system?
    SELECT f.title, count(i.film_id)
    FROM film AS f
    JOIN inventory AS i
		ON f.film_id = i.film_id
	WHERE f.title = 'Hunchback Impossible'
    GROUP BY f.title;
    
    
  -- 13. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
    SELECT title
    FROM film
    WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id = (
		SELECT language_id
        FROM language
        WHERE name = 'English');
	
        
   -- 14. Use subqueries to display all actors who appear in the film Alone Trip
    SELECT first_name, last_name
    FROM actor
    WHERE actor_id IN (
		SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
			SELECT film_id
            FROM film
            WHERE title = 'Alone Trip'));
            
    -- 15. You need the names and email addresses of all Canadian customers.
   SELECT c.first_name, c.last_name, a.address, a.address2, city.city, a.district, a.postal_code, c.email
	FROM customer AS c
	JOIN address AS a
		ON a.address_id = c.address_id
	JOIN city
		ON city.city_id = a.city_id
	JOIN country AS cy
		ON cy.country_id = city.country_id
	WHERE cy.country = 'Canada';
    
    
    -- 16. Identify all movies categorized as family films.
    SELECT * FROM category;
    SELECT f.title, c.name
    FROM film AS f
    JOIN film_category AS fc
		ON fc.film_id = f.film_id
	JOIN category AS c
		ON c.category_id = fc.category_id
	WHERE name = 'Family';
    

    -- 17. Write a query to display how much business, in dollars, each store brought in
    SELECT * FROM store;
    
    SELECT s.store_id, SUM(amount)
    FROM store AS s
    JOIN staff AS stf
		ON s.store_id = stf.store_id
	JOIN payment as p
		ON p.staff_id = stf.staff_id
	GROUP BY s.store_id;
    
    -- 18. Write a query to display for each store its store ID, city, and country.
    SELECT s.store_id, city.city, c.country
    FROM store as s
    JOIN address as a
		ON s.address_id = a.address_id
	JOIN city
		ON city.city_id = a.city_id
	JOIN country AS c
		ON c.country_id = city.country_id;
    
 -- 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: 
 -- category, film_category, inventory, payment, and rental.)   
    
    SELECT c.name, sum(p.amount)
    FROM category AS c
    JOIN film_category AS fc
		ON c.category_id = fc.category_id
	JOIN inventory as i
		ON i.film_id = fc.film_id
	JOIN rental as r
		ON r.inventory_id = i.inventory_id
	JOIN payment AS p
		ON p.rental_id = r.rental_id
	GROUP BY c.name
    ORDER BY sum(p.amount) DESC
    LIMIT 5 ;
    
    
    -- SELECT statements
-- Select all columns from the actor table.
-- Select only the last_name column from the actor table.
-- Select only the following columns from the film table. ???
    
    SELECT * FROM actor;
    SELECT last_name FROM actor;
    
    
    -- DISTINCT operator
-- Select all distinct (different) last names from the actor table.
-- Select all distinct (different) postal codes from the address table.
-- Select all distinct (different) ratings from the film table.
    
    SELECT DISTINCT last_name FROM actor;
    SELECT DISTINCT postal_code FROM address;
    SELECT DISTINCT rating FROM film;
    
    
    -- HERE clause
-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
-- Select all columns minus the password column from the staff table for rows that contain a password.
-- Select all columns minus the password column from the staff table for rows that do not contain a password.
    
    SELECT title, description, rating, length 
    FROM film
    WHERE length > 179;
    
    
    SELECT payment_id, amount, payment_date
    FROM payment
    WHERE payment_date > '2005-05-27';
    
    
    SELECT payment_id, amount, payment_date
    FROM payment
    WHERE DATE(payment_date) = '2005-05-27'; 
    
    
    SELECT * FROM customer
    WHERE last_name LIKE 's%' AND first_name LIKe '%n';
    
    
    SELECT * FROM customer
    WHERE active = 0 or last_name = 'M%';
    
SELECT * FROM category 
WHERE category_id > 4 AND (name LIKE 'c%' OR name LIKE 's%' OR name LIKE 't%');
    
    SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
    FROM staff
    WHERE password IS NOT NULL;
    
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update
    FROM staff
    WHERE password IS NULL;

-- IN operator
-- Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
-- Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, 
-- 		and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
-- Select all columns from the film table for films rated G, PG-13 or NC-17.
    
    SELECT phone, district
    FROM address
	WHERE district IN ('California', 'England', 'Taipei', 'West Java');
    
    
    SELECT payment_id, amount, payment_date
    FROM payment
    WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');
    
SELECT * FROM film
WHERE rating IN ('G', 'PG-13', 'NC-17');
    
--    BETWEEN operator
-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
-- Select the following columns from the film table for films where the length of the description is between 100 and 120.
-- Hint: total_rental_cost = rental_duration * rental_rate 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    