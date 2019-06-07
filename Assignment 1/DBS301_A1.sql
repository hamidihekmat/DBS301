/* 1. Display the employee number, full employee name, job and hire date of all
employees hired in May or November of any year, with the most recently
hired employees displayed first. Also, exclude people hired in 1994 and
1995. Full name should be in the form Lastname, Firstname with an alias
called Full Name.
Hire date should point to the last day in May or November of that year (NOT
to the exact day) and be in the form like shown below with the heading Start
Date. Do NOT use LIKE operator.
You should display ONE row per output line by limiting the width of the
Full Name to 25 characters. The output lines should look like this line:

174 Abel, Ellen SA_REP [May 31st of 1996] 
*/


SELECT EMPLOYEE_ID "ID", SUBSTR((LAST_NAME || ', ' || FIRST_NAME), 1, 25) "Full Name", JOB_ID "Job", '[' || TO_CHAR(HIRE_DATE, 'FMMONTH') || ' ' || TO_CHAR(LAST_DAY(HIRE_DATE), 'DDth') || ' of ' || 
TO_CHAR(HIRE_DATE, 'YYYY') || ']' "Start Date"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'MM') = '05' OR TO_CHAR(HIRE_DATE, 'MM') = '11'
AND TO_CHAR(HIRE_DATE, 'YYYY') NOT IN ('1994','1995')
ORDER BY 4 DESC

