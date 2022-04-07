/* In this lab, you will be using the Sakila database of movie rentals.*/
USE sakila;

/* 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.*/
SELECT name, count(*) AS '# of films' 
FROM film_category fc
JOIN category
USING(category_id)
GROUP BY category_id
ORDER by count(*) DESC
;

/* 2. Display the total amount rung up by each staff member in August of 2005.*/
SELECT staff_id, first_name, last_name, sum(amount) 
FROM staff
JOIN payment
USING(staff_id)
GROUP BY staff_id
;

/* 3. Which actor has appeared in the most films?*/
SELECT first_name, last_name, count(*)  AS '# of films he appeared in'
FROM film_actor fa
JOIN actor a
USING(actor_id)
GROUP BY actor_id
ORDER BY count(*)  DESC
;

/* 4.Most active customer (the customer that has rented the most number of films)*/
SELECT first_name, last_name, count(*) AS '# of films rented'
FROM rental r
JOIN customer c
USING(customer_id)
GROUP BY customer_id
ORDER BY count(*) DESC
;

/* 5. Display the first and last names, as well as the address, of each staff member.*/
SELECT first_name, last_name, address
FROM staff
JOIN address
USING(address_id)
;

/* 6. List each film and the number of actors who are listed for that film.*/
SELECT title, count(*) AS '# of actors'
FROM film_actor
JOIN film
USING(film_id)
GROUP BY actor_id
;

/* 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.*/

SELECT last_name, first_name, sum(amount) as 'Total Paid'
FROM payment p 
JOIN customer c
USING(customer_id)
GROUP BY c.customer_id
ORDER BY last_name DESC
;


/* 8. List number of films per category. */
SELECT name, count(*) AS '# of films' 
FROM film_category fc
JOIN category
USING(category_id)
GROUP BY category_id
ORDER by count(*) DESC
;