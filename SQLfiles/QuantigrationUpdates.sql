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
(1000501, 'Black', 'Widow', '6 Avengers Blvd', 'Infinity', 'Washington', 10242, '624-555-2483'),
(1000502, 'Kylo', 'Ren', '202 Sith Street', 'First Order', 'Michigan', 27901, '827-555-6527'),
(1000503, 'William', 'Riker', '1701 Enterprise Lane', 'Starship', 'Delware', 37458, '578-555-1659'),
(1000504, 'Miles', 'Morales', '58 Webster Road', 'Brooklyn', 'New York', 92501, '349-555-4837'),
(1000505, 'Anakin', 'Skywalker', '17 Lightsaber Lane', 'Tatooine City', 'Arizona', 10222, '627-555-1234'),
(1000506, 'Poison', 'Ivy', '128 Green Circle', 'Botany', 'Washington', 27401, '861-555-6623'),
(1000507, 'Hikaru', '2290 Excelsior Street', '1966 ', 'Starship', 'Delware', 33458, '372-555-8207'),
(1000508, 'Peter', 'Parker', '167 Webbing Avenue', 'Brooklyn', 'New York', 90501, '674-555-5678');

INSERT INTO Orders
VALUES
(1203001, 1000501, 'ADV-24-10C', 'Advanced Switch 10GigE Copper 24 port'),
(1203002, 1000504, 'ADV-48-10F', 'Advanced Switch 10 GigE Copper/Fiber 44 port copper 4 port fiber'),
(1203004, 1000506, 'ENT-24-10F', 'Enterprise Switch 10GigE SFP+ 24 Port'),
(1203005, 1000507, 'ENT-48-10F', 'Enterprise Switch 10GigE SFP+ 48 port');
(1203006, 1000507, 'ENT-48-50F', 'Enterprise Switch 50GigE SFP+ 48 port');

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

--counts orders from customers in Starship (city)
SELECT count(*) FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.City = 'Brooklyn';

--counts orders from customers in New York
SELECT count(*) FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.State = 'New York';

--counts totals of orders for each product
SELECT count(*) AS TotalOrders, SKU, Description 
FROM Orders 
GROUP BY SKU 
ORDER BY Sales desc 

--most ordered products in the Southeast sales region (Virginia, North Carolina, South Carolina, Georgia)
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

-- top 3 products returned from Northwest sales region (Washington, Oregon, Idaho, Montana)
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