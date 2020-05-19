--
-- Get the average star rating for a beer
--

SELECT beers.name as Beer, beer_types.name as Type, brewers.name as Brewer, 
AVG(beer_ratings.rating) as `Star Rating`
FROM beers
JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id
JOIN beer_types on beers.type_id = beer_types.type_id
JOIN brewers on beers.brewer_id = brewers.brewer_id
GROUP BY beers.beer_id
ORDER BY beer_ratings.rating;

--
-- List the customer's orders sorted by the most recent one
--
  
SELECT order_items.order_id as `Order #`, orders.order_date as `Order placed on`,
  orders.status_id as Status, order_items.quantity, order_items.price, beers.name as Beer
FROM order_items
JOIN orders on order_items.order_id = orders.order_id
JOIN beers on order_items.beer_id = beers.beer_id
ORDER BY orders.order_date DESC;

--
-- Get the beer order details for the customer's open order
--
  
SELECT order_items.order_id as `Order #`,
  order_items.quantity, order_items.price, beers.name as Beer
FROM order_items
JOIN orders on order_items.order_id = orders.order_id
JOIN beers on order_items.beer_id = beers.beer_id
JOIN order_status on orders.status_id = order_status.status_id
WHERE order_status.name IN ('OPEN');

--
-- Update quantity for order_items
--

UPDATE order_items
SET quantity = 0
WHERE order_id = 1 AND beer_id = 1;

--
-- Delete open order
--

DELETE FROM orders WHERE customer_id = 1 and status = 'OPEN';


--
-- Search for beer name
--

SELECT beers.name,
brewers.name,
beer_types.name,
brewers.city,
brewers.country
FROM beers
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id
INNER JOIN beer_types ON beers.type_id = beer_types.type_id
WHERE beers.name LIKE ('%Lush%');



--
-- Search for brewery
--

SELECT beers.name,
brewers.name,
beer_types.name,
brewers.city,
brewers.country
FROM beers
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id
INNER JOIN beer_types ON beers.type_id = beer_types.type_id
WHERE brewers.name LIKE ('%Desch%');


--
-- Search for beer type
--

SELECT beers.name,
brewers.name,
beer_types.name,
brewers.city,
brewers.country
FROM beers
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id
INNER JOIN beer_types ON beers.type_id = beer_types.type_id
WHERE beer_types.name LIKE ('%Strong%');


--
-- Search for beers made by a brewery using the brewer's id
--

SELECT beers.name,
brewers.name,
beer_types.name,
brewers.city,
brewers.country
FROM beers
INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id
INNER JOIN beer_types ON beers.type_id = beer_types.type_id
WHERE brewers.brewer_id = 49;

--
-- Update brewer's information
--

UPDATE brewers
SET city = 'Los Angeles', state = 'California', country = 'United States'
WHERE brewer_id = 57;

--
-- Delete a beer from the beer table
--

DELETE FROM beers
WHERE beer_id = 2;
