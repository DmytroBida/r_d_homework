/*
 Завдання на SQL до лекції 03.
 */


/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/
SELECT 
	c.name AS category_name 
	, count(distinct f.film_id) AS film_cnt 
FROM film f 
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id =c.category_id
GROUP BY
	c.name  
ORDER BY film_cnt DESC



/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/
SELECT
	a.first_name || ' ' || a.last_name AS full_name
	, COUNT(r.rental_id) AS rental_cnt
FROM film f 
	LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
	LEFT JOIN actor a ON fa.actor_id = a.actor_id
	LEFT JOIN inventory i ON f.film_id = i.film_id
	LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY
	a.first_name || ' ' || a.last_name
ORDER BY  rental_cnt DESC
LIMIT 10

/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/
SELECT
	c.name AS category_name
	, SUM(p.amount) AS total_amount
FROM film f 
	LEFT JOIN inventory i ON f.film_id = i.film_id
	LEFT JOIN rental r ON i.inventory_id = r.inventory_id
	LEFT JOIN payment p ON r.rental_id = p.rental_id
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id =c.category_id
GROUP BY c.name
ORDER BY total_amount DESC
LIMIT 1
/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
SELECT
    f.title
FROM film f
WHERE not exists (
    SELECT 1
    FROM inventory i
    WHERE i.film_id = f.film_id)


/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/
SELECT
	a.first_name || ' ' || a.last_name AS full_name
	, COUNT(distinct f.film_id) AS film_cnt
FROM film f 
	LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
	LEFT JOIN actor a ON fa.actor_id = a.actor_id
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON fc.category_id =c.category_id AND c.category_id = 3
GROUP BY a.first_name || ' ' || a.last_name
ORDER BY film_cnt DESC
LIMIT 3
