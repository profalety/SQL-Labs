/* In this lab, you will be using the Sakila database of movie rentals.*/
USE sakila;

/* 1. Write a query to display for each store its store ID, city, and country.*/
SELECT store_id, city, country
FROM store
JOIN address
USING(address_id)
JOIN city
USING(city_id)
JOIN country
USING(country_id)
;

/* 2. Write a query to display how much business, in dollars, each store brought in.*/
SELECT store.store_id, SUM(amount) AS 'Revenue' 
FROM store 
JOIN staff
ON store.manager_staff_id = staff_id
JOIN payment
USING(staff_id)
GROUP BY store.store_id
;

/* 3. Which film categories are longest?*/
SELECT c.name, round(avg(length),0)  AS 'Avg. length'
FROM film f
JOIN film_category fc
USING(film_id)
JOIN category c
USING(category_id)
GROUP BY c.name
ORDER BY avg(length) DESC
;

/* 4. Display the most frequently rented movies in descending order.*/
SELECT title, COUNT(*) as 'rented # times'
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY film_id
ORDER  BY COUNT(*) DESC
;

/* 5. List the top five genres in gross revenue in descending order.*/
SELECT name, sum(amount) as 'Revenue'
FROM payment p
JOIN rental r USING(rental_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
GROUP BY category_id
ORDER BY sum(amount) DESC
LIMIT 5
;


/* 6. Is "Academy Dinosaur" available for rent from Store 1?*/
SELECT * 
FROM film f
JOIN inventory i USING(film_id)
WHERE f.title = 'Academy Dinosaur' and i.store_id = 1
;

/* 7.Get all pairs of actors that worked together.*/
SELECT a1.first_name, a1.last_name, a2.first_name, a2.last_name
FROM film_actor f1
LEFT JOIN  film_actor f2 USING(film_id) -- when I would use an inner join I wouldn't see the actors that haven't acted along anyone else, right?
JOIN actor a1 ON f1.actor_id = a1.actor_id
JOIN actor a2 ON f2.actor_id = a2.actor_id
WHERE f1.actor_id != f2.actor_id
ORDER by f1.actor_id
;

/* 8. Get all pairs of customers that have rented the same film more than 3 times.*/
/* 8 & 9 are not working */
SELECT *
FROM rental r1
JOIN rental r2 USING(inventory_id)
JOIN inventory i1 USING(inventory_id)
ORDER BY r1.customer_id -- i.film_id 
;

SELECT *, customer_id, i1.film_id, COUNT(*) OVER (partition by customer_id) as rented
FROM rental r1
JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
GROUP BY r1.customer_id 
HAVING COUNT(*) >= 3 
ORDER BY r1.customer_id -- i.film_id 
;

SELECT *, customer_id, film_id, COUNT(i1.film_id) as rented1
FROM rental r1
JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
GROUP BY i1.film_id
HAVING rented1 >=3
ORDER BY r1.customer_id -- i.film_id 
;

SELECT *, customer_id, film_id, COUNT(*) as rented
FROM rental r1
LEFT JOIN inventory i USING(inventory_id)
GROUP BY i.film_id
HAVING rented >=3
ORDER BY r1.customer_id -- i.film_id 
;


SELECT *, customer_id, film_id -- , COUNT(*) as rented
FROM rental r1
LEFT JOIN inventory i USING(inventory_id)
-- GROUP BY i.film_id
-- HAVING rented >=3
ORDER BY r1.customer_id, i -- i.film_id 

;
SELECT customer_id, film_id, COUNT(*) over (partition by customer_id) as rented
FROM rental r1
LEFT JOIN inventory i1 USING(inventory_id)
GROUP BY i1.film_id
-- HAVING COUNT(*) >=3
ORDER BY r1.customer_id -- i.film_id 
;

/* 9. For each film, list actor that has acted in more films. */
SELECT *
from film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
ORDER by title
;

SELECT title, actor_id, first_name, last_name
FROM film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
ORDER by title
;

SELECT * 
FROM film_actor 
WHERE actor_id = 162