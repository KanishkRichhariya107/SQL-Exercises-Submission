-- QUERY 1
SELECT distinct location
FROM sandwiches
where filling IN 
(select filling 
from tastes where name = 'Jones'
)


-- QUERY 2
SELECT distinct s.location
FROM sandwiches AS s
Join Tastes AS t
on t.filling = s.filling 
Where t.name = 'Jones'


-- QUERY 3

SELECT l.lname AS location, count(Distinct t.name) AS people
FROM Locations AS l
Left Join Sandwiches AS s
on s.location = l.LName
Left Join Tastes AS t
on s.filling = t.filling
group by l.lname

