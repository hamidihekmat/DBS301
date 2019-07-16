/* 
-- EXAMPLE 1:   List all players whose last name starts with "St" and whose first name starts with "D", 
--              Do NOT use and comparator operators (i.e. AND or OR)
*/



SELECT d.DEPARTMENT_ID FROM EMPLOYEES e RIGHT JOIN DEPARTMENTS d on (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
MINUS
SELECT d.DEPARTMENT_ID FROM EMPLOYEES e INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE e.JOB_ID = 'ST_CLERK';
