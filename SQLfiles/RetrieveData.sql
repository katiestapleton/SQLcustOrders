SELECT count(*) as RETURNS, customers.State
FROM orders
INNER JOIN RMA
on orders.OrderID = RMA.OrderID
INNER JOIN customers
ON orders.CustomerID = customers.CustomerID
WHERE RMA.Status = 'Complete'
Group by customers.State
Order by RETURNS desc;


SELECT count(*) as RETURNS, SKU, Description
FROM orders
INNER JOIN RMA
on orders.OrderID = RMA.OrderID
WHERE RMA.Status = 'Complete'
GROUP BY SKU
Order by Returns
;

Select count(*) AS Returns, SKU, Description
FROM orders 
INNER JOIN RMA
ON orders.OrderID = RMA.OrderID
Where RMA.Status = 'Complete'
Group by SKU 
Order by Returns desc ;

(COUNT(*)/SUM(COUNT())*100) AS PERCENT


GROUP BY 


Select count(*) AS Returns, SKU, Description 
FROM orders 
INNER JOIN RMA
ON orders.OrderID = RMA.OrderID
Where RMA.Status = 'Complete'
Group by SKU 
Order by Returns desc; 

Select count(*) AS Returns, SKU, Description 
FROM Orders 
INNER JOIN RMA ON Orders.OrderID = RMA.OrderID
INNER JOIN Customers on Orders.CustomerID = Customers.CustomerID
Where RMA.Status = 'Complete' AND
Customers.State in ('Washington', 'Oregon', 'Idaho', 'Montana') 
Group by SKU 
Order by Returns desc 