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

-- Get the names of customers who placed at least one order through an agent in their city, along with those agent(s) names.

-- Get the names of customers and agents in the same city, along with the name of the city, regardless of whether or not the customer has ever placed an order with that agent.

-- Get the name and city of customers who live in the city where the least number of products are made.

-- Get the name and city of customers who live in a city where the most number of products are made. 

-- Get the name and city of customers who live in any city where the most number of products are made.

-- List the products whose priceUSD is above the average priceUSD.

-- Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.

-- Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs. 

-- Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, and the names of the agents who sold it to them.

-- Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars. 

-- Create an error in the dollars column of the Orders table so that you can verify your accuracy checking query.