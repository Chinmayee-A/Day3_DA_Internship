USE sakila;
SHOW tables;
SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

SELECT * FROM payment
WHERE amount> 3.00
ORDER BY amount DESC;

-- GroupBY vs Join: Join joins 2 tables (literally) and GroupBY summarizes a table. But how? Through **Shared Values** between tables.

SELECT * FROM inventory;
DESCRIBE inventory;
SELECT store_id, 
COUNT(film_id) AS film_count
FROM inventory
GROUP BY store_id;

-- !JOINS ARE EASY!
-- INNER JOIN = Shows whats common in  both the tables (we can select the columns!)
-- LEFT JOIN = Shows entire left table (when wriiten in code) but shows only common ones from right table
-- RIGHT JOIN = Shows entire right table (when wriiten in code) but shows only common ones from left table
-- Something i learned today- Null values in Joins: in INNER JOIN, null values are not shown. in LEFT JOIN and RIGHT JOIN null values are shown


SELECT * FROM actor; -- ACTOR ID
SELECT * FROM film_actor; -- ACTOR ID, FILM ID
SELECT * FROM film; -- FILM ID

SELECT *
FROM actor INNER JOIN film_actor 
ON actor.actor_id = film_actor.actor_id;

SELECT *
FROM film_actor LEFT JOIN film
ON film_actor.film_id = film.film_id;

SELECT *
FROM film RIGHT JOIN film_actor
ON film_actor.film_id = film.film_id;
 select * from film;
 select * from language;
SELECT film_id, title, language_id, rental_rate FROM film;
SELECT f.film_id, f.title, f.language_id, f.rental_rate, l.name
FROM film AS f JOIN language AS l
ON f.language_id = l.language_id;

-- SUBQUERY: A query within another query
-- Query(SubQuery)

SELECT AVG(amount) FROM payment;
SELECT payment_id, rental_id, amount,
(SELECT AVG(amount) FROM payment) AS avg_amt
FROM payment;

SELECT payment_id, rental_id, amount,
(SELECT AVG(amount) FROM payment) AS avg_amt
FROM payment
WHERE amount >= (SELECT AVG(amount) FROM payment); 

-- THE ABOVE QUERY IS CALLED AS NESTED SUB-QUERY (something i learned today-24042025)

SELECT amount, COUNT(*) AS amt_count
FROM payment
GROUP BY amount
HAVING COUNT(*)>3.00;

CREATE INDEX idx_amount
ON payment(amount);

SHOW INDEXES FROM payment;

SELECT * FROM rental;

CREATE VIEW customer_rentals AS
SELECT 
rental_id, customer_id, staff_id
FROM rental
WHERE rental.rental_date>'2005-07-01';

SELECT * FROM customer_rentals;

-- Films not rented
SELECT * FROM film;
SELECT film_id, title, release_year, language_id 
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT inventory.film_id
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
);
