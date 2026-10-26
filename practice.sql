select d.*, count(e.employee_id), avg(e.salary), max(e.salary), sum(e.salary)
from departments as d
join employees as e
on d.department_id = e.department_id
group by d.department_id

select e1.employee_name,e2.employee_name as manger
from employees as e1
join employees as e2
on e1.manager_id = e2.employee_id

select a.employee_id
from employees  as a where NOT EXISTS (select 1 from assignments as e where e.employee_id = a.employee_id )

select e1.employee_name, e2.employee_name,d.department_name, e1.salary AS salary1, e2.salary AS salary2
from employees as e1 
JOIN employees as e2 on e1.department_id = e2.department_id 
JOIN departments as d on e1.department_id = d.department_id
where e1.employee_id < e2.employee_id  
order by e1.employee_name, e2.employee_name, d.department_name;

select e.* from employees as e where salary >=(select avg(salary) from employees);

select * from employees as e1
LEFT JOIN (
select e.department_id, avg(e.salary) as salry_avg from employees as e where e.department_id IS NOT NULL group by e.department_id ) as avg_sal_table
on e1.department_id = avg_sal_table.department_id
WHERE e1.salary > avg_sal_table.salry_avg;

SELECT e.employee_id, e.employee_name, e.department_id, e.salary
FROM employees AS e
WHERE e.department_id IS NOT NULL
AND e.salary > (
SELECT AVG(e2.salary)
FROM employees AS e2
WHERE e2.department_id = e.department_id
);

select *
from( select e.*, avg(salary) over(partition by department_id) as avg_salary from employees as e) as avg_salary_table
where salary > avg_salary;

select * from (select *, dense_rank() over(partition by department_id order by salary DESC ) as rnk from employees) as w_table
where rnk = 2;

WITH my_table as (select c.customer_id, c.customer_name, o.order_id,sum(oi.quantity*oi.unit_price) as value
from customers as c
JOIN orders as o
on c.customer_id = o.customer_id and o. status != 'cancelled'
JOIN order_items as oi
on oi.order_id = o.order_id
GROUP BY c.customer_id, o.order_id)
select * from my_table where value > (select avg(value) from my_table);

select *, sum(salary)over( order by hire_date)   from employees;

SELECT c.customer_id,c.customer_name,SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
AND o.status <> 'cancelled'
LEFT JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY
c.customer_id,
c.customer_name
ORDER BY c.customer_id;

SELECT *
FROM Customers as c
WHERE NOT EXISTS (
  select 1 from orders as o join payments as p on p.order_id = o.order_id  where o.customer_id = c.customer_id and p.payment_status = 'successful'
);

SELECT o.order_id, (sum(o.quantity*o.unit_price) - p.amount) as diff
FROM order_items as o
Join payments as p
ON p.order_id = o.order_id
group by o.order_id, p.amount
order by order_id;

WITH TEMP as (select p.project_id,p.department_id,p.budget ,COALESCE(sum(a.hours_worked),0) as total_worked_hours
FROM projects as p
LEFT JOIN assignments as a
ON p.project_id = a.project_id
GROUP BY p.project_id)
SELECT d.*, sum(t.total_worked_hours) as th, sum(t.budget)
FROM departments as d
LEFT JOIN temp as t
on d.department_id = t.department_id
GROUP BY d.department_id;

