/* 1. Display the department name, city, street address and postal code for all
 departments. Use the JOIN and USING form of syntax.
 Sort the output by department name descending. */
 
 
 SELECT DEPARTMENT_NAME "Department Name", CITY "City", STREET_ADDRESS "Street Adress", POSTAL_CODE "Postal Code"
 FROM DEPARTMENTS JOIN LOCATIONS USING (LOCATION_ID)
 ORDER BY 1 DESC;

/* 2. Display full name of the employees, their hire date and salary together with
their department name, but only for departments which names start with A or S. Full name
should be in format of :
First / Last. Use the JOIN and ON form of syntax.
Sort the output by department name and then by last name.
*/


SELECT FIRST_NAME || ' ' || LAST_NAME "Full Name", HIRE_DATE "Hire Date", SALARY "Salary", DEPARTMENT_NAME "Department Name" FROM EMPLOYEES T1
INNER JOIN DEPARTMENTS T2 ON T1.DEPARTMENT_ID = T2.DEPARTMENT_ID
WHERE DEPARTMENT_NAME LIKE 'A%' OR DEPARTMENT_NAME LIKE 'S%'
ORDER BY "Department Name", T1.LAST_NAME;

/* 3. Display full name of the manager of each department in provinces Ontario,
California and Washington plus department name, city, postal code and province name. Full
name should be in format of :
Last, First. Use the JOIN and ON form of syntax.
Sort the output by city and then by department name. FULL NAME, DEPARTMENT NAME, CITY POSTAL CODE AND PROVINCE
*/


SELECT  FIRST_NAME || ' ' || LAST_NAME "Full Name", DEPARTMENT_NAME "Department Name", CITY "City", POSTAL_CODE "Postal Code", STATE_PROVINCE "Province"  FROM EMPLOYEES T1 
INNER JOIN DEPARTMENTS T2 ON T1.DEPARTMENT_ID = T2.DEPARTMENT_ID
INNER JOIN LOCATIONS T3 ON T2.LOCATION_ID = T3.LOCATION_ID
WHERE STATE_PROVINCE NOT IN ('Ontario','California','Washington')
ORDER BY "City", "Department Name" ;


/* 4. Display the department name and Highest, Lowest and Average pay per each
 department. Name these results High, Low and Avg.
 Use JOIN and ON form of the syntax.
 Sort the output so that department with highest average salary are shown first.
 */
 
 SELECT DEPARTMENT_NAME "Department Name", MAX(SALARY) "Highest", MIN(SALARY) "Lowest", ROUND(AVG(SALARY)) "Average"  FROM EMPLOYEES T1 
 INNER JOIN DEPARTMENTS T2 ON T1.DEPARTMENT_ID = T2.DEPARTMENT_ID
 GROUP BY DEPARTMENT_NAME
 ORDER BY "Average" DESC;
