USE sakila;

-- 1a

SELECT first_name,last_name
FROM actor;

-- 1b
SELECT CONCAT(first_name," ",last_name) AS `Actor Name`
FROM actor;

-- 2a
SELECT actor_id,first_name,last_name
FROM actor
WHERE first_name IN( 'Joe');

-- 2b
SELECT last_name
FROM actor
WHERE last_name LIKE '%GEN%'

-- 2c
SELECT last_name,first_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name,first_name;

-- 2d
SELECT country_id ,country
FROM country
WHERE country 
IN ('Afghanistan','Bangladesh','China');

-- 3a
ALTER TABLE `actor` 
ADD COLUMN `middle_name` VARCHAR(45) NULL AFTER `first_name`;

-- 3b
ALTER TABLE `actor` 
MODIFY COLUMN middle_name BLOB;

-- 3c
ALTER TABLE `actor` 
DROP COLUMN `middle_name`;

-- 4a
SELECT last_name,COUNT(a.last_name) AS 'Count'
FROM actor a
GROUP BY a.last_name;

-- 4b
SELECT last_name, COUNT(a.last_name)AS `Count`
FROM actor a 
GROUP BY last_name
HAVING Count > 2;

-- 4c
UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

-- 4d
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';


-- 5a
DESCRIBE sakila.address;

-- 6a 
SELECT s.first_name,s.last_name,a.address 
FROM staff s
INNER JOIN address a
ON a.address_id = s.address_id;

-- 6b
SELECT s.first_name,s.last_name,SUM(p.amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id=p.staff_id
WHERE MONTH(p.payment_date)=08 AND YEAR(p.payment_date)=2005
GROUP BY s.staff_id;

-- 6c
SELECT f.title,COUNT(fa.actor_id) AS 'actors'
FROM film f
INNER JOIN film_actor fa
ON f.film_id= fa.film_id
GROUP BY f.title
ORDER BY actors DESC;

-- 6d
SELECT f.title,COUNT(i.inventory_id) AS 'inventories'
FROM film f
INNER JOIN inventory i
ON f.film_id= i.film_id
WHERE f.title='Hunchback Impossible'
GROUP BY f.title
ORDER BY inventories DESC;

-- 6e
SELECT c.first_name,c.last_name,SUM(p.amount) AS 'Total_payment'
FROM customer c
LEFT JOIN payment p
ON c.customer_id=p.customer_id
GROUP BY c.first_name,c.last_name
ORDER BY c.last_name;


-- 7a
SELECT title 
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
AND language_id IN 
(
	SELECT language_id 
	FROM language
    WHERE name='English'
);

-- 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id IN 
(SELECT actor_id FROM film_actor 
WHERE film_id IN
 (SELECT film_id FROM film WHERE title='Alone Trip'));

-- 7c
SELECT first_name, last_name, email 
FROM customer cu
JOIN address a ON (cu.address_id = a.address_id)
JOIN city cit ON (a.city_id=cit.city_id)
JOIN country cntry ON (cit.country_id=cntry.country_id)
WHERE country='Canada';

-- 7d
SELECT title
FROM film
WHERE film_id IN
( SELECT film_id FROM film_category 
WHERE category_id IN
(SELECT category_id FROM category WHERE name='Family'));

-- 7e
SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

-- 7f
SELECT s.store_id, SUM(p.amount) AS'Total Business($)'
FROM staff s
INNER JOIN payment p 
ON s.staff_id=p.staff_id
GROUP BY store_id;

-- 7g
SELECT store_id,city,country
FROM store s
JOIN address a
ON a.address_id= s. address_id
JOIN city 
ON city.city_id=a.city_id
JOIN country co
ON co.country_id=city.country_id;


-- 7h
SELECT c.name , SUM(p.amount) AS'Gross Revenue'
FROM category c
JOIN film_category fc
ON fc.category_id=c.category_id
JOIN inventory i
ON i.film_id=fc.film_id
JOIN rental r
ON r.inventory_id=i.inventory_id
JOIN payment p
ON p.rental_id= r.rental_id
GROUP BY c.name
ORDER BY 'Gross Revenue' DESC
Limit 5;



-- 8a
CREATE VIEW top_five AS
SELECT c.name , SUM(p.amount) AS'Gross Revenue'
FROM category c
JOIN film_category fc
ON fc.category_id=c.category_id
JOIN inventory i
ON i.film_id=fc.film_id
JOIN rental r
ON r.inventory_id=i.inventory_id
JOIN payment p
ON p.rental_id= r.rental_id
GROUP BY c.name
ORDER BY 'Gross Revenue' DESC
Limit 5;


-- 8b
SELECT* FROM top_five;



-- 8c
DROP VIEW top_five;
