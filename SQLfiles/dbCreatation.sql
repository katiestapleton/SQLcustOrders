--Author: Katie Stapleton
--Customer Orders DB Project
--File: DBCreation.sql
--Location: https://github.com/katiestapleton/SQLcustOrders/tree/development

CREATE TABLE customers (
CustomerID INT,
FirstName varchar(25),
LastName varchar(25),
Street varchar(50),
City varchar(50),
State varchar(25),
ZipCode INT,
Telephone varchar(15),
PRIMARY KEY(CustomerID)
);

CREATE TABLE orders (
OrderID INT,
CustomerID INT,
SKU varchar(20),
Description varchar(50),
PRIMARY KEY(OrderID)
);

CREATE TABLE RMA (
RMAID INT,
OrderID INT,
Step VARCHAR(50),
Status VARCHAR (15),
Reason VARCHAR(25),
PRIMARY KEY(RMAID));

ALTER TABLE customers RENAME Collaborator;
ALTER TABLE Collaborator RENAME customers ;

LOAD DATA INFILE '/home/codio/workspace/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"' lines terminated by '\n';

LOAD DATA INFILE '/home/codio/workspace/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"' lines terminated by '\n';

LOAD DATA INFILE '/home/codio/workspace/rma.csv'
INTO TABLE RMA
FIELDS TERMINATED BY ','
ENCLOSED BY '"' lines terminated by '\n';

SELECT COUNT(*) FROM customers
INNER JOIN orders
ON customers.CustomerID = Orders.CustomerID
WHERE Customers.City = 'Brooklyn';

SELECT COUNT(*) FROM customers
INNER JOIN orders
ON customers.CustomerID = orders.CustomerID
WHERE customers.State = 'DE';

INSERT into customers
values
(1000501, 'Black', 'Widow', '6 Avengers Blvd', 'Infinity', 'Washington', 10242, '624-555-2483'),
(1000502, 'Kylo', 'Ren', '202 Sith Street', 'First Order', 'Michigan', 27901, '827-555-6527'),
(1000503, 'William', 'Riker', '1701 Enterprise Lane', 'Starship', 'Delware', 37458, '578-555-1659'),
(1000504, 'Miles', 'Morales', '58 Webster Road', 'Brooklyn', 'New York', 92501, '349-555-4837'),
(1000505, 'Anakin', 'Skywalker', '17 Lightsaber Lane', 'Tatooine City', 'Arizona', 10222, '627-555-1234'),
(1000506, 'Poison', 'Ivy', '128 Green Circle', 'Botany', 'Washington', 27401, '861-555-6623'),
(1000507, 'Hikaru', 'Sulu','2290 Excelsior Street', '1966 ', 'Starship', 'Delware', 33458, '372-555-8207'),
(1000508, 'Peter', 'Parker', '167 Webbing Avenue', 'Brooklyn', 'New York', 90501, '674-555-5678');

INSERT into orders
values
(1203001, 1000501, 'CAF-533', 'Cranberries - Dried'),
(1203002, 1000504, 'ACT-222', 'Appetizer - Calamari'),
(1203004, 1000506, 'WUR-362', 'Potatoes - Idaho'),
(1203005, 1000507, 'NES-242', 'Soup - Tomato');
(1203006, 1000507, 'GED-347', 'Cheese - Grana Padano');

SELECT COUNT(*) FROM customers
INNER JOIN orders
ON customers.CustomerID = orders.CustomerID
WHERE customers.City = 'Brooklyn';

UPDATE RMA 
SET Status = 'Complete', 
Step = 'Credit Customer Account' 
WHERE OrderID = 5175;

SELECT Status, Step 
FROM RMA
WHERE OrderID = 5175;

DELETE FROM RMA
WHERE Reason LIKE 'R%';

SELECT* FROM orders
INTO outfile'/home/codio/workspace/orders-output.csv'
FIELDS terminated by ','
ENCLOSED BY '"'
lines terminated by '/n';
