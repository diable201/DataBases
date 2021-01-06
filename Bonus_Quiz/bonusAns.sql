select e.first_name, e.last_name
from employees e,
     employees e2,
     departments d,
     locations l
where e.manager_id = e2.employee_id
  and d.department_id = e2.department_id
  and l.location_id = d.location_id
  and l.country_id = 'US';

select d.department_id, department_name, d.manager_id, location_id, count(e.employee_id), avg(e.salary)
from departments d
         left join employees e using (department_id)
group by d.department_id, department_name, d.manager_id, location_id;

select l.location_id,
       street_address,
       postal_code,
       city,
       state_province,
       country_id,
       count(distinct d.department_id),
       count(e.employee_id)
from locations l
         left join departments d on l.location_id = d.location_id
         left join employees e on d.department_id = e.department_id
group by l.location_id, street_address, postal_code, city, state_province, country_id;

select *
from employees e
where e.department_id IN (select d.department_id
                          from departments d
                                   join employees e2 on d.department_id = e2.department_id
                          group by d.department_id
                          order by avg(e2.salary) desc
                          offset 2 limit 1);
