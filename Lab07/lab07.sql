/* 
-- EXAMPLE 1:   List all players whose last name starts with "St" and whose first name starts with "D", 
--              Do NOT use and comparator operators (i.e. AND or OR)
*/



    SELECT d.DEPARTMENT_ID FROM EMPLOYEES e RIGHT JOIN DEPARTMENTS d on (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
MINUS
    SELECT d.DEPARTMENT_ID FROM EMPLOYEES e INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
    WHERE e.JOB_ID = 'ST_CLERK';

/* 2.	Same department requests a list of countries that have no departments located in them. Display country ID and the country name.
Use SET operators.  The first result looks like:
*/


    SELECT COUNTRY_ID, COUNTRY_NAME 
    FROM COUNTRIES
MINUS
    SELECT COUNTRY_ID, COUNTRY_NAME
    FROM COUNTRIES c
    JOIN LOCATIONS l USING(COUNTRY_ID)
    JOIN DEPARTMENTS d USING(LOCATION_ID)
    WHERE d.DEPARTMENT_ID IS NOT NULL;

/* 3.	The Vice President needs very quickly a list of departments 10, 50, 20 in that order.
job and department ID are to be displayed. */


    SELECT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 10

UNION ALL

    SELECT DISTINCT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50

UNION ALL

    SELECT DISTINCT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 20;

/* 4.	Create a statement that lists the employeeIDs and JobIDs of those employees who currently have a
job title that is the same as their job title when they were initially hired by the company 
(that is, they changed jobs but have now gone back to doing their original job). */


    SELECT EMPLOYEE_ID, JOB_ID FROM JOB_HISTORY
INTERSECT
    SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES;

/* 5.	The HR department needs a SINGLE report with the following specifications:
a.	Last name and department ID of all employees regardless of whether they belong to a department or not.
b.	Department ID and department name of all departments regardless of whether they have employees in them or not.

Write a compound query to accomplish this.
*/

SELECT LAST_NAME "Last Name" , DEPARTMENT_ID "Department ID", NULL "Department" FROM EMPLOYEES
UNION ALL
SELECT NULL, DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;