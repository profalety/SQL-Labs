/* Lab | SQL Subqueries 3.03 */
/* In this lab, you will be using the Sakila database of movie rentals. Create appropriate joins wherever necessary. */
USE SAKILA;

/* Instructions */
/* 1. How many copies of the film Hunchback Impossible exist in the inventory system? */
SELECT count(*) FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title='Hunchback Impossible');

/* 2. List all films whose length is longer than the average of all the films. */
SELECT * FROM film WHERE length > (SELECT avg(length) as avg_length from film);

/* 3. Use subqueries to display all actors who appear in the film Alone Trip. */
SELECT concat(first_name, ' ' , last_name) AS Name FROM film_actor 
JOIN actor USING(actor_id) 
WHERE film_id = (SELECT film_id FROM film WHERE title='Alone Trip');

/* 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films. */
SELECT title FROM film_category 
JOIN film USING(film_id)
WHERE category_id = (SELECT category_id FROM category WHERE name='Family');

/* 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
that will help you get the relevant information. */
-- subqueries
SELECT concat(first_name, ' ' , last_name) AS Name, email 
FROM customer 
WHERE address_id IN 
	(SELECT address_id FROM address 
    WHERE city_id in 
		(SELECT city_id FROM city 
		WHERE country_id IN 
			(SELECT country_id FROM country 
            WHERE country='Canada')));
-- joins
SELECT * FROM country co
JOIN city ci USING(country_id)
JOIN address a USING(city_id)
JOIN customer c USING(address_id)
WHERE country='Canada';
;

/* 6. Which are films starred by the most prolific actor? 
Most prolific actor is defined as the actor that has acted in the most number of films. 
First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred. */
DROP TABLE IF EXISTS prolific_actor;
CREATE TEMPORARY TABLE prolific_actor AS 
(SELECT actor_id, count(*) as number_of_movies 
FROM film_actor 
GROUP BY actor_id 
ORDER BY number_of_movies DESC
LIMIT 1
);

SELECT title FROM film_actor 
JOIN film USING(film_id)
WHERE actor_id = (SELECT actor_id FROM prolific_actor);

/* 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments */
DROP TABLE IF EXISTS most_profitable_customer;
CREATE TEMPORARY TABLE most_profitable_customer AS 
(SELECT customer_id, sum(amount) as sum_of_payments FROM payment
GROUP BY customer_id
ORDER BY sum_of_payments DESC
LIMIT 1
);
SELECT title FROM rental
JOIN inventory USING(inventory_id)
JOIN film USING(film_id)
WHERE customer_id = (SELECT customer_id FROM most_profitable_customer);


/* 8. Customers who spent more than the average payments. */
DROP TABLE IF EXISTS best_customers;
CREATE TEMPORARY TABLE best_customers AS 
	(
	SELECT customer_id, sum(amount) as sum_of_payments FROM payment	
	GROUP BY customer_id
    HAVING sum_of_payments > 
    (
    SELECT avg(payment_sum) as avg_sum FROM (
	SELECT customer_id, sum(amount) as payment_sum FROM payment
	GROUP BY customer_id
	) avg_table
    )
    ORDER BY sum_of_payments DESC	
    );
;

SELECT concat(first_name, ' ' , last_name) as name
FROM best_customers
JOIN customer USING(customer_id)
;
