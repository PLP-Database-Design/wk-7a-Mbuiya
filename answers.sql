✅ Question 1: Achieving 1NF
We need to break the multi-valued Products column into individual rows — each with one product per row.

sql
Copy
Edit
-- Transforming ProductDetail into 1NF by splitting Products into separate rows
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail,
    LATERAL STRING_SPLIT(Products, ',');
📝 Note: The STRING_SPLIT function is used here, which is available in SQL Server.
For PostgreSQL, use unnest(string_to_array(Products, ',')).
For MySQL 8.0+, you’d need to use a JSON or recursive workaround.

✅ Question 2: Achieving 2NF
To remove the partial dependency (CustomerName depends only on OrderID), we split into two tables:

Step 1: Create a separate Orders table with unique OrderID and CustomerName:
sql
Copy
Edit
-- Step 1: Orders table (to eliminate partial dependency)
SELECT DISTINCT
    OrderID,
    CustomerName
FROM 
    OrderDetails;
Step 2: Create a new OrderItems table that only includes OrderID, Product, and Quantity:
sql
Copy
Edit
-- Step 2: OrderItems table (fact table with no partial dependencies)
SELECT 
    OrderID,
    Product,
    Quantity
FROM 
    OrderDetails;
💡 Summary
1NF Fix: Break repeating groups (multi-valued fields) into separate rows.

2NF Fix: Remove partial dependencies by creating separate tables where each non-key column fully depends on the whole key.
