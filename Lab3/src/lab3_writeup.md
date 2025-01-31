# Database Lab Report 3 

**Course:** Database Management\
**Lab Number:** *Lab 3*\
**Date:** *2024-01-31*\
**Name:** *Ryan Munger*

---

## 1. Objective

*To become accustomed to writing SQL queries. To enjoy the beauty and accuracy of the
relational model. To earn some still-easy lab points.*

## 2. Lab Setup

*A fresh, unmodified CAP database and an AI of your choice.*

## 3. Procedure

*Create queries for the following yourself, validate your answer, and then write the same query using AI. Grade the AI's performance.*

1. List the order number and total dollars of all orders.
```sql
-- Me
SELECT ordernum, totalusd FROM Orders;
-- AI
SELECT * FROM table_name;
```
2. List the last name and home city of people whose prefix is “Ms.”.
```sql
-- Me
SELECT lastname, homecity FROM People WHERE prefix = 'Ms.';
-- AI
SELECT * FROM table_name;
```
3. List the id, name, and quantity on hand of products with quantity more than 1007.
```sql
-- Me
SELECT * prodid, name, qtyonhand from Products WHERE qtyonhand > 1007;
-- AI
SELECT * FROM table_name;
```
4. List the first name and home city of people born in the 1940s.
```sql
-- Me (Between is inclusive)
SELECT firstname, homecity FROM People WHERE dob BETWEEN DATE '1940-01-01' AND DATE '1949-12-31';
-- AI
SELECT * FROM table_name;
```
5. List the prefix and last name of people who are not “Mr.”.
```sql
-- Me
SELECT prefix, lastname FROM People WHERE prefix != 'Mr.';
-- AI
SELECT * FROM table_name;
```
6. List all fields for products in neither Dallas nor Duluth that cost US$17 or less.
```sql
-- Me
SELECT * FROM Products WHERE city NOT IN ('Dallas', 'Duluth') AND priceusd <= 17;
-- AI
SELECT * FROM table_name;
```
7. List all fields for orders in January of any year.
```sql
-- Me
SELECT * FROM Orders WHERE EXTRACT(MONTH FROM dateordered) = 1;
-- AI
SELECT * FROM table_name;
```
8. List all fields for orders in February of any year of US$23,000 or more.
```sql
-- Me
SELECT * FROM Orders WHERE EXTRACT(MONTH FROM dateordered) = 2 AND totalusd >= 23000;
-- AI
SELECT * FROM table_name;
```
9. List all orders from the customer whose id is 010.
```sql
-- Me
SELECT * FROM Orders WHERE custid = 10;
-- AI
SELECT * FROM table_name;
```
10. List all orders from the customer whose id is 005.
```sql
-- Me
SELECT * FROM Orders WHERE custid = 5;
-- AI
SELECT * FROM table_name;
```
