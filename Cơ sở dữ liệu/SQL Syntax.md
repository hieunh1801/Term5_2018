## SELECT
```sql
SELECT column1, column2, ...
FROM table_name;

SELECT * FROM table_name;
```
## SELECT DISTINCT 
```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;

SELECT DISTINCT Country FROM Customers;

SELECT COUNT(DISTINCT Country) FROM Customers;
```
## WHERE 
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;

SELECT * FROM Customers
WHERE Country='Mexico';
```
## AND OR NOT
```sql
-- And
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;

SELECT * FROM Customers
WHERE Country='Germany' AND City='Berlin';

-- Or
SELECT column1, column2, ...
FROM table_name
WHERE condition1 OR condition2 OR condition3 ...;

SELECT * FROM Customers
WHERE City='Berlin' OR City='München';
-- Not
SELECT column1, column2, ...
FROM table_name
WHERE NOT condition;

SELECT * FROM Customers
WHERE NOT Country='Germany';
```
## Order By
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;
-- ASC: A -> Z
-- DESC: Z -> A
SELECT * FROM Customers
ORDER BY Country DESC;

-- Multi order
SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;
```
## Insert Into Table
```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');
```
## Is null && IS NOT NULL
```sql
-- IS NULL
SELECT column_names
FROM table_name
WHERE column_name IS NULL;

SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NULL;
--> Kết quả trả về: là bản ghi có trường null
-- IS NOT NULL
SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL;

SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NOT NULL;
```
## Update table
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;
```
## Delete record from table
```sql
DELETE FROM table_name WHERE condition;

DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';

-- Delete all record
DELETE FROM table_name;
``` 
## Create Table
```sql

``` 
## Drop Table
```sql
DROP TABLE table_name;
```
## Alter Table
```sql
-- ADD Column
ALTER TABLE table_name 
ADD column_name datatype;

--DROP COLUMN
ALTER TABLE table_name
DROP COLUMN column_name;

-- ALTER/MODIFY COLUMN
ALTER TABLE table_name
ALTER COLUMN column_name datatype;
```
## Select TOP
```sql
SELECT TOP 3 * FROM Customers;
WHERE Country='Germany';
--> lấy ra 3 bản ghi đầu tiên

SELECT TOP 50 PERCENT * FROM Customers;
WHERE Country='Germany';
--> Lấy ra 50% bản ghi đầu tiên
```
## MIN && MAX 
```sql
-- MIN --
SELECT MIN(column_name)
FROM table_name
WHERE condition;

SELECT MIN(Price) AS SmallestPrice
FROM Products;
-- MAX --
SELECT MAX(column_name)
FROM table_name
WHERE condition;

SELECT MAX(Price) AS LargestPrice
FROM Products;
```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```
## 
```sql

```

