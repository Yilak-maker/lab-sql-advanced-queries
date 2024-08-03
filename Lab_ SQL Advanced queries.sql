
## 1 List each pair of actors that have worked together

use sakila;
SELECT DISTINCT
    fa1.actor_id AS actor1_id,
    fa2.actor_id AS actor2_id,
    f.title AS film_title
FROM
    film_actor fa1
JOIN
    film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN
    film f ON fa1.film_id = f.film_id
WHERE
    fa1.actor_id < fa2.actor_id
ORDER BY
    fa1.actor_id,
    fa2.actor_id,
    f.title;
    
## 2 For each film, list actor that has acted in more films.

 WITH afc AS (
    SELECT actor_id, COUNT(film_id) AS film_count
    FROM film_actor
    GROUP BY actor_id
), 
maf AS (
    SELECT film_id, MAX(film_count) AS max_film_count
    FROM film_actor fa
    JOIN afc ON fa.actor_id = afc.actor_id
    GROUP BY film_id
)
SELECT f.film_id, f.title AS film_title, fa.actor_id, a.first_name || ' ' || a.last_name AS actor_name, afc.film_count
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN afc ON fa.actor_id = afc.actor_id
JOIN maf ON f.film_id = maf.film_id AND afc.film_count = maf.max_film_count
JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.film_id, afc.film_count DESC;

