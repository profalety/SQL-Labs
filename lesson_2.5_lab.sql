USE sakila;

/* 1. Select all the actors with the first name ‘Scarlett’. */
SELECT * 
FROM actor
WHERE first_name = 'Scarlett';

/* 2. How many films (movies) are available for rent and how many films have been rented? */
SELECT COUNT(DISTINCT title) as '# of Movies', COUNT(rental_duration) as 'Total Rents'
FROM film;

/* 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration. */
SELECT MIN(length) as min_duration, MAX(length) as max_duration
FROM film;

/*
SELECT title, length
FROM film
WHERE 
	length = (SELECT MAX(length) FROM film) OR
    length = (SELECT MIN(length) FROM film);
*/

/* 4. What's the average movie duration expressed in format (hours, minutes)?*/ 
SELECT  round((AVG(length) / 60), 0) as avg_hours, round((AVG(length) MOD 60), 0) as avg_min
FROM film;

/* 5. How many distinct (different) actors' last names are there? */
SELECT COUNT(DISTINCT(last_name)) FROM actor;

/* 6. Since how many days has the company been operating (check DATEDIFF() function)? */
/* ERROR */
/* SELECT DATEDIFF(SECOND, CONVERT(MIN(create_date), DATETIME), CONVERT(MAX(create_date), DATETIME)) FROM customer; */
SELECT DATEDIFF(CONVERT(MIN(rental_date), DATETIME), CONVERT(MAX(rental_date), DATETIME)) FROM rental;

/* 7. Show rental info with additional columns month and weekday. Get 20 results. */

SELECT 
	*, 
    monthname(rental_date) AS 'month', 
	weekday(rental_date) AS 'Weekday' 
FROM rental
LIMIT 20;

/* 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week. */
SELECT 
	*, 
    monthname(rental_date) AS 'month', 
	weekday(rental_date) AS 'weekday',
    CASE
	WHEN weekday(rental_date) <=5 then 'Workday'
	ELSE 'Weekend'
    END AS 'day_type'
FROM rental
LIMIT 20;

/* 9. Get release years. */
SELECT DISTINCT release_year FROM film;

/* 10. Get all films with ARMAGEDDON in the title. */
SELECT * FROM film
WHERE title LIKE  '%ARMAGEDDON%'
;

/* 11. Get all films which title ends with APOLLO. */
SELECT * FROM film
WHERE title LIKE  'APOLLO%'
;

/* 12. Get 10 the longest films. */
SELECT * FROM film
ORDER BY length DESC
LIMIT 10
;

/* 13. How many films include Behind the Scenes content?*/
/* ERROR */
SELECT * FROM film
WHERE special_features LIKE ('%Behind the Scenes%')
;

SELECT * FROM film