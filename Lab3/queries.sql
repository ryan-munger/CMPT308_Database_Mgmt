-- Writeup is available in pdf form
-- AI queries were provided in one line, I formatted it just for you Alan.

-- Q1
-- Me
SELECT ordernum, totalusd 
FROM Orders;
-- AI
SELECT orderNum, totalUSD 
FROM Orders;

-- Q2
-- Me
SELECT lastname, homecity 
FROM People 
WHERE prefix = 'Ms.';
-- AI
SELECT lastName, homeCity 
FROM People 
WHERE prefix = 'Ms.';

-- Q3
SELECT prodid, name, qtyonhand 
FROM Products 
WHERE qtyonhand > 1007;
-- AI
SELECT prodId, name, qtyOnHand
FROM Products 
WHERE qtyOnHand > 1007;

-- Q4
-- Me (Between is inclusive)
SELECT firstname, homecity 
FROM People 
WHERE dob BETWEEN DATE '1940-01-01' AND DATE '1949-12-31';
-- AI
SELECT firstName, homeCity 
FROM People 
WHERE EXTRACT(DECADE FROM DOB) = 194;

-- Q5
-- Me
SELECT prefix, lastname 
FROM People 
WHERE prefix != 'Mr.';
-- AI
SELECT prefix, lastName 
FROM People 
WHERE prefix != 'Mr.';

-- Q6
-- Me
SELECT * 
FROM Products 
WHERE city NOT IN ('Dallas', 'Duluth') AND priceusd <= 17;
-- AI
SELECT * 
FROM Products 
WHERE city NOT IN ('Dallas', 'Duluth') AND priceUSD <= 17;

-- Q7
-- Me
SELECT * 
FROM Orders 
WHERE EXTRACT(MONTH FROM dateordered) = 1;
-- AI
SELECT * 
FROM Orders 
WHERE EXTRACT(MONTH FROM dateOrdered) = 1;

-- Q8
-- Me
SELECT * 
FROM Orders 
WHERE EXTRACT(MONTH FROM dateordered) = 2 AND totalusd >= 23000;
-- AI
SELECT * 
FROM Orders 
WHERE EXTRACT(MONTH FROM dateOrdered) = 2 AND totalUSD >= 23000;

-- Q9
-- Me
SELECT * 
FROM Orders 
WHERE custid = 10;
-- AI
SELECT * 
FROM Orders 
WHERE custId = 010;

-- Q10
-- Me
SELECT * 
FROM Orders
WHERE custid = 5;
-- AI
SELECT * 
FROM Orders 
WHERE custId = 005;