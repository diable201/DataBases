-- Create indexes for queries like below:
CREATE INDEX name_of_countries ON countries (name);
SELECT *
FROM countries
WHERE name = 'string';
CREATE INDEX name_of_employees ON employees (name, surname);
SELECT *
FROM employees
WHERE name = 'string'
  AND surname = 'string';
CREATE UNIQUE INDEX salary_delta ON employees (salary);
SELECT *
FROM employees
WHERE salary < value1
  and salary > value2;
CREATE INDEX subs_employees ON employees (substring(name from 1 for 4));
SELECT *
FROM employees
WHERE substring(name from 1 for 4) = 'abcd';
CREATE INDEX depart_index ON employees (department_id, salary);
CREATE INDEX budget_index ON departments (department_id, budget);
SELECT *
FROM employees e
         JOIN departments d ON d.department_id = e.department_id
WHERE d.budget > value2
  AND e.salary < value2;
