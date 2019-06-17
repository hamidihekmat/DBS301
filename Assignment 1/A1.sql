Jake Carating: 157 725 177									
Hekmat Hamidi: 132 645 169
Daniel Emelianenko: 100 840 172

ASSIGNMENT 1 - DBS301 - SEE
 ,_

/* 1. Display the employee number, employee name, job and hire date of all
employees hired in May or November of any year, with the most recently
hired employees displayed first. Also, exclude people hired in 1994 and
1995. Full name should be in the form Lastname, First Name with an alias
called Full Name.
Hire date should point to the last day in May or November of that year (NOT
to the exact day) and be in the form like shown below with the heading Start
Date. Do NOT use LIKE operator.
You should display ONE row per output line by limiting the width of the
Full Name to 25 characters. The output lines should look like this line:
174 Abel, Ellen SA_REP [May 31st of 1996] 
*/

SELECT SUBSTR(EMPLOYEE_ID,1,3) "ID", SUBSTR((LAST_NAME || ', ' || FIRST_NAME), 1, 25) "Full Name", 
JOB_ID "Job", '[' || TO_CHAR(HIRE_DATE, 'FMMONTH') || ' ' || TO_CHAR(LAST_DAY(HIRE_DATE), 'DDth') || ' of ' || 
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
CASE WHEN JOB_ID LIKE '%MAN' THEN TO_CHAR(SALARY * 1.2, '$99,999') 
  WHEN JOB_ID LIKE '%VP' THEN TO_CHAR(SALARY * 1.3, '$99,999')
  WHEN JOB_ID LIKE '%MGR' THEN TO_CHAR(SALARY * 1.2, '$99,999') END "Employees with increased Pay" 
    FROM EMPLOYEES
  WHERE SALARY NOT BETWEEN 6000 AND 11000 AND JOB_ID LIKE '%MAN' OR JOB_ID LIKE '%VP' OR JOB_ID LIKE '%MGR'
ORDER BY SALARY DESC;





/* 3. Display the employee last name, salary, job title and manager# of all
employees not earning a commission OR if they work in SALES
department, but only if their total monthly salary with $1000 included bonus
and commission (if earned) is greater than $15,000. 
Let's assume that all employees receive this bonus.
If an employee does not have a manager, then display the word NONE
instead. This column should have an alias Manager#.
Display the Total annual salary as well in the form of $135,600.00 with the
heading Total Income. Sort the result so that best paid employees are shown
first. The output lines should look like this sample line:
 De Haan 17000 AD_VP 100 $216,000.0
*/


SELECT T2.LAST_NAME, T2.SALARY "Salary", T2.JOB_ID "ID", T2.MANAGER_ID || CASE WHEN T2.MANAGER_ID IS NULL THEN 'NONE' END "Manager#", 
TO_CHAR(((T2.SALARY + 1000) * 12) * (1 + NVL(T2.COMMISSION_PCT,0)),'$999,999.99') "Total Income" FROM EMPLOYEES T1
 RIGHT JOIN EMPLOYEES T2 ON T1.EMPLOYEE_ID = T2.MANAGER_ID
WHERE (T2.COMMISSION_PCT IS NULL OR T2.DEPARTMENT_ID = 80) AND (((T2.SALARY + 1000)) * (1 + NVL(T2.COMMISSION_PCT,0))) > 15000
ORDER BY "Salary" DESC;





/* 4. Display Department_id, Job_id and the Lowest salary for this combination
under the alias Lowest Dept/Job Pay, but only if that Lowest Pay falls in the
range $6000 - $18000.
Exclude people who work as some kind of Representative job from this
query and departments IT and SALES as well.
 Sort the output according to the Department_id and then by Job_id.
 You MUST NOT use the Subquery method.
 */

SELECT DEPARTMENT_ID || ' ' ||  JOB_ID || ' ' || MIN(SALARY) "Lowest Dept/Job Pay" FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID HAVING MIN(SALARY) BETWEEN 6000 AND 18000 AND
JOB_ID NOT LIKE '%REP' AND DEPARTMENT_ID NOT IN ('60','80')
ORDER BY DEPARTMENT_ID, JOB_ID;





/* 5. Display last_name, salary and job for all employees who earn more
than all lowest paid employees per department outside the US locations.
 Exclude President and Vice Presidents from this query.
 Sort the output by job title ascending.
 You need to use a Subquery
 */
 
SELECT LAST_NAME, SALARY, JOB_TITLE FROM EMPLOYEES
    JOIN JOBS USING (JOB_ID)
    WHERE SALARY > ANY (SELECT MIN(SALARY) FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID 
    HAVING DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID IN 
    (SELECT LOCATION_ID FROM LOCATIONS WHERE COUNTRY_ID != 'US')))
    AND JOB_ID NOT IN ('AD_PRES','AD_VP')
ORDER BY JOB_TITLE;



/* 6. Who are the employees (show last_name, salary and job) who work either in
IT or MARKETING department and earn more than the worst paid person in
the ACCOUNTING department.
Sort the output by the last name alphabetically.
You need to use ONLY the Subquery method (NO joins allowed).
*/

SELECT LAST_NAME, SALARY, JOB_ID FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('IT','Marketing')) 
AND SALARY > (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Accounting'))
ORDER BY LAST_NAME;




/* 7. Display alphabetically the full name, job, salary  (formatted as a currency   amount incl. thousand separator, but no decimals) and department number  for each 
employee who earns less than the best paid unionized employees  (i.e. not the president nor any manager nor any VP),  and who work in either SALES or MARKETING department. 
Full name should be displayed as Firstname  Lastname and should have the heading Employee. Salary should be left-padded with the & symbol till the width of 10 characters. 
It should have an alias Salary.  You should display ONE row per output line by limiting the width of the   Employee to 25 characters. 
The output lines should look like this sample line: 
  Jonathon Taylor  SA_REP    &&&& $8,600  80 */

SELECT SUBSTR(FIRST_NAME || ' ' || LAST_NAME,1,25) "Employee", JOB_ID "Job",
LPAD(TO_CHAR(SALARY,'$99,900'),12,'&') "Salary", DEPARTMENT_ID FROM EMPLOYEES 
WHERE SALARY < ANY (SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID NOT IN ('AD_PRES','AD_VP','SA_MAN','ST_MAN','AC_MGR','MK_MAN'))
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Sales','Marketing'))
ORDER BY 1




/* Tricky One 
8. Display department name, city and number of different  jobs in each department. If city is null, you should print Not Assigned Yet.  This column should have alias City.           
Column that shows # of different jobs in a department should have the   heading # of Jobs You should display ONE row per output line by limiting the width of the   City to 25 characters. 
You need to show complete situation from the EMPLOYEE point of view,     meaning include also employees who work for NO department (but do NOT display empty departments)
and from the CITY point of view meaning you need to  display all cities without departments as well. 
You need to use Join method.  */

SELECT DEPARTMENT_NAME, SUBSTR(NVL(CITY,'Not Assigned Yet'),0,25) "City", COUNT(E.JOB_ID) "# of Jobs"
FROM DEPARTMENTS D
RIGHT JOIN EMPLOYEES E 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
FULL JOIN LOCATIONS L
ON L.LOCATION_ID = D.LOCATION_ID 
GROUP BY DEPARTMENT_NAME, SUBSTR(NVL(CITY,'Not Assigned Yet'),0,25)





