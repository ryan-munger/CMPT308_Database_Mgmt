-- Q1
-- Me
SELECT p.* 
FROM People p INNER JOIN Customers c on p.pid = c.pid;
-- AI
SELECT p.*
FROM People p
JOIN Customers c ON p.pid = c.pid;

-- Q2
-- Me
SELECT p.*, a.*
FROM People p INNER JOIN Agents a on p.pid = a.pid;
-- AI
SELECT p.*
FROM People p
JOIN Agents a ON p.pid = a.pid;

-- Q3
-- Me
SELECT p.*, a.*
FROM People p INNER JOIN Agents a on p.pid    = a.pid
						  INNER JOIN Customers c on p.pid = c.pid;
-- AI
SELECT p.*, a.*
FROM People p
JOIN Customers c ON p.pid = c.pid
JOIN Agents a ON p.pid = a.pid;

-- Q4
-- Me
SELECT firstName 
FROM People
WHERE pid IN (
							SELECT pid 
							FROM Customers
							WHERE pid NOT IN (
																SELECT custId
																FROM Orders
															 )
						 );
-- AI
SELECT firstName
FROM People
WHERE pid IN (SELECT pid FROM Customers)
AND pid NOT IN (SELECT custId FROM Orders);

-- Q5
-- Me
SELECT p.firstName
FROM People p INNER JOIN Customers c on p.pid = c.pid
						  LEFT OUTER JOIN Orders o on c.pid = o.custId
WHERE o.custId is NULL;
-- AI
SELECT p.firstName
FROM People p
JOIN Customers c ON p.pid = c.pid
LEFT JOIN Orders o ON c.pid = o.custId
WHERE o.custId IS NULL;

-- Q6
-- Me
SELECT DISTINCT a.pid, a.commissionPct as cPct
FROM Agents a INNER JOIN Orders o on a.pid = o.agentId
							INNER JOIN Customers c on o.custId = 007
ORDER BY cPct DESC;
-- AI
SELECT a.pid, a.commissionPct
FROM Agents a
JOIN Orders o ON a.pid = o.agentId
WHERE o.custId = 007
ORDER BY a.commissionPct DESC;

-- Q7
-- Me
SELECT DISTINCT p.lastName, p.homeCity, a.commissionPct as cPct 
FROM People p INNER JOIN Agents a on p.pid = a.pid
							INNER JOIN Orders o on a.pid = o.agentId
							INNER JOIN Customers c on o.custId = 001
ORDER BY cPct DESC;
-- AI
SELECT p.lastName, p.homeCity, a.commissionPct
FROM People p
JOIN Agents a ON p.pid = a.pid
JOIN Orders o ON a.pid = o.agentId
WHERE o.custId = 001
ORDER BY a.commissionPct DESC;

-- Q8
-- Me
SELECT p.lastName, p.homeCity 
FROM People p INNER JOIN Customers c on p.pid = c.pid
WHERE p.homeCity IN (
											SELECT city
											FROM Products
											GROUP BY city
											HAVING COUNT(prodId) = (
																							SELECT MIN(num_prod)
																							FROM (
																										SELECT COUNT(prodId) as num_prod
																										FROM Products
																										GROUP BY city
																									 )
																						 )
										);
-- AI
SELECT p.lastName, p.homeCity
FROM People p
JOIN Customers c ON p.pid = c.pid
WHERE p.homeCity IN (
    SELECT city
    FROM Products
    GROUP BY city
    HAVING COUNT(DISTINCT prodId) = (
        SELECT MIN(product_count)
        FROM (
            SELECT COUNT(DISTINCT prodId) AS product_count
            FROM Products
            GROUP BY city
        ) AS counts
    )
);

-- Q9
-- Me: Subquery
SELECT name, prodid
FROM Products 
WHERE prodid IN (
								 SELECT prodid
								 FROM Orders
								 WHERE agentId IN (
																	 SELECT agentId 
																	 FROM Orders
																	 WHERE custId IN (
																										SELECT pid
																										FROM People
																										WHERE homeCity = 'Oyster Bay'
																									 )
																	)
								)
ORDER BY name ASC;
-- Me: Joins
SELECT name, prodid
FROM Products 
WHERE prodId IN (
								SELECT o.prodId 
								FROM Orders o INNER JOIN Products p ON o.prodId = p.prodId
								WHERE o.agentId IN (
																		SELECT a.pid 
																		FROM Agents a INNER JOIN Orders o ON a.pid = o.agentId
																		WHERE o.custId IN (
																												SELECT c.pid
																												FROM Customers c INNER JOIN People p ON c.pid = p.pid
																												WHERE p.homeCity = 'Oyster Bay'
																											)	
																	 )  
								)
ORDER BY name ASC;
-- AI: Subquery
SELECT name, prodId
FROM Products
WHERE prodId IN (
    SELECT prodId
    FROM Orders
    WHERE agentId IN (
        SELECT agentId
        FROM Orders
        WHERE custId IN (
            SELECT pid
            FROM People
            WHERE homeCity = 'Oyster Bay'
        )
    )
)
ORDER BY name;
-- AI: Joins Attempt 1
SELECT DISTINCT pr.name, pr.prodId
FROM Products pr
JOIN Orders o ON pr.prodId = o.prodId
JOIN Agents a ON o.agentId = a.pid
JOIN Customers c ON o.custId = c.pid
JOIN People p ON c.pid = p.pid
WHERE p.homeCity = 'Oyster Bay'
ORDER BY pr.name;
-- AI: Joins Attempt 2
SELECT DISTINCT pr.name, pr.prodId
FROM Products pr
JOIN Orders o ON pr.prodId = o.prodId
JOIN Agents a ON o.agentId = a.pid
WHERE a.pid IN (SELECT agentId FROM Orders WHERE custId IN (SELECT pid FROM People WHERE homeCity = 'Oyster Bay'))
ORDER BY pr.name;

-- Q10
-- Me
SELECT pc.firstName AS cust_first, pc.lastName AS cust_last, pa.firstName AS agent_first, pa.lastName AS agent_last, pc.homeCity AS shared_city
FROM People pc INNER JOIN Customers c ON pc.pid = c.pid
							 INNER JOIN People pa ON pa.homeCity = pc.homeCity
							 INNER JOIN Agents a ON pa.pid = a.pid
WHERE pc.pid != pa.pid;
-- AI
SELECT pc.firstName AS customer_first, pc.lastName AS customer_last, pa.firstName AS agent_first, pa.lastName AS agent_last, pc.homeCity
FROM People pc
JOIN Customers c ON pc.pid = c.pid
JOIN People pa ON pc.homeCity = pa.homeCity
JOIN Agents a ON pa.pid = a.pid
WHERE pc.pid <> pa.pid;