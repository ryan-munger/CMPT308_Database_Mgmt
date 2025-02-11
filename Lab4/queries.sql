-- DB Lab 4 Queries
-- Mine followed by AI
-- Writeup available.


-- Me
SELECT * 
FROM People
WHERE pid IN (SELECT pid
              FROM Customers);
-- AI
SELECT *
FROM People
WHERE pid IN (SELECT pid FROM Customers);

-- Me
SELECT * 
FROM People
WHERE pid IN (SELECT pid
              FROM Agents);
-- AI
SELECT *
FROM People
WHERE pid IN (SELECT pid FROM Agents);

-- Me - queryception, I know I could have used AND
SELECT * 
FROM People
WHERE pid IN (SELECT pid
              FROM Customers
              WHERE pid IN (SELECT pid
                            FROM Agents));
-- AI
SELECT *
FROM People
WHERE pid IN (SELECT pid FROM Customers)
  AND pid IN (SELECT pid FROM Agents);

-- Me
SELECT * 
FROM People
WHERE pid NOT IN (SELECT pid FROM Customers)
  AND pid NOT IN (SELECT pid FROM Agents);
-- AI
SELECT *
FROM People
WHERE pid NOT IN (SELECT pid FROM Customers)
  AND pid NOT IN (SELECT pid FROM Agents);

-- Me
SELECT DISTINCT custId
FROM Orders
WHERE prodId = 'p01' OR prodId = 'p03'
Order by custId ASC;
-- AI
SELECT DISTINCT custId
FROM Orders
WHERE prodId = 'p01' OR prodId = 'p03'
ORDER BY custId ASC;

-- Me
SELECT DISTINCT custId
FROM Orders
WHERE custId IN (SELECT custId
                 FROM Orders
                 WHERE prodId = 'p01') 
  AND custId IN (SELECT custId
                 FROM Orders
                 WHERE prodId = 'p03') 
Order by custId DESC;
-- AI
SELECT custId
FROM Orders
WHERE prodId = 'p01'
INTERSECT
SELECT custId
FROM Orders
WHERE prodId = 'p03'
ORDER BY custId DESC;

-- Me
SELECT firstName, lastName
FROM People
WHERE pid IN (SELECT pid
              FROM Agents
              WHERE pid IN (SELECT agentId
                            FROM Orders
                            WHERE prodId = 'p05' OR prodId = 'p07'))
Order by lastName ASC;
-- AI
SELECT firstName, lastName
FROM People
WHERE pid IN (SELECT agentId FROM Orders WHERE prodId = 'p05' OR prodId = 'p07')
ORDER BY lastName ASC;

-- Me
SELECT homeCity, DOB
FROM People
WHERE pid IN (SELECT pid
              FROM Agents
              WHERE pid IN (SELECT agentId
                            FROM Orders
                            WHERE custId = 7))
Order by homeCity DESC;
-- AI
SELECT homeCity, DOB
FROM People
WHERE pid IN (SELECT agentId FROM Orders WHERE custId = '007')
ORDER BY homeCity DESC;

-- Me
SELECT DISTINCT prodId
FROM Orders
WHERE agentId IN (SELECT agentId
                  FROM Orders
                  WHERE custId IN (SELECT pid
                                   FROM People
                                   WHERE homeCity = 'Saginaw'))
Order by prodId DESC;
-- AI
SELECT DISTINCT prodId
FROM Orders
WHERE agentId IN (SELECT pid FROM Agents WHERE pid IN (SELECT agentId FROM Orders WHERE custId IN (SELECT pid FROM People WHERE homeCity = 'Saginaw')))
ORDER BY prodId DESC;

-- Me
SELECT lastName, homeCity
FROM People
WHERE pid IN (SELECT pid
              FROM Customers
              WHERE pid IN (SELECT custId
                            FROM Orders
                            WHERE agentId IN (SELECT pid
                                              FROM People
                                              WHERE homeCity = 'Regina' OR homeCity = 'Pinner')))
Order by lastName ASC;
-- AI
SELECT lastName, homeCity
FROM People
WHERE pid IN (SELECT custId FROM Orders WHERE agentId IN (SELECT pid FROM Agents WHERE pid IN (SELECT pid FROM People WHERE homeCity = 'Regina' OR homeCity = 'Pinner')))
ORDER BY lastName ASC;

