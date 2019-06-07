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

/* 2. List the employee number, full name, job and the modified salary for all
employees whose monthly earning (without this increase) is outside the
range $6,000  $11,000 and who are employed as Vice Presidents or
Managers (President is not counted here).
You should use Wild Card characters for this.
VPs will get 30% and managers 20% salary increase.
Sort the output by the top salaries (before this increase) firstly.
Heading will be like Employees with increased Pay
The output lines should look like this sample line:
Emp# 124 : Kevin Mourgos is ST_MAN and will get a new salary of $6,960
*/

SELECT 'Emp# ' || EMPLOYEE_ID || ' : '  || FIRST_NAME || ' ' || LAST_NAME  || ' is ' || JOB_ID || ' and will get a new salary of $'  || 
CASE WHEN JOB_ID LIKE '%MAN' THEN SALARY * 1.2 
WHEN JOB_ID LIKE '%VP' THEN SALARY * 1.3
WHEN JOB_ID LIKE '%MGR' THEN SALARY * 1.2 END "Employees with increased Pay" 
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 6000 AND 11000 AND JOB_ID LIKE '%MAN' OR JOB_ID LIKE '%VP' OR JOB_ID LIKE '%MGR'
ORDER BY SALARY DESC;

/* 3. Display the employee last name, salary, job title and manager# of all
employees not earning a commission OR if they work in SALES
department, but only if their total monthly salary with $1000 included bonus
and commission (if earned) is greater than $15,000. 
Lets assume that all employees receive this bonus.
If an employee does not have a manager, then display the word NONE
instead. This column should have an alias Manager#.
Display the Total annual salary as well in the form of $135,600.00 with the
heading Total Income. Sort the result so that best paid employees are shown
first. The output lines should look like this sample line:
 De Haan 17000 AD_VP 100 $216,000.0
*/


SELECT T1.LAST_NAME "Last Name", T1.SALARY "Salary", T1.JOB_ID "ID", T1.MANAGER_ID || 
CASE WHEN T1.MANAGER_ID IS NULL THEN 'None' END "Manager #", (((T1.SALARY + 1000) * 12) + (1 * NVL(T1.COMMISSION_PCT,0))) "Total Income" FROM EMPLOYEES T1 
INNER JOIN EMPLOYEES T2 ON T1.MANAGER_ID = T2.EMPLOYEE_ID
WHERE T1.COMMISSION_PCT IS NULL OR T1.JOB_ID LIKE 'SA%' AND ((T1.SALARY + 1000) +  (1 * NVL(T1.COMMISSION_PCT,0))) > 15000;
