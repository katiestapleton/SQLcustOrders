# SQLcustOrders

Customer order database: manage/analyze customer demographics, product orders, and order status.

SQL Relational database using tables, CRUD (including load + query), and primary/foreign keys.
-Database schema: QuantigrationUpdates
-Three tables created/used: Customers, Orders, RMA

Attributes:
-Customer table: customerID [PK], first name, last name, stress, city, state, zipcode, telephone
-Orders table: order ID [PK], customer ID, SKY, description
-RMA: RMAID [PK], reason, order ID, status, step
