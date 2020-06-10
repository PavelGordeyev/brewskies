--
-- Select 5 random beers
--

SELECT beers.beer_id, beers.name, beers.abv, beer_types.name, brewers.name 
FROM beers 
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id 
INNER JOIN beer_types ON beers.type_id = beer_types.type_id 
WHERE beer_id IN (:id,:id,:id,:id,:id) AND beers.inactive = 0;


--
-- Check if an order exists
--

SELECT order_id 
FROM orders 
WHERE customer_id=:id AND status_id=1;

--
-- Add a new open order
--

INSERT INTO orders 
(customer_id, status_id) 
VALUES 
(:id, 1);

--
-- Get the current quantity for the beer chosen
--

SELECT quantity 
FROM order_items 
WHERE order_id=:id AND beer_id=:id;


--
-- Add beer to order_items table; update quantity if it is already in the order
--

INSERT INTO order_items 
(order_id, beer_id, quantity) 
VALUES 
(:id, :id, 1) ON DUPLICATE KEY UPDATE quantity=:quantity;


--
-- Search for beer, brewer or style
--

SELECT beers.beer_id,beers.name,beers.abv,beer_types.name,brewers.name,brewers.city,brewers.country,AVG(beer_ratings.rating) as Rating 
FROM beers 
INNER JOIN beer_types on beers.type_id = beer_types.type_id 
INNER JOIN brewers on beers.brewer_id = brewers.brewer_id 
LEFT JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id 
WHERE UPPER( :type ) LIKE ( :searchtext ) AND beers.inactive = 0 
GROUP BY beers.beer_id 
ORDER BY beer_ratings.rating DESC;

--
-- Add beer rating
--

INSERT INTO beer_ratings 
(beer_id, customer_id, rating) 
VALUES 
({0}, {1}, {2}) ON DUPLICATE KEY UPDATE rating={2};

--
-- Get beer information
--

SELECT beers.beer_id,beers.name,beer_types.name,brewers.name,brewers.city,brewers.country 
FROM beers 
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id 
INNER JOIN beer_types ON beers.type_id = beer_types.type_id 
WHERE beers.beer_id=:id;


--
-- Get average for beer rating
--

SELECT AVG(beer_ratings.rating) as 'Rating' 
FROM beers 
JOIN beer_ratings 
on beers.beer_id = beer_ratings.beer_id 
WHERE beers.beer_id = :id;

--
-- Delete beer from an order that is in the cart
--

DELETE FROM order_items 
WHERE order_id=:id AND beer_id=:id;

--
-- Get customer's open order items
--

SELECT beers.beer_id, order_items.order_id, beers.name, order_items.quantity, beers.price 
FROM order_items 
JOIN orders on order_items.order_id = orders.order_id 
JOIN customers on orders.customer_id = customers.customer_id 
JOIN beers on order_items.beer_id = beers.beer_id 
JOIN order_status on orders.status_id = order_status.status_id 
WHERE customers.customer_id = :id AND order_status.name IN ('OPEN');

--
-- Submit the order; updaate the status to 2, ie placed
--

UPDATE orders 
SET orders.status_id=2 
WHERE orders.status_id=1 AND orders.customer_id=:id;

--
-- Get the customer's order history
--

SELECT orders.order_date as 'Order Date', order_status.name as 'Status', SUM(order_items.quantity * beers.price) AS 'Order Total' 
FROM order_items 
JOIN orders on order_items.order_id = orders.order_id 
JOIN customers on orders.customer_id = customers.customer_id 
JOIN beers on order_items.beer_id = beers.beer_id 
JOIN order_status on orders.status_id = order_status.status_id 
WHERE customers.customer_id = %d AND order_status.name != 'OPEN' 
GROUP BY orders.order_id 
ORDER BY orders.order_date;

--
-- Get all beer ratings, in descending order
--

SELECT beers.beer_id,beers.name,beers.abv,beer_types.name,brewers.name,brewers.city,brewers.country,AVG(beer_ratings.rating) as Rating 
FROM beers 
INNER JOIN beer_types on beers.type_id = beer_types.type_id 
INNER JOIN brewers on beers.brewer_id = brewers.brewer_id 
LEFT JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id 
WHERE beers.inactive = 0 
GROUP BY beers.beer_id 
ORDER BY CASE WHEN AVG(beer_ratings.rating) IS NULL THEN 0 END, AVG(beer_ratings.rating) DESC;

--
-- Insert a new beer into the db
--

INSERT INTO beers 
(name, type_id, brewer_id, price, abv) 
VALUES 
(:name, :type_id, :brewer_id, :price, :abv);

--
-- When deleting a beer, it is set to inactive
--

UPDATE beers 
SET inactive = 1 
WHERE beer_id = :id;

--
-- When deleting a beer, it is removed from open orders only
--

DELETE FROM order_items 
WHERE (order_id, beer_id) 
IN 
(SELECT order_items.order_id, beer_id 
	FROM order_items 
	INNER JOIN orders on order_items.order_id = orders.order_id 
	WHERE status_id = 1 AND beer_id = :id);

--
-- Get the beer count for a brewer
--

SELECT brewers.name, city, country, COUNT(beer_id) 
FROM brewers 
LEFT OUTER JOIN 
(SELECT beer_id, brewer_id 
	FROM beers 
	WHERE inactive = 0) as brews 
ON brewers.brewer_id = brews.brewer_id 
WHERE brewers.brewer_id = :id 
GROUP BY brewers.name;

--
-- Get the list of beers for the brewer
--

SELECT beers.beer_id,beers.name,beers.abv,beer_types.name 
FROM beers 
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id 
INNER JOIN beer_types ON beers.type_id = beer_types.type_id 
WHERE brewers.brewer_id=%d AND beers.inactive = 0;

--
-- Get the list of beer types for drop down
--

SELECT beer_types.type_id, beer_types.name FROM beer_types;

