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
