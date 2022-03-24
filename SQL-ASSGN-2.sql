-- Q1. No. of documentaries with deleted scenes.

SELECT COUNT(DISTINCT title) FROM film
WHERE special_features LIKE '%Deleted Scenes%'
        AND film.film_id IN 
			(SELECT fc.film_id FROM category c, film_category fc
				WHERE c.name = 'Documentary' 
                AND c.category_id = fc.category_id);
                

--  Q2. No. of sci-fi movies rented by the store managed by Jon Stephens.

SELECT COUNT(*) FROM
    category c,
    film_category fc,
    inventory i,
    rental r,
    staff s
WHERE c.name = 'Sci-fi'
        AND c.category_id = fc.category_id
        AND fc.film_id = i.film_id
        AND i.inventory_id = r.inventory_id
        AND r.staff_id = s.staff_id
        AND s.first_name = 'Jon'
        AND s.last_name = 'Stephens';
        

-- Q3. Total sales from Animation movies.

SELECT SUM(p.amount) FROM
    film_list AS fl,
    inventory AS i,
    rental AS r,
    payment AS p
WHERE fl.category = 'Animation'
        AND fl.FID = i.film_id
        AND i.inventory_id = r.inventory_id
        AND r.rental_id = p.rental_id;


-- Q4. Top 3 rented category of movies by “PATRICIA JOHNSON”.

SELECT fl.category, COUNT(ALL fl.category) FROM film_list AS fl
WHERE fl.FID IN (SELECT i.film_id FROM
            customer_list AS cl,
            rental AS r,
            inventory AS i
        WHERE cl.name = 'PATRICIA JOHNSON'
                AND cl.ID = r.customer_id
                AND r.inventory_id = i.inventory_id
        GROUP BY i.film_id)
GROUP BY fl.category
ORDER BY COUNT(ALL fl.category) DESC , fl.category ASC
LIMIT 3;


-- Q5. No. of R rated movies rented by “SUSAN WILSON”.

SELECT COUNT(fl.title) FROM
    film_list AS fl,
    inventory AS i,
    rental AS r,
    customer_list AS cl
WHERE fl.rating = 'R' 
		AND fl.FID = i.film_id
        AND i.inventory_id = r.inventory_id
        AND r.customer_id = cl.ID
        AND cl.name = 'SUSAN WILSON';