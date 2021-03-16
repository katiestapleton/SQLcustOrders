# SQLcustOrders

Customer order database: manage/analyze customer demographics, product orders, and order status.

SQL Relational database using tables, CRUD (including load + query), and primary/foreign keys.
-Database schema: QuantigrationUpdates
-Three tables created/used: Customers, Orders, RMA

Attributes:
-Customer table: CustomerID [PK], FirstName, LastName, Street, City, State, ZipCode, Telephone
-Orders table: OrderID [PK], CustomerID, SKY, Description
-RMA: RMAID [PK], Reason, OrderID, Status, Step

CSV sheets:
