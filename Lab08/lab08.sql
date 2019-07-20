/* 1)	Display the names of the employees whose salary is the same as the lowest salaried employee in any department. */

SELECT LAST_NAME || ' ' || FIRST_NAME "Full Name"
FROM EMPLOYEES 
WHERE SALARY IN (SELECT MIN(SALARY) 
                    FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID);


/* 2)	Display the names of the employee(s) whose salary is the lowest in each department. */
SELECT LAST_NAME || ' ' || FIRST_NAME "Full Name"
FROM EMPLOYEES 
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY) 
                                    FROM EMPLOYEES
                                GROUP BY DEPARTMENT_ID);

/* 3)	Give each of the employees in question 2 a $120 bonus. */

SELECT LAST_NAME || ' ' || FIRST_NAME "Full Name", Salary "Salary w $120"
FROM EMPLOYEES 
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY) 
                                    FROM EMPLOYEES
                                GROUP BY DEPARTMENT_ID);

/* 4)	Create a view named vwAllEmps that consists of all employees includes employee_id, last_name, salary, department_id, department_name, city and country (if applicable) */

CREATE VIEW vwALLEmps AS
(SELECT EMPLOYEE_ID, LAST_NAME, SALARY, DEPARTMENT_ID, CITY, COUNTRY_ID FROM EMPLOYEES e 
JOIN DEPARTMENTS d USING(DEPARTMENT_ID)
JOIN LOCATIONS l USING(LOCATION_ID));

/* 5)	Use the vwAllEmps view to:
a.	Display the employee_id, last_name, salary and city for all employees
b.	Display the total salary of all employees by city
c.	Increase the salary of the lowest paid employee(s) in each department by 120
d.	What happens if you try to insert an employee by providing values for all columns in this view?
e.	Delete the employee named Vargas. Did it work? Show proof.
 */
 
 /* a) */
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, CITY
FROM vwALLEmps;

/* b) */

SELECT SUM(SALARY) "Total Salary"
FROM vwALLEmps
GROUP BY CITY;

/* c) */
SELECT LAST_NAME "Last Name", Salary "Salary w $120"
FROM vwALLEmps
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY) 
                                    FROM vwALLEmps
                                GROUP BY DEPARTMENT_ID);

/* d) You cannot insert a new data into view. The view is dependent on the other relational tables
ERRPOR*/

/* e) */

DELETE FROM vwALLEmps 
WHERE UPPER(LAST_NAME) = 'VARGAS';

/* Deleted Successfully */ 
SELECT *
FROM vwALLEmps;



/* 6)	Create a view named vwAllDepts that consists of all departments and includes department_id, department_name, city and country (if applicable) */
CREATE VIEW vwALLDepts AS
(SELECT DEPARTMENT_ID, DEPARTMENT_NAME, CITY, COUNTRY_ID FROM DEPARTMENTS 
JOIN LOCATIONS USING(LOCATION_ID)
JOIN COUNTRIES c USING(COUNTRY_ID));


/* 7)	Use the vwAllDepts view to:

a.	For all departments display the department_id, name and city
b.	For each city that has departments located in it display the number of departments by city
 */
 
 /* a) */
 
 SELECT DEPARTMENT_ID, DEPARTMENT_NAME, CITY
 FROM vwALLDepts;
 
 
/* b) */

SELECT CITY, COUNT(DEPARTMENT_ID) "# of Depts"
FROM vwALLDepts
GROUP BY CITY;

/* 8)	Create a view called vwAllDeptSumm that consists of all departments and includes for each department: department_id, department_name, number of employees, number of salaried employees, total salary of all employees. Number of Salaried must be different from number of employees. The difference is some get commission.*/
CREATE VIEW vwALLDeptSumm AS 
(SELECT d.DEPARTMENT_ID "Department ID", d.DEPARTMENT_NAME "Department Name", COUNT(e.EMPLOYEE_ID) "Total Employees", (COUNT(e.EMPLOYEE_ID) - COUNT(e.COMMISSION_PCT)) "Salaried Employees", SUM(e.SALARY) "Total Salary"
FROM EMPLOYEES e
FULL JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_ID, d.DEPARTMENT_NAME);



/* (9)	Use the vwAllDeptSumm view to display department name and number of employees for departments that have more than the average number of employees */
SELECT "Department Name", "Total Employees" FROM vwALLDEPTSumm
WHERE "Total Employees" > (SELECT avg("Total Employees") from vwALLDEPTSumm);

/* 10)	A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees table and to allow them to retrieve, insert and update data in your departments table. Show proof
B) Use the REVOKE statement to remove permission for that student to insert and update data in your departments table
 */
SELECT *
FROM ALL_USERS where lower(username) = 'dbs301_192e07'; 

/* dbs301_192e07 < friends username*/

GRANT SELECT ON EMPLOYEES TO dbs301_192e07; 

GRANT SELECT, INSERT, UPDATE ON DEPARTMENTS TO dbs301_192e07; 

REVOKE INSERT,UPDATE ON DEPARTMENTS FROM dbs301_192e07; 

/* 
Grant succeeded.


Grant succeeded.


Revoke succeeded. */
