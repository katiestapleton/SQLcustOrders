# SQLcustOrders

Customer order database: manage/analyze customer demographics, product orders, and order status.
SQL Relational database using tables, CRUD (including load + query), joins, and primary/foreign keys.

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
=======
<p>
At this time, please <b>visit the "development" branch.</b> 
</p>
<p>
The csv database consists of three documents: customer information, customer orders, and order status. The SQL is used to create specific tables, primary/foreign keys, and various CRUD operations. 
</p>
<p>
My SQL is near completion. Originally the code was written for a different database, which I not longer have assess to. However, I created my own CSV documents (including "blanks") to form another database. Due to its coding versatility, I am able to apply the previoys SQL to a different database/CSV documents. Right now I need to make some adjustments to the code to finalize the transfer. 
</p>