--QUESTION NUMBER 1

-- QUERY 1
SELECT distinct location
FROM sandwiches
where filling IN (
    select filling 
    from tastes where name = 'Jones'
);


-- QUERY 2
SELECT DISTINCT s.location
FROM sandwiches AS s
Join Tastes AS t
ON t.filling = s.filling 
Where t.name = 'Jones';


-- QUERY 3

SELECT l.lname AS location, count(DISTINCT t.name) AS people
FROM Locations AS l
LEFT JOIN Sandwiches AS s
ON s.location = l.LName
LEFT JOIN Tastes AS t
ON s.filling = t.filling
GROUP BY l.lname;


-- QUESTION NUMBER 2


-- QUERY 1

SELECT title as name 
FROM Titles
WHERE Publisher = 'Macmillan';

-- QUERY 2

SELECT DISTINCT branch
FROM Holdings
WHERE title IN (
	SELECT title 
	FROM Titles 
	WHERE author = 'Ann Brown'
);

-- QUERY 3

SELECT Distinct h.branch 
FROM Holdings AS h
JOIN Titles AS t
    On h.title = t.title
WHERE t.author = 'Ann Brown';

-- QUERY 4

SELECT b.BCode, COALESCE(SUM("#copies"),0) AS total_books
FROM Branch AS b
LEFT JOIN Holdings AS h
	ON h.branch = b.bcode
GROUP BY b.bcode;

