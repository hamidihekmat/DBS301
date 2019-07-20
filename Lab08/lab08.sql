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
