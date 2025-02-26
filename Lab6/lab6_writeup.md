# Database Lab Report 6

**Course:** Database Management\
**Lab Number:** *Lab #6*\
**Date:** *2025-02-25*\
**Name:** *Ryan Munger*

---

## 1. Objective

*Write some fun yet difficult SQL queries. Now you’ve got to earn the points*

## 2. Lab Setup

*A fresh CAP database and a can-do attitude*

## 3. Procedure

### Part 1: *Queries*

*For each question, write the query. Then, use AI to generate the queries and grade its response.*

1. Display the cities that makes the most different kinds of products. Experiment with the rank() function
```sql
-- Me
QUERY
-- AI
QUERY
```
Grade: 

2. Display the names of products whose priceUSD is less than 1% of the average priceUSD, in alphabetical order. from A to Z
```sql
-- Me
QUERY
-- AI
QUERY
```
Grade: 

3. Display the customer last name, product id ordered, and the totalUSD for all orders made in March of any year, sorted by totalUSD from low to high.
```sql
-- Me
SELECT p.lastName, o.prodId, o.totalUSD
FROM Orders o INNER JOIN People p ON p.pid = o.custId
WHERE extract(month from o.dateOrdered) = 3 
ORDER BY o.totalUSD ASC;
-- AI
QUERY
```
Grade: 

4. Display the last name of all customers (in reverse alphabetical order) and their total ordered by customer, and nothing more. Use coalesce to avoid showing NULL totals.
```sql
-- Me
SELECT p.lastName, COALESCE(SUM(o.quantityOrdered), 0) AS totalOrdered
FROM People p INNER JOIN Customers c ON c.pid = p.pid
              LEFT OUTER JOIN Orders o ON o.custId = c.pid 
GROUP BY p.lastName
ORDER BY p.lastName DESC;
-- AI
QUERY
```
Grade: 

5. Display the names of all customers who bought products from agents based in Regina along with the names of the products they ordered, and the names of the agents who sold it to them.
```sql
-- Me
SELECT pc.firstName as custFirstName, pc.lastName as custLastName, pa.firstName as agentFirstName, pa.lastName as agentLastName, pr.name as productName
FROM Orders o INNER JOIN People pa ON o.agentId = pa.pid
              INNER JOIN People pc ON o.custId = pc.pid
              INNER JOIN Products pr ON o.prodId = pr.prodId
WHERE pa.homeCity = 'Regina';
-- AI
QUERY
```
Grade: 

6. Write a query to check the accuracy of the totalUSD column in the Orders table. This means calculating Orders.totalUSD from data in other tables and comparing those values to the values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any. If there are any incorrect values, explain why they are wrong. Round to exactly two decimal places.
```sql
-- Me
QUERY
-- AI
QUERY
```
Grade: 

7. Display the first and last name of all customers who are also agents
```sql
-- Me
SELECT p.firstName, p.lastName
FROM People p INNER JOIN Agents a ON p.pid = a.pid
              INNER JOIN Customers c ON p.pid = c.pid;
-- AI
QUERY
```
Grade: 

8. Create a VIEW of all Customer and People data called PeopleCustomers. Then another VIEW of all Agent and People data called PeopleAgents. Then select * from each of them to test them
```sql
-- Me
QUERY
-- AI
QUERY
```
Grade: 

9. Display the first and last name of all customers who are also agents, this time using the views you created
```sql
-- Me
QUERY
-- AI
QUERY
```
Grade: 

10. Compare your SQL in #7 (no views) and #9 (using views). The output is the same. How does that work? What is the database server doing internally when it processes the #9 query?

11. [Bonus] What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries in SQL to demonstrate. (Feel free to use the CAP database to make your points here.