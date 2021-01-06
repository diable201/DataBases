-- 1
SELECT first_name, last_name
FROM employees
WHERE manager_id IN (SELECT employee_id
                     FROM employees
                     WHERE department_id
                               IN (SELECT department_id
                                   FROM departments
                                   WHERE location_id
                                             IN (SELECT location_id FROM locations WHERE country_id = 'US')));

-- 2
SELECT department_name, avg(salary), count(employee_id)
FROM departments
         JOIN employees USING (department_id)
GROUP BY department_name;

-- 3
SELECT count(e.employee_id), city
FROM departments
         JOIN employees e on departments.department_id = e.department_id
         JOIN locations l on departments.location_id = l.location_id
GROUP BY city;

-- 4
SELECT first_name, last_name
FROM employees
GROUP BY employees.department_id, first_name, last_name
HAVING department_id = (SELECT d.department_id
                        FROM employees
                                 JOIN departments d on d.department_id = employees.department_id
                        GROUP BY d.department_id
                        ORDER BY avg(salary) DESC
                        LIMIT 1 OFFSET 2);
                        