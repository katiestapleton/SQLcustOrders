--DATABASE SCHEMA--
USE QuantigrationUpdates; 
--create the Quanigration Orders database
CREATE DATABASE QuantigrationOrders;

--list all databases and select the correct database to use
SHOW DATABASES;
USE QuantigrationOrders; 

--create Customers, Orders, and RMA tables
CREATE TABLE Customers (
CustomerID INT,
FirstName VARCHAR(25),
LastName VARCHAR(25),
Street VARCHAR(50),
City VARCHAR(50),
State VARCHAR(25),
ZipCode INT,
Telephone VARCHAR(15),
PRIMARY KEY(CustomerID)
);

CREATE TABLE Orders (
OrdersID INT,
CustomerID INT,
SKU VARCHAR(20),
Description VARCHAR(50),
PRIMARY KEY(OrdersID)
FOREIGN KEY(CustomerID)
	REFERENCES Customers(CustomerID)
);

CREATE TABLE RMA (
RMAID INT,
OrdersID INT,
Step VARCHAR(50),
Status VARCHAR (15),
Reason VARCHAR(25),
PRIMARY KEY(RMAID)
FOREIGN KEY(OrdersID)
    REFERENCES Orders(OrdersID)
);

--rename Customers table to Collaborator and undo your change
ALTER TABLE Customers RENAME Collaborator;
--reply: this cannnot be rolled back, so the table's name will need to be altered again
ALTER TABLE Collaborator RENAME Customers ;

--upload data files into each corresponding table
LOAD DATA INFILE '/home/codio/workspace/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED by '\n';

LOAD DATA INFILE '/home/codio/workspace/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED by '\n';

LOAD DATA INFILE '/home/codio/workspace/rma.csv'
INTO TABLE RMA
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED by '\n';

--add data to existing customers and orders tables
INSERT INTO Customers
VALUES
(100004, 'Luke', 'Skywalker', '17 Maiden Lane', 'New York', 'NY', 10222, '212-555-1234'),
(100005, 'Winston', 'Smith', '128 Sycamore Street', 'Greensboro', 'NC', 27401, '919-555-6623'),
(100006, 'MaryAnne', 'Jenkins', '2 Coconut Way', 'Jupiter', 'FL', 33458, '321-555-807'),
(100007, 'Janet', 'Williams', '58 Redondo Beach Blvd', 'Torence', 'CA', 90501, '310-555-5678');

INSERT INTO Orders
VALUES
(1204305, 100004, 'ADV-24-10C', 'Advanced Switch 10GigE Copper 24 port'),
(1204306, 100005, 'ADV-48-10F', 'Advanced Switch 10 GigE Copper/Fiber 44 port copper 4 port fiber'),
(1204307, 100006, 'ENT-24-10F', 'Enterprise Switch 10GigE SFP+ 24 Port'),
(1204308, 100007, 'ENT-48-10F', 'Enterprise Switch 10GigE SFP+ 48 port');

--update/verify RMA file with OrderID 5175
UPDATE RMA 
SET Status = 'Complete', 
Step = 'Credit Customer Account' 
WHERE OrdersID = 5175;

SELECT Status, Step 
FROM RMA
WHERE OrdersID = 5175;

--delete all rejected/returned orders from the RMA
DELETE FROM RMA
WHERE Reason LIKE 'Re%';

--counts orders from customers in Framingham (city)
SELECT count(*) FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.City = 'Framingham';

--counts orders from customers in Massachusetts
how many orders are from customer in Massachusetts?
SELECT count(*) FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.State = 'Massachusetts';

--counts totals of orders for each product
SELECT count(*) AS TotalOrders, SKU, Description 
FROM Orders 
GROUP BY SKU 
ORDER BY Sales desc 

--most ordered products in the Southeastern region
SELECT count(*) AS Sales, SKU, Description 
FROM Orders 
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.State in ('Virginia', 'North Carolina', 'South Carolina', 'Georgia')
GROUP BY SKU 
ORDER BY Sales desc 
LIMIT 3;

--top 5 products from completed orders
SELECT count(*) AS Returns, SKU, Description 
FROM Orders 
INNER JOIN RMA
ON Orders.OrderID = RMA.OrderID
WHERE RMA.Status = 'Complete'
GROUP BY SKU 
ORDER BY Returns desc 
LIMIT 5;

-- top 3 products returned from Northwest region
What are the 3 most returned products in the Northwest region?
SELECT count(*) AS Returns, SKU, Description 
FROM Orders 
INNER JOIN RMA ON Orders.OrderID = RMA.OrderID
INNER JOIN Customers on Orders.CustomerID = Customers.CustomerID
WHERE RMA.Status = 'Complete' AND Customers.State in ('Washington', 'Oregon', 'Idaho', 'Montana') 
GROUP BY SKU 
ORDER BY Returns desc 
LIMIT 3;

--output the orders table into a csv file
SELECT * FROM Orders
INTO outfile'/home/codio/workspace/Orders-output.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED by '/n';