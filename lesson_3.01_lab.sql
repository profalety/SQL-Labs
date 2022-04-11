/* In this lab, you will be using the Sakila database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official installation link. */
USE sakila;

/* Activity 1 */
/* 1. Drop column picture from staff.*/
ALTER TABLE staff DROP COLUMN picture;

/* 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.*/
SELECT * FROM customer 
WHERE first_name = "Tammy";
SELECT * FROM staff;
INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES ('TAMMY', 'SANDERS', '79', 'TAMMY.SANDERS@sakilacustomer.org',2, '1', 'Tammy', '', CURRENT_TIMESTAMP());

/* 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. 
Hint: Check the columns in the table rental and see what information you would need to add there. 
You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
Use similar method to get inventory_id, film_id, and staff_id.*/
-- Get all necessary information
SELECT * FROM rental;
SELECT * FROM film WHERE title = 'Academy Dinosaur';
SELECT * FROM inventory WHERE film_id = 1 AND store_id=1; -- inventory_id: 1-4
SELECT * FROM customer WHERE last_name = 'Hunter'; -- customer_id 130
SELECT * FROM store; -- staff_id 1
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update)
VALUES (CURRENT_TIMESTAMP(), 1, 130, 1, CURRENT_TIMESTAMP());


/* Activity 2*/
/* 1. Use dbdiagram.io or draw.io to propose a new structure for the Sakila database.*/
/* 2. Define primary keys and foreign keys for the new database. */
-- 3.01 Graph PDF @ https://github.com/profalety/SQL-Labs/blob/main/lesson_3.01_lab_graph.pdf
-- 3.01 Graph Source Code for dbdiagram.io @ https://github.com/profalety/SQL-Labs/blob/main/lesson_3.01_lab_graph_sourcecode.txt


