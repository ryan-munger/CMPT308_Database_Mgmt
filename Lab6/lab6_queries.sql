-- Q1: Display the cities that makes the most different kinds of products. Experiment with the rank() function
-- Me: Intuition
SELECT city
FROM Products
GROUP BY city
HAVING COUNT(*) = (
                    SELECT MAX(count) 
                    FROM (
                          SELECT COUNT(*) AS count 
                          FROM Products 
                          GROUP BY city
                         ) 
                  );
-- Me: Rank()
SELECT city
FROM (
      SELECT city, COUNT(*) AS count, RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
      FROM Products
      GROUP BY city
     ) 
WHERE rank = 1;

-- AI

-- Q2: Display the names of products whose priceUSD is less than 1% of the average priceUSD, in alphabetical order. from A to Z
-- Me
SELECT name
FROM Products WHERE priceUSD < ( 
                                SELECT AVG(priceUSD) * 0.01
                                FROM Products
                               );
-- AI

-- Q3: Display the customer last name, product id ordered, and the totalUSD for all orders made in March of any year, sorted by totalUSD from low to high.
-- Me
SELECT p.lastName, o.prodId, o.totalUSD
FROM Orders o INNER JOIN People p ON p.pid = o.custId
WHERE extract(month from o.dateOrdered) = 3 
ORDER BY o.totalUSD ASC;
-- AI

-- Q4: Display the last name of all customers (in reverse alphabetical order) and their total ordered by customer, and nothing more. Use coalesce to avoid showing NULL totals.
-- Me
SELECT p.lastName, COALESCE(SUM(o.quantityOrdered), 0) AS totalOrdered
FROM People p INNER JOIN Customers c ON c.pid = p.pid
              LEFT OUTER JOIN Orders o ON o.custId = c.pid 
GROUP BY p.lastName
ORDER BY p.lastName DESC;
-- AI

-- Q5: Display the names of all customers who bought products from agents based in Regina along with the names of the products they ordered, and the names of the agents who sold it to them.
-- Me
SELECT pc.firstName as custFirstName, pc.lastName as custLastName, pa.firstName as agentFirstName, pa.lastName as agentLastName, pr.name as productName
FROM Orders o INNER JOIN People pa ON o.agentId = pa.pid
              INNER JOIN People pc ON o.custId = pc.pid
              INNER JOIN Products pr ON o.prodId = pr.prodId
WHERE pa.homeCity = 'Regina';
-- AI

-- Q6: Write a query to check the accuracy of the totalUSD column in the Orders table. This means calculating Orders.totalUSD from data in other tables and comparing those values to the values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any. If there are any incorrect values, explain why they are wrong. Round to exactly two decimal places.
-- Me
-- Orders 1017 anad 1024 appear to be wrong due to a mistype. Order 1026 is wrong because they mistakenly used Customer 10's discountPct (10.01%) instead of Customer 7's (2%).
SELECT o.*, ROUND(o.quantityOrdered * pr.priceUSD * (1 - (c.discountPct * .01)), 2) as correctTotal
FROM Orders o INNER JOIN Products pr ON o.prodId = pr.prodId
              INNER JOIN Customers c ON c.pid = o.custId
WHERE o.totalUSD != ROUND(o.quantityOrdered * pr.priceUSD * (1 - (c.discountPct * .01)), 2);
-- AI

-- Q7: Display the first and last name of all customers who are also agents
-- Me
SELECT p.firstName, p.lastName
FROM People p INNER JOIN Agents a ON p.pid = a.pid
              INNER JOIN Customers c ON p.pid = c.pid;
-- AI

-- Q8: Create a VIEW of all Customer and People data called PeopleCustomers. Then another VIEW of all Agent and People data called PeopleAgents. Then select * from each of them to test them
-- Me
-- I won't be losing any bets!!
CREATE VIEW PeopleCustomers AS
SELECT 
    c.pid,
    c.paymentTerms,
    c.discountPct,
    p.prefix,
    p.firstName,
    p.lastName,
    p.suffix,
    p.homeCity,
    p.DOB
FROM Customers c INNER JOIN People p ON p.pid = c.pid;

SELECT * 
FROM PeopleCustomers;

CREATE VIEW PeopleAgents AS
SELECT 
    a.pid,
    a.paymentTerms,
    a.commissionPct,
    p.prefix,
    p.firstName,
    p.lastName,
    p.suffix,
    p.homeCity,
    p.DOB
FROM Agents a INNER JOIN People p ON p.pid = a.pid;

SELECT * 
FROM PeopleAgents;
-- AI

-- Q9: Display the first and last name of all customers who are also agents, this time using the views you created
-- Me
SELECT pc.firstName, pc.lastName
FROM PeopleCustomers pc INNER JOIN PeopleAgents pa ON pa.pid = pc.pid;
-- AI