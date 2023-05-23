Use sakila;

#1.

SELECT DISTINCT r.customer_id, c.first_name, c.last_name, c.email 
FROM customer AS c
JOIN rental AS r
Using (customer_id);

#2.

SELECT r.customer_id, CONCAT(c.first_name,' ', c.last_name) AS customer_name, CONCAT('$', ROUND(AVG(payment_sum),2)) AS average_payment_made
FROM rental as r
JOIN customer as c
USING (customer_id)
JOIN (SELECT customer_id, SUM(amount) AS payment_sum
FROM payment
GROUP BY customer_id) as p
USING (customer_id)
GROUP BY r.customer_id, customer_name
ORDER BY r.customer_id;

#3.

SELECT CONCAT(c.first_name,' ', c.last_name) AS customer_name, c.email as email_address
FROM customer as c
JOIN rental as r
USING (customer_id)
JOIN inventory as i
USING (inventory_id)
JOIN film as f
USING (film_id)
JOIN film_category as fc
USING (film_id)
JOIN category as cat
USING (category_id)
WHERE cat.`name` = 'Action';

SELECT CONCAT(c.first_name,' ', c.last_name) AS customer_name, c.email as email_address
FROM customer as c
WHERE customer_id IN 
(SELECT r.customer_id
FROM rental as r
WHERE r.inventory_id IN
(SELECT i.inventory_id
FROM inventory as i
WHERE i.inventory_id IN
(SELECT f.film_id
FROM film as f
WHERE f.film_id IN
(SELECT fc.film_id
FROM film_category as fc
WHERE fc.film_id IN
(SELECT cat.category_id
FROM category as cat
WHERE cat.name = 'Action')))));

#Observation: Despite the nature of the queries being consistent, they do not produce identical outputs. This is possibly due to the structure of the data and the datatype involved rather than the syntax of the queries.

#4.

SELECT DISTINCT amount
FROM payment;  # To get a feel of the unique values in the amount column

SELECT *,
CASE
WHEN payment.amount between 0 and 2 THEN 'Low'
WHEN payment.amount between 2 and 4 THEN 'Medium'
WHEN payment.amount > 4 THEN 'High'
ELSE 'Unclassified'
END AS payment_classification
FROM payment;



