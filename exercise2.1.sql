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
Group by b.bcode;
