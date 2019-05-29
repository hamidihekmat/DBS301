/* 1. Write a query to display the tomorrows date. Your result will depend on the day when
you create this query. Label the column Tomorrow. */

SELECT (SYSDATE +1) "TOMORROW" FROM DUAL;

/* 2. For each employee in departments 20, 50 and 60 display last name, first name, salary,
and salary increased by 7% and expressed as a whole number. Label the column Good Salary.
Also add a column that subtracts the old salary from the new salary and multiplies by 12. Label
the column Annual Pay Increase. 
 */
 
SELECT LAST_NAME, FIRST_NAME, SALARY, (SALARY + (SALARY * 0.07)) "Good Salary", ((SALARY + (SALARY * 0.07)) - Salary) * 12 "Annual Pay Increased"
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN ('20','50','60');


/* 3. Write a query that displays the employees Full Name and Job Title in the following
format:
DAVIES, CURTIES is Store Clerk
for all employees whose last name ends with s and first name starts with C or K.
Give this column an appropriate label like Person and Job
Sort the result by the employees last names.
 */ 
 
 SELECT *  FROM EMPLOYEES;
 
 SELECT LAST_NAME || ', ' || FIRST_NAME || ' is ' || T2.JOB_TITLE "Person and Job"
 FROM EMPLOYEES T1
 INNER JOIN JOBS T2
 ON T1.JOB_ID = T2.JOB_ID
 WHERE LAST_NAME LIKE '%s'
 AND FIRST_NAME LIKE 'C%' OR FIRST_NAME LIKE 'K%'
 ORDER BY LAST_NAME;

/* 4. For each employee hired before 1992, display the employees last name, hire date and
calculate the number of YEARS between TODAY and the date the employee was hired. Label
the column Years worked.
Order your results by the number of years employed.
Round the number of years up to the closest whole number. (LAST_NAME. HIRE_DATE )
*/

SELECT LAST_NAME, HIRE_DATE, EXTRACT(YEAR FROM (SYSDATE - HIRE_DATE) YEAR TO MONTH) "Years worked"
FROM EMPLOYEES
WHERE HIRE_DATE < '01-JAN-92'
ORDER BY "Years worked" desc;

/* 5. Create a query that displays the city names, country codes and state province names, but
only for those cities that start on S and have at least 8 characters in their name. If city does not
have province name assigned, then put Unknown Province */



SELECT T2.CITY "City", T1.COUNTRY_ID "Country Code", STATE_PROVINCE  || CASE WHEN STATE_PROVINCE IS NULL THEN 'Unknown Province' END "Province"
FROM COUNTRIES T1
INNER JOIN LOCATIONS T2
ON T1.COUNTRY_ID = T2.COUNTRY_ID
WHERE T2.CITY LIKE 'S%' AND LENGTH(T2.CITY) >= 8;
