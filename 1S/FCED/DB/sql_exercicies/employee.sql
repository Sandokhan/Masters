-- 1. List all employees and their departments. (employee_name, department_name)

SELECT 
    e.name AS employee_name,
    d.name AS department_name
FROM employee e
JOIN department d ON d.id = e.id_dep;

/* Result
 employee_name | department_name 
---------------+-----------------
 John          | Logistics
 Mike          | Logistics
 John          | Logistics
 Theresa       | Transports
 Charles       | Transports
 Mary          | Transports
 Beatrice      | Transports
 Brett         | Cleaning
 Alfred        | Cleaning
 Barry         | Cleaning
 Carrie        | Cleaning
 Thomas        | Cleaning
 Emily         | Human Resources
 Megan         | Human Resources
 Sarah         | Informatics
 William       | Informatics
 James         | Informatics
 Harry         | Informatics
 Matthew       | Informatics
 Kate          | Informatics */

-- 2. List all departments and their directors. (department_name, director_name)

SELECT 
    d.name AS department_name,
    e.name AS employee_name
FROM employee e
JOIN department d ON d.id = e.id_dep
WHERE e.id_sup IS NULL;

/* Result

 department_name | employee_name 
-----------------+---------------
 Logistics       | John
 Transports      | Theresa
 Cleaning        | Brett
 Human Resources | Emily
 Informatics     | Sarah */

-- 3. List all projects and the department to which they belong. (project_name, department_name)

SELECT
    p.name AS project_name,
    d.name AS department_name
FROM project p
JOIN department d ON p.id_dep = d.id;

/* Result
 project_name | department_name 
--------------+-----------------
 XPTO         | Logistics
 YPTO         | Transports
 ZPTO         | Informatics */

-- 4. What projects are controlled by department number 1. (project_name)
-- 5. What projects are controlled by the Transports department? (project_name)
-- 6. List all employees working on project XPTO, and how many hours each one of them works in that project. 
-- (employee_name, hours)
-- 7. List all employees working on project XPTO,
-- and how many hours each one of them works in that project. 
SELECT
    e.name,
    SUM(hours)
FROM employee e
JOIN works w ON e.id = w.id_emp
JOIN project p  USING(id_dep)
WHERE p.name = 'XPTO'
GROUP BY 1
-- Order the list from the employee that works more hours to the one that works less. (employee_name, hours)
-- 8. How many employees work on each project? (project_name, number)
-- 9. How many hours are spent weekly on each project? (project_name, hours)
-- 10. How many hours does each employee spend on projects every week? (employee_name, hours)

SELECT
    e.name,
    SUM(hours)
FROM employee e
JOIN works w ON e.id = w.id_emp
GROUP BY e.name;

-- 11. List all employees and their superiors. (employee_name, superior_name)


-- 12. List all employees and their superiors. If the employee does not have a superior list it anyway with a NULL superior. 
-- (employee_name, superior_name)
-- 13. What is the largest salary in each department? (department_name, salary)
-- 14. What is the highest salary in the whole company? (salary)
-- 15. What is the difference between the highest and lowest salaries in the company? (difference)
-- 16. What is the salary difference between each employee and his superior? (employee_name, superior_name, difference)
-- 17. What is the biggest difference between the salary of an employee and his superior? (difference)
-- 18. List the departments where the average salary is more than 1300 euros. (department_name)
SELECT name FROM
department
WHERE id IN (
SELECT id_dep
FROM employee
GROUP BY 1
HAVING AVG(salary) > 1300);
-- 19. List the employees who work on projects external to their department. (employee_name)

SELECT
    e.name
FROM employee e
JOIN works w ON w.id_emp = e.id
JOIN project p ON p.id = w.id_pro
WHERE p.id_dep <> e.id_dep
GROUP BY e.id
-- 20. List the employees who work on projects internal to their department. (employee_name)


SELECT employee.name
FROM employee JOIN
     works ON id_emp = id JOIN
     project ON id_pro = project.id
WHERE employee.id_dep = project.id_dep
GROUP BY employee.id
ORDER BY 1;

-- 21. List the employees who only work on projects internal to their department. (employee_name)




