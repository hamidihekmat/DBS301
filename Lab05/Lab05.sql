/* 1. Display last name and job id for all employees who perform the same job as Davies. Exclude Davies
from this query.
*/

SELECT LAST_NAME "Last Name", JOB_ID "Job ID" FROM EMPLOYEES WHERE JOB_ID = 
(SELECT JOB_ID FROM EMPLOYEES WHERE LAST_NAME = 'Davies') AND LAST_NAME != 'Davies';

/* 2. Display last name, job id and hire date for all employees hired after Grant.
Sort the output by the most recent hire date.
*/

SELECT LAST_NAME "Last Name", JOB_ID "Job ID", HIRE_DATE "Hire Date" FROM EMPLOYEES
WHERE HIRE_DATE > (SELECT HIRE_DATE FROM EMPLOYEES WHERE LAST_NAME = 'Grant');

/* 3. Display city, province name and postal code for all departments located in countries that start with
letter I (meaning Italy, Israel and India). If the province is blank, show message Unknown and the
heading should be Province.
Sort the output by city ascending. 
*/

SELECT CITY "City", STATE_PROVINCE || CASE WHEN STATE_PROVINCE IS NULL THEN 'Unknown' END "Province", POSTAL_CODE "Postal Code" FROM LOCATIONS
WHERE COUNTRY_ID LIKE 'I%'
ORDER BY 1;

/* 4. Display last name, job id and salary for all employees who earn less than the Average salary in the
Sales department. Do NOT use Join method.
Sort the output by top salaries first and then by job_title.
*/

SELECT LAST_NAME "Last Name", JOB_ID "Job Title", SALARY "Salary" FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)FROM EMPLOYEES WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Sales'))
ORDER BY "Salary" DESC, "Job Title" ;

/* 5. Display last name, job id and salary for all employees whose salary matches any of
the salaries from the IT Department.
Sort the output by salary ascending first and then by last_name.
*/

SELECT LAST_NAME "Last Name", JOB_ID "Job ID", SALARY "Salary" FROM EMPLOYEES 
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT'))
ORDER BY "Salary", FIRST_NAME, "Last Name";

/* 6. Display last name and salary for all employees who earn less than the Lowest salary in ANY
department.
Sort the output by top salaries first and then by last name. 
*/

SELECT LAST_NAME "Last Name", SALARY FROM EMPLOYEES
WHERE SALARY < ANY (SELECT MIN(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID)
ORDER BY 2 DESC, "Last Name";
