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

I am going to try out Google Gemini as I am unaware of its capability. I fed it the CAP script and the questions.

1. List the order number and total dollars of all orders.
```sql
-- Me
SELECT ordernum, totalusd FROM Orders;
-- AI
SELECT orderNum, totalUSD FROM Orders;
```
Grade: 10/10, not much to say about this query. <br>
2. List the last name and home city of people whose prefix is “Ms.”.
```sql
-- Me
SELECT lastname, homecity FROM People WHERE prefix = 'Ms.';
-- AI
SELECT lastName, homeCity FROM People WHERE prefix = 'Ms.';
```
Grade: 10/10.... I promise I did this one myself lol <br>
3. List the id, name, and quantity on hand of products with quantity more than 1007.
```sql
-- Me
SELECT prodid, name, qtyonhand from Products WHERE qtyonhand > 1007;
-- AI
SELECT prodId, name, qtyOnHand FROM Products WHERE qtyOnHand > 1007;
```
Grade 10/10... the same again... but how else would you do it? <br>
4. List the first name and home city of people born in the 1940s.
```sql
-- Me (Between is inclusive)
SELECT firstname, homecity FROM People WHERE dob BETWEEN DATE '1940-01-01' AND DATE '1949-12-31';
-- AI
SELECT firstName, homeCity FROM People WHERE EXTRACT(DECADE FROM DOB) = 194;
```
Grade: 10/10 - Ummmm that worked?? <br>
5. List the prefix and last name of people who are not “Mr.”.
```sql
-- Me
SELECT prefix, lastname FROM People WHERE prefix != 'Mr.';
-- AI
SELECT prefix, lastName FROM People WHERE prefix != 'Mr.';
```
Grade: 10/10 <br>
6. List all fields for products in neither Dallas nor Duluth that cost US$17 or less.
```sql
-- Me
SELECT * FROM Products WHERE city NOT IN ('Dallas', 'Duluth') AND priceusd <= 17;
-- AI
SELECT * FROM Products WHERE city NOT IN ('Dallas', 'Duluth') AND priceUSD <= 17;
```
Grade: 10/10 <br>
7. List all fields for orders in January of any year.
```sql
-- Me
SELECT * FROM Orders WHERE EXTRACT(MONTH FROM dateordered) = 1;
-- AI
SELECT * FROM Orders WHERE EXTRACT(MONTH FROM dateOrdered) = 1;
```
Grade: 10/10 this is getting spooky <br>
8. List all fields for orders in February of any year of US$23,000 or more.
```sql
-- Me
SELECT * FROM Orders WHERE EXTRACT(MONTH FROM dateordered) = 2 AND totalusd >= 23000;
-- AI
SELECT * FROM Orders WHERE EXTRACT(MONTH FROM dateOrdered) = 2 AND totalUSD >= 23000;
```
Grade: 10/10!! <br>
9. List all orders from the customer whose id is 010.
```sql
-- Me
SELECT * FROM Orders WHERE custid = 10;
-- AI
SELECT * FROM Orders WHERE custId = 010;
```
Grade: 10/10 Leading 0s <br>
10. List all orders from the customer whose id is 005.
```sql
-- Me
SELECT * FROM Orders WHERE custid = 5;
-- AI
SELECT * FROM Orders WHERE custId = 005;
```
Grade: 10/10 Leading 0s <br>

Yeah Gemini did this easily... but it is designed to be easy.