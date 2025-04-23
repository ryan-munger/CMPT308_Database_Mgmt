-- Example to get courses by credits

create or replace function get_courses_by_credits(int, REFCURSOR) returns refcursor as 
$$
declare
   num_credits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= num_credits;
   return resultset;
end;
$$ 
language plpgsql;

select get_courses_by_credits(0, 'results');
Fetch all from results;


-- get immediate prereqs for course number
-- returning as table to be cool
CREATE OR REPLACE FUNCTION get_prereqs_for(check_course int) 
RETURNS TABLE(prereq int) AS
$$
BEGIN
  RETURN QUERY
    SELECT prereqnum
    FROM prerequisites
    WHERE coursenum = check_course;
END;
$$
LANGUAGE plpgsql;

-- Test
SELECT * 
FROM get_prereqs_for(499);


-- returns courses for which the course is a prereq
-- trying refcursor now
CREATE OR REPLACE FUNCTION is_prereq_for(int, REFCURSOR) RETURNS REFCURSOR AS
$$
DECLARE
   check_course int       := $1;
   resultset    REFCURSOR := $2;
BEGIN
  OPEN resultset FOR
    SELECT coursenum
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


-- recursively get all prereqs
-- was originally thinking shared refcursor
-- google says to do it this way, much better
CREATE OR REPLACE FUNCTION jedi_get_all_prereqs(check_course INT)
RETURNS TABLE(course INT, prereq INT) AS
$$
BEGIN
  RETURN QUERY
  WITH RECURSIVE all_prereqs(course, prereq) AS (
    SELECT coursenum, prereqnum
    FROM prerequisites
    WHERE coursenum = check_course

    UNION

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
FROM get_all_prereqs(499);