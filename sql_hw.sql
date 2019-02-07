USE sakila;

# 1
SELECT first_name, last_name FROM actor;

# 1b
SELECT UPPER(CONCAT(first_name,' ', last_name)) AS 'Actor Name' FROM actor;

# 2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'JOE';

# 2b
SELECT * FROM actor where UPPER(last_name) like '%GEN%';

# 2c
SELECT * FROM actor where UPPER(last_name) like '%LI%' ORDER BY last_name, first_name;

# 2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

# 3a
ALTER TABLE actor 
ADD description BLOB;

# 3b
 ALTER TABLE actor
 DROP COLUMN description;
 
 # 4a
 SELECT last_name, count(last_name) FROM actor GROUP BY last_name;
 
 # 4b
SELECT last_name, count(last_name) as counts FROM actor GROUP BY last_name HAVING counts > 1;

#  4c
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

# 4d
UPDATE actor SET first_name ='GROUCHO' WHERE first_name = 'HARPO';

#5
SHOW CREATE TABLE address;

# 6a
SELECT s.first_name, s.last_name, a.address FROM staff s JOIN address a ON s.address_id = a.address_id;

# 6b
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) total
	FROM staff s 
    JOIN payment p ON s.staff_id = p.staff_id 
    GROUP BY s.staff_id;

# 6c
SELECT film.title, COUNT(film.film_id) AS 'Number of Actors' 
	FROM film_actor 
    INNER JOIN film ON film_actor.film_id = film.film_id  
    GROUP BY film.film_id;

# 6d
SELECT COUNT(*) FROM inventory JOIN film ON inventory.film_id = film.film_id WHERE film.title = 'Hunchback Impossible';

# 6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS amount
	FROM payment 
    JOIN customer ON payment.customer_id = customer.customer_id 
    GROUP BY customer.customer_id
    ORDER BY customer.last_name;

# 7a
SELECT film.title 
	FROM film 
    WHERE film.title LIKE  'K%' OR 'Q%' 
    AND film.language_id IN (SELECT language_id FROM language WHERE name = 'ENGLISH');
    
# 7b
SELECT * FROM film_actor where film_id in (SELECT film_id FROM film where film.title = 'Alone Trip');

# 7c
SELECT customer.first_name, customer.last_name, customer.email
FROM customer 
	JOIN address ON customer.address_id = address.address_id
	JOIN city ON address.city_id = city.city_id 
    JOIN country ON country.country_id = city.country_id 
WHERE country.country = 'Canada';

#7d
SELECT film.* FROM film 
	JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'family';

# 7e
SELECT film.title, COUNT(film.film_id) AS 'Number of Rentals' FROM rental 
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON film.film_id = inventory.film_id
    GROUP BY film.film_id
    ORDER BY 2 DESC;

# 7f
SELECT store.store_id, SUM(payment.amount) AS 'total in $'
FROM store 
	JOIN customer ON store.store_id = customer.store_id
	JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY store.store_id;

# 7g
SELECT store.store_id, city.city, country.country FROM store 
	JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;

# 7h
SELECT category.name, SUM(payment.amount) as 'total'
FROM film JOIN film_category ON film.film_id=film_category.film_id 
JOIN category ON category.category_id = film_category.category_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY (film_category.category_id)
ORDER BY total DESC
LIMIT 5;

# 8a
CREATE VIEW top_five_genres AS (
SELECT category.name, SUM(payment.amount) as 'total'
FROM film JOIN film_category ON film.film_id=film_category.film_id 
JOIN category ON category.category_id = film_category.category_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY (film_category.category_id)
ORDER BY total DESC
LIMIT 5);

# 8b
SELECT * FROM top_five_genres;

# 8c
DROP VIEW top_five_genres;
