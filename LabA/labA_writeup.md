# Database Lab Report 0x0A

**Course:** Database Management\
**Lab Number:** *Lab #0x0A*\
**Date:** *2025-4-29*\
**Name:** *Ryan Munger*

---

## 1. Objective

*To write some cool stored procedures in PostgreSQL.*

## 2. Lab Setup

*A freshly loaded courses database*

## 3. Procedure

### Part 1:
*Write two functions (stored procedures) that take an integer course number as their only parameter:* 

**​1. Function PreReqsFor(courseNum)**
*Returns the immediate prerequisites for the passed-in course number*
```sql
-- returning as table to be cool
CREATE OR REPLACE FUNCTION get_prereqs_for(check_course int)
RETURNS TABLE(course int, prereq int) AS
$$
BEGIN
  RETURN QUERY
    SELECT coursenum, prereqnum
    FROM prerequisites
    WHERE coursenum = check_course;
END;
$$
LANGUAGE plpgsql;

-- Test
SELECT * 
FROM get_prereqs_for(499);
```

**2. Function IsPreReqFor(courseNum)**
*Returns the courses for which the passed-in course number is an immediate pre-requisite.*
```sql
-- trying refcursor now
CREATE OR REPLACE FUNCTION is_prereq_for(int, REFCURSOR) RETURNS REFCURSOR AS
$$
DECLARE
   check_course int       := $1;
   resultset    REFCURSOR := $2;
BEGIN
  OPEN resultset FOR
    SELECT prereqnum, coursenum
    FROM prerequisites
    WHERE prereqnum = check_course;
  RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

-- Test
BEGIN; -- psql wouldn't take it as a single statement without this
SELECT is_prereq_for(120, 'results');
FETCH all FROM results;
COMMIT;
```

**3. Optional Recursive Challenge**
*Demonstrate Jedi-level skills and write a third, recursive, function that takes a passed-in course number and generates all of its prerequisites. Uses the first two functions you wrote and recursion.*
```sql
CREATE OR REPLACE FUNCTION jedi_get_all_prereqs(check_course INT)
RETURNS TABLE(course INT, prereq INT) AS
$$
BEGIN
  RETURN QUERY
  WITH RECURSIVE all_prereqs(course, prereq) AS (
    -- Base case
    SELECT * FROM get_prereqs_for(check_course)

    UNION

    -- Recursive case
    SELECT p.coursenum, p.prereqnum
    FROM prerequisites p
    INNER JOIN all_prereqs ap ON p.coursenum = ap.prereq
  )
  SELECT * FROM all_prereqs;
END;
$$
LANGUAGE plpgsql;

-- Test
SELECT * 
FROM jedi_get_all_prereqs(499);
```