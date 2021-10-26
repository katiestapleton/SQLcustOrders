--Author: Katie Stapleton
--Customer Orders DB Project
--File: RetrieveData.sql
--https://github.com/katiestapleton/SQLcustOrders/tree/development


SELECT COUNT(*) AS Returns, customers.State
FROM orders
INNER JOIN RMA
ON orders.OrderID = RMA.OrderID
INNER JOIN customers
ON orders.CustomerID = customers.CustomerID
WHERE RMA.Status = 'Complete'
GROUP BY customers.State
ORDER BY Returns desc;


SELECT COUNT(*) as Returns, SKU, Description
FROM orders
INNER JOIN RMA
ON orders.OrderID = RMA.OrderID
WHERE RMA.Status = 'Complete'
GROUP BY SKU
ORDER BY Returns;

SELECT COUNT(*) AS Returns, SKU, Description
FROM orders 
INNER JOIN RMA
ON orders.OrderID = RMA.OrderID
WHERE RMA.Status = 'Complete'
GROUP BY SKU 
ORDER BY Returns desc;

(COUNT(*)/SUM(COUNT())*100) AS PERCENT


GROUP BY 

SELECT COUNT(*) AS Returns, SKU, Description 
FROM orders 
INNER JOIN RMA
ON orders.OrderID = RMA.OrderID
WHERE RMA.Status = 'Complete'
GROUP BY SKU 
ORDER BY Returns desc; 

SELECT COUNT(*) AS Returns, SKU, Description 
FROM Orders 
INNER JOIN RMA ON Orders.OrderID = RMA.OrderID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE RMA.Status = 'Complete' AND
Customers.State IN ('Washington', 'Oregon', 'Idaho', 'Montana') 
GROUP BY SKU 
ORDER BY Returns desc; 
