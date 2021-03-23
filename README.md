# SQLcustOrders

Customer order database: manage/analyze customer demographics, product orders, and order status.
SQL Relational database using tables, CRUD (including load + query), and primary/foreign keys.

<i>Files:</i>
<ul>
  <li><i>Database schema:</i> QuantigrationUpdates</li>
  <li><i>CSV documents:</i> Customers, Orders, RMA</li>
</ul>

<i>Database Attributes:</i>
<ul>
  <li><i>Customer table</i>:  CustomerID [P], FirstName, LastName, Street, City, State, ZipCode, Telephone</li>
  <li><i>Orders table</i>:  OrderID [P], CustomerID, SKY, Description</li>
  <li><i>RMA</i>:  RMAID [P], Reason, OrderID, Status, Step</li>

CSV sheets:
