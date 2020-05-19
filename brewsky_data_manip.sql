SELECT beers.name as Beer, beer_types.name as Type, brewers.name as Brewer, 
AVG(beer_ratings.rating) as `Star Rating`
FROM beers
JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id
JOIN beer_types on beers.type_id = beer_types.type_id
JOIN brewers on beers.brewer_id = brewers.brewer_id
GROUP BY beers.beer_id
ORDER BY beer_ratings.rating;
 
  
SELECT order_items.order_id as `Order #`, orders.order_date as `Order placed on`,
  orders.status as Status, order_items.quantity, order_items.price, beers.name as Beer
FROM order_items
JOIN orders on order_items.order_id = orders.order_id
JOIN beers on order_items.beer_id = beers.beer_id
ORDER BY orders.order_date;
  
SELECT order_items.order_id as `Order #`,
  order_items.quantity, order_items.price, beers.name as Beer
FROM order_items
JOIN orders on order_items.order_id = orders.order_id
JOIN beers on order_items.beer_id = beers.beer_id
WHERE orders.status ='OPEN'

UPDATE order_items
SET quantity = 0
WHERE order_id = 1 AND beer_id = 1

DELETE FROM orders WHERE customer_id = 1 and status = 'OPEN'