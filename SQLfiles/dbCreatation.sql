create table customers (
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

create table orders (
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

alter table customers RENAME Collaborator;
alter table Collaborator RENAME customers ;

LOAD DATA INFILE '/home/codio/workspace/customers.csv'
INTO TABLE customers
Fields terminated by ','
Enclosed by '"' lines terminated by '\n';

LOAD DATA INFILE '/home/codio/workspace/orders.csv'
INTO TABLE orders
Fields terminated by ','
Enclosed by '"' lines terminated by '\n';

LOAD DATA INFILE '/home/codio/workspace/rma.csv'
INTO TABLE RMA
Fields terminated by ','
Enclosed by '"' lines terminated by '\n';

select count(*) from customers
INNER JOIN orders
on customers.CustomerID = Orders.CustomerID
where Customers.City = 'Brooklyn';

select count(*) from customers
INNER JOIN orders
on customers.CustomerID = orders.CustomerID
where customers.State = 'DE';

insert into customers
values
(1000501, 'Black', 'Widow', '6 Avengers Blvd', 'Infinity', 'Washington', 10242, '624-555-2483'),
(1000502, 'Kylo', 'Ren', '202 Sith Street', 'First Order', 'Michigan', 27901, '827-555-6527'),
(1000503, 'William', 'Riker', '1701 Enterprise Lane', 'Starship', 'Delware', 37458, '578-555-1659'),
(1000504, 'Miles', 'Morales', '58 Webster Road', 'Brooklyn', 'New York', 92501, '349-555-4837'),
(1000505, 'Anakin', 'Skywalker', '17 Lightsaber Lane', 'Tatooine City', 'Arizona', 10222, '627-555-1234'),
(1000506, 'Poison', 'Ivy', '128 Green Circle', 'Botany', 'Washington', 27401, '861-555-6623'),
(1000507, 'Hikaru', 'Sulu','2290 Excelsior Street', '1966 ', 'Starship', 'Delware', 33458, '372-555-8207'),
(1000508, 'Peter', 'Parker', '167 Webbing Avenue', 'Brooklyn', 'New York', 90501, '674-555-5678');

insert into orders
values
(1203001, 1000501, 'CAF-533', 'Cranberries - Dried'),
(1203002, 1000504, 'ACT-222', 'Appetizer - Calamari'),
(1203004, 1000506, 'WUR-362', 'Potatoes - Idaho'),
(1203005, 1000507, 'NES-242', 'Soup - Tomato');
(1203006, 1000507, 'GED-347', 'Cheese - Grana Padano');

select count(*) from customers
inner join orders
ON customers.CustomerID = orders.CustomerID
where customers.City = 'Brooklyn';

update RMA 
set Status = 'Complete', 
Step = 'Credit Customer Account' 
where OrderID = 5175;

select Status, Step 
from RMA
where OrderID = 5175;

delete from RMA
where Reason LIKE 'R%';

select * from orders
INTO outfile'/home/codio/workspace/orders-output.csv'
FIELDS terminated by ','
enclosed by '"'
lines terminated by '/n';