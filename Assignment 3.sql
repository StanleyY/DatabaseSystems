--------------------

-- Stanley Yang
-- Oct 1st 2013
-- Assignment 3

------------------

-- Get the cities of agents booking an order for customer c002. Use a subquery. 
SELECT DISTINCT city 
FROM agents 
WHERE aid IN (SELECT DISTINCT aid 
			  FROM orders 
			  WHERE cid = 'c002');

-- Get the cities of agents booking an order for customer c002. This time use joins; no subqueries. 
SELECT a.city 
FROM agents a, orders o 
WHERE a.aid = o.aid AND o.cid = 'c002';

-- Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use subqueries. 
SELECT DISTINCT pid
FROM orders
WHERE aid IN (SELECT aid
			  FROM orders
	          WHERE cid IN (SELECT cid
							FROM customers
							WHERE city = 'Kyoto')
			  );

-- Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use joins thus time; no subqueries. 
SELECT DISTINCT o2.pid 
FROM orders o1
INNER JOIN customers c
ON c.cid = o1.cid AND c.city = 'Kyoto'
FULL JOIN orders o2
ON o2.aid = o1.aid
WHERE o1.ordno IS NOT NULL
ORDER BY o2.pid;

-- Get the names of customers who have never placed an order. Use a subquery.
SELECT name 
FROM customers
WHERE cid NOT IN (SELECT DISTINCT cid FROM orders);

-- Get the names of customers who have never placed an order. Use an outer join.
SELECT c.name
FROM customers c
LEFT OUTER JOIN orders o
ON o.cid = c.cid
WHERE o.ordno IS NULL;

-- Get the names of customers who placed at least one order through an agent in their city, along with those agent(s) names.
SELECT DISTINCT c.name, a.name
FROM orders o, customers c, agents a
WHERE o.cid = c.cid AND o.aid = a.aid AND c.city = a.city;

-- Get the names of customers and agents in the same city, along with the name of the city, regardless of whether or not the customer has ever placed an order with that agent.
SELECT DISTINCT c.name, a.name, c.city
FROM customers c, agents a
WHERE c.city = a.city
ORDER BY c.city;

-- Get the name and city of customers who live in the city where the least number of products are made.
SELECT c.name, c.city 
FROM customers c
WHERE c.city IN (SELECT city
				FROM products 
				GROUP BY city
				ORDER BY COUNT(*) ASC
				LIMIT 1);

-- Get the name and city of customers who live in a city where the most number of products are made. 
SELECT c.name, c.city 
FROM customers c
WHERE c.city IN (SELECT city 
				FROM products 
				GROUP BY city 
				ORDER BY COUNT(*) DESC 
				LIMIT 1);

-- Get the name and city of customers who live in any city where the most number of products are made.
SELECT c.name, c.city 
FROM customers c
WHERE c.city IN (SELECT city
				 FROM products 
				 GROUP BY city
				 HAVING COUNT(*) = (SELECT COUNT(*) 
									FROM products 
									GROUP BY city 
									ORDER BY COUNT(*) DESC 
									LIMIT 1)
				);

-- List the products whose priceUSD is above the average priceUSD.
SELECT name
FROM products
WHERE priceUSD > (SELECT AVG(priceUSD)
				  FROM products);

-- Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.
SELECT c.name, o.pid, o.dollars
FROM orders o, customers c
WHERE o.cid = c.cid
ORDER BY o.dollars DESC;

-- Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs. 
SELECT c.name, COALESCE(SUM(o.qty),0) AS "Total # of Products Ordered"
FROM customers c
LEFT OUTER JOIN orders o
ON c.cid = o.cid
GROUP BY c.name, c.cid -- I added this c.cid because I wasn't sure if the two ACME were considered different customers, remove it if they aren't
ORDER BY c.name ASC;

-- Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, and the names of the agents who sold it to them.
SELECT c.name, p.name, a.name
FROM customers c, orders o, agents a, products p
WHERE o.cid = c.cid AND o.aid = a.aid AND o.pid = p.pid AND o.aid IN (SELECT aid 
																	  FROM agents 
																	  WHERE city = 'New York');

-- Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars. 
SELECT *
FROM orders o, customers c, products p
WHERE o.cid = c.cid AND o.pid = p.pid AND o.dollars != ( p.priceUSD * o.qty * ((100 - c.discount) / 100));

-- Create an error in the dollars column of the Orders table so that you can verify your accuracy checking query.
UPDATE orders
SET dollars = 500 -- Original was 450
WHERE ordno = 1011;