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
where Customers.City = 'Framingham';

select count(*) from customers
INNER JOIN orders
on customers.CustomerID = orders.CustomerID
where customers.State = 'Massachusetts';

insert into customers
values
(100004, 'Luke', 'Skywalker', '17 Maiden Lane', 'New York', 'NY', 10222, '212-555-1234'),
(100005, 'Winston', 'Smith', '128 Sycamore Street', 'Greensboro', 'NC', 27401, '919-555-6623'),
(100006, 'MaryAnne', 'Jenkins', '2 Coconut Way', 'Jupiter', 'FL', 33458, '321-555-807'),
(100007, 'Janet', 'Williams', '58 Redondo Beach Blvd', 'Torence', 'CA', 90501, '310-555-5678');

insert into orders
values
(1204305, 100004, 'ADV-24-10C', 'Advanced Switch 10GigE Copper 24 port'),
(1204306, 100005, 'ADV-48-10F', 'Advanced Switch 10 GigE Copper/Fiber 44 port copper 4 port fiber'),
(1204307, 100006, 'ENT-24-10F', 'Enterprise Switch 10GigE SFP+ 24 Port'),
(1204308, 100007, 'ENT-48-10F', 'Enterprise Switch 10GigE SFP+ 48 port');

select count(*) from customers
inner join orders
ON customers.CustomerID = orders.CustomerID
where customers.City = 'Woonsocket';

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