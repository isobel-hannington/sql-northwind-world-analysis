-- =====================================================================
-- Northwind business queries
-- Bootcamp Week 3: Day 2 Task 1 (questions 1 to 10) and Day 3 Task 2
-- (questions 1 to 8). Run in Supabase (PostgreSQL) against the Northwind
-- sample database.
--
-- These are the queries as I submitted them in my Week 3 workbook. Only
-- the layout and keyword case have been tidied for readability.
-- =====================================================================


-- ---------------------------------------------------------------------
-- Day 2 Task 1: retrieving and filtering
-- ---------------------------------------------------------------------

-- Q1. Full customer list for a report
SELECT *
FROM customers;

-- Q2. Customer names and cities for a marketing campaign
SELECT customername, city
FROM customers;

-- Q3. Every city with at least one customer, without duplicates
SELECT DISTINCT city
FROM customers;

-- Q4. Products priced over 50
SELECT *
FROM products
WHERE price > 50;

-- Q5. Customers in the USA or the UK
SELECT *
FROM customers
WHERE country = 'USA' OR country = 'UK';

-- Q6. Orders, most recent first
SELECT *
FROM orders
ORDER BY orderdate DESC;

-- Q7. Products priced 20 to 50, highest price first
SELECT *
FROM products
WHERE price BETWEEN 20 AND 50
ORDER BY price DESC;

-- Q8. US customers in Portland or Kirkland, A to Z
SELECT *
FROM customers
WHERE country = 'USA' AND city IN ('Portland', 'Kirkland')
ORDER BY customername ASC;

-- Q9. Customers in the UK or based in London, Z to A
SELECT *
FROM customers
WHERE country = 'UK' OR city = 'London'
ORDER BY customername DESC;

-- Q10. Products in category 1 or 2, A to Z
SELECT *
FROM products
WHERE categoryid IN (1, 2)
ORDER BY productname ASC;


-- ---------------------------------------------------------------------
-- Day 3 Task 2: joining tables
-- ---------------------------------------------------------------------

-- Q1. Supplier of each product
SELECT p.productname, s.suppliername
FROM suppliers AS s
JOIN products AS p
  ON s.supplierid = p.supplierid;

-- Q2. Category of each product
SELECT c.categoryname, p.productname
FROM products AS p
JOIN categories AS c
  ON p.categoryid = c.categoryid;

-- Q3. All products in the Meat/Poultry category
SELECT c.categoryname, p.productname
FROM products AS p
JOIN categories AS c
  ON p.categoryid = c.categoryid
WHERE categoryname = 'Meat/Poultry';

-- Q4. Order overview with customer and employee
SELECT o.orderid, o.orderdate, c.customername,
       e.firstname, e.lastname, e.employeeid
FROM orders AS o
JOIN customers AS c
  ON c.customerid = o.customerid
JOIN employees AS e
  ON e.employeeid = o.employeeid;

-- Q5. Product, category and supplier in one report
SELECT p.productname, c.categoryname, s.suppliername
FROM products AS p
JOIN categories AS c
  ON p.categoryid = c.categoryid
JOIN suppliers AS s
  ON s.supplierid = p.supplierid;

-- Q6. Orders placed in 1996
SELECT *
FROM orders
WHERE DATE_PART('year', orderdate) = 1996;

-- Q7. Number of products in each category
SELECT COUNT(productname) AS numberofproducts, categoryname
FROM products AS p
JOIN categories AS c
  ON p.categoryid = c.categoryid
GROUP BY categoryname;

-- Q8. Each product with its price and total quantity ordered
SELECT p.productname, p.price, SUM(od.quantity) AS total_quantity
FROM products AS p
JOIN order_details AS od
  ON p.productid = od.productid
GROUP BY p.productid, p.productname, p.price;
