--1- every customer (E-Shop) 
--wants to know who the top 3 customers buy from them
SELECT c.Name as TOP_3_CUSTOMERS
FROM Orders AS o
JOIN Customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY COUNT(o.OrderID) DESC
LIMIT 3;

--2- show me the customers 
-- who bought more than 100$ 
-- on the last day 
SELECT c.Name, o.Total_Amount, o.Order_Date
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.Total_Amount > 100 AND o.Order_Date = CURRENT_DATE - INTERVAL '1 day';

--3- show me all reviewed products 
-- with the average rating 
-- (product_x => 3.5 rating)
SELECT 
	p."Name", 
	ROUND(AVG(r.Rating),2) AS Average_Rating
FROM Products p
JOIN Reviews r 
ON p.ProductID = r.ProductID
GROUP BY p."Name"
HAVING ROUND(AVG(r.Rating), 2) >= 3.5;

----------------------------------------------------------------EXTRA

--Customers who have never placed an order
SELECT DISTINCT c.Name
FROM Customers AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- Retrieve all customers (names) with their: 
-- Total number of orders , 
-- Total number of different products purchased 
-- The date that they ordered the last wishlist.
SELECT 
	c.Name , 
	COUNT(o.OrderID) AS Total_Orders,
	COUNT(DISTINCT oi.ProductID) AS Different_Products,
	  CASE
        WHEN MAX(o.Order_Date) IS NULL THEN 'No order has been made yet'
        ELSE TO_CHAR(MAX(o.Order_Date), 'YYYY-MM-DD')
    END AS Last_Order_Date
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.CustomerID = o.CustomerID
LEFT JOIN Order_Items AS oi
ON o.OrderID = oi.OrderID
GROUP BY c.Name;

-- Find the top 5 customers who have spent the most total amount on their orders:
SELECT c.Name, SUM(o.Total_Amount)
FROM Orders AS o
JOIN Customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.Name
ORDER BY SUM(o.Total_Amount) DESC
LIMIT 5;

--Find the product that have received the highest average rating from customers:
SELECT p."Name" , AVG(r.Rating)
FROM Reviews AS r
JOIN Products AS p
ON r.ProductID = p.ProductID
GROUP BY p."Name"
ORDER BY AVG(r.Rating) DESC
LIMIT 1;

-- Find top 5 customers who have 
-- purchased the highest quantity of products across all their orders. 
-- Display their names and the total quantity of products purchased.
SELECT c.Name , SUM(oi.Quantity) AS Total_Quantity_Of_Products
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID
JOIN Order_Items as oi
ON o.OrderID = oi.OrderID
GROUP BY c.Name
ORDER BY SUM(oi.Quantity) DESC
LIMIT 5;

--Products with their suppliers 
SELECT p."Name" AS Product_Name, s.Supplier_Name
FROM Products AS p
JOIN Product_Suppliers AS ps
ON p.ProductID = ps.ProductID
JOIN Suppliers AS s
ON ps.SupplierID = s.SupplierID;

-- Return the name of the product that has been most ordered in the E-Commerce Website
-- along with the number of
--purchases of this product.
SELECT p."Name" , COUNT(*) AS Total_Number_Purchased
FROM Orders AS o
JOIN Order_Items AS oi
ON o.OrderID = oi.OrderID
JOIN Products AS p
ON oi.ProductID = p.ProductID
GROUP BY p."Name" 
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Find the category that has more products purchased in the website
SELECT c."Name" AS Category_Name, COUNT(*) AS Total_Products_Purchased
FROM Categories AS c
JOIN Product_Categories AS pc 
ON c.CategoryID = pc.CategoryID
JOIN Order_Items AS oi
ON pc.ProductID = oi.ProductID
GROUP BY c."Name"
ORDER BY COUNT(*) DESC
LIMIT 1;
