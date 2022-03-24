-- Q1. Pg-13 rated comedy movies
/*describe film;
SELECT DISTINCT name FROM category;
*/
SELECT title,rating FROM film
WHERE rating = 'PG-13' AND 
film_id IN
	(SELECT film_id FROM film_category
    WHERE category_id IN 
		(SELECT category_id FROM category
        WHERE category.name = 'Comedy'));
        
-- Q2. Top 3 rented Horror movies
/*
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film_list;
*/
SELECT fl.title
FROM film_list AS fl, inventory AS i, rental AS r
WHERE fl.category = 'Horror' 
		AND fl.FID = i.film_id
        AND i.inventory_id = r.inventory_id
GROUP BY title 
ORDER BY COUNT(ALL fl.title) DESC LIMIT 3;

-- Q3. Indians renting sports movies
/*SELECT * FROM customer_list;
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM rental;
*/
SELECT * FROM customer_list
WHERE country = 'India' AND ID IN
	(SELECT r.customer_id FROM film_list fl, inventory i, rental r
        WHERE fl.category = 'Sports' 
				AND fl.FID = i.film_id
				AND r.inventory_id = i.inventory_id
        GROUP BY r.customer_id);


-- Q4. Rented movies from Canada starring NICK WAHLBERG 
/*
SELECT DISTINCT first_name FROM actor;
SELECT * FROM customer_list;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM actor;
SELECT * FROM film_actor;
*/
SELECT * FROM customer_list 
WHERE country = 'Canada' AND ID IN
	(SELECT r.customer_id FROM rental AS r, inventory as i, film_actor AS fa, actor AS a
		WHERE a.first_name = 'NICK' AND a.last_name = 'WAHLBERG'
				AND a.actor_id = fa.actor_id
                AND fa.film_id = i.film_id
                AND i.inventory_id = r.inventory_id);


-- Q5. Movies starring SEAN WILLIAMS
/*
SELECT * FROM film_actor;
SELECT * FROM actor;
SELECT * FROM film;
*/
SELECT COUNT(f.film_id) FROM film as f, actor as a, film_actor as fa
WHERE a.first_name = 'SEAN' AND a.last_name = 'WILLIAMS'
		AND f.film_id = fa.film_id 
		AND fa.actor_id = a.actor_id;