CREATE DATABASE employees;

\c employees

CREATE TABLE Departments(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE Employees(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    salary INTEGER NOT NULL DEFAULT 0,
    department_id INTEGER REFERENCES Departments(id)
);

CREATE TABLE Commissions(
	id SERIAL NOT NULL PRIMARY KEY,
	employee_id INTEGER NOT NULL REFERENCES Employees(id),
	commission_amount INTEGER NOT NULL
);

INSERT INTO departments (id, name)
VALUES
(1,'Banking'),
(2,'Insurance'),
(3,'Services');


INSERT INTO employees (id, name, salary, department_id)
VALUES
(1,'Chris Gayle',1000000,1),
(2,'Michael Clarke',800000,2),
(3,'Rahul Dravid',700000,1),
(4,'Ricky Pointing',600000,2),
(5,'Albie Morkel',650000,2),
(6,'Wasim Akram',750000,3);

INSERT INTO commissions (id, employee_id, commission_amount)
VALUES
(1,1,5000),
(2,2,3000),
(3,34000),
(4,1,4000),
(5,2,3000),
(6,4,2000),
(7,5,1000),
(8,6,5000);


--QUERRY 1

SELECT e.id, e.name, SUM(c.commission_amount) as total_commission
FROM Employees As e
LEFT JOIN Commissions AS c
ON e.id = c.employee_id
GROUP BY e.id
ORDER BY total_commission DESC
LIMIT 1;

--QUERRY 2

SELECT *
FROM Employees
ORDER BY Salary DESC
LIMIT 1 OFFSET 3;

--QUERRY 3

SELECT d.id, d.name, SUM(c.commission_amount) as total_commission
FROM Departments as d
LEFT JOIN Employees As e
ON d.id = e.department_id
LEFT JOIN Commissions AS c
ON e.id = c.employee_id
GROUP BY d.id
ORDER BY total_commission DESC
LIMIT 1;

--QUERRY 4

SELECT
STRING_AGG(e.name, ', ' ORDER BY e.id) AS employees,
c.commission_amount
FROM employees AS e
JOIN commissions AS c
ON e.id = c.employee_id
WHERE c.commission_amount > 3000
GROUP BY c.commission_amount;