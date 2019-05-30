/* 1. Display the difference between the Average pay and Lowest pay in the company among employees.
Name this result Real Amount. */



SELECT (AVG(SALARY) - MIN(SALARY)) "Real Amount" FROM EMPLOYEES;


/* 2. Display the department number and Highest, Lowest and Average pay per each department. Name
these results High, Low and Avg.
Sort the output so that department with highest average salary are shown first */


SELECT T1.DEPARTMENT_ID "DEPARTMENT" , MAX(SALARY) "Highest" , MIN(SALARY) "Lowest" , ROUND(AVG(SALARY)) "Average" FROM EMPLOYEES T1
INNER JOIN DEPARTMENTS T2
ON T1.DEPARTMENT_ID = T2.DEPARTMENT_ID
GROUP BY T1.DEPARTMENT_ID
ORDER BY "Average" DESC;

/* 3. Display how many people work the same job in the same department. Name these results Dept#, Job
and HowMany. Include only jobs that involve more than one person.
Sort the output so that jobs with the most people involved are shown first. */


SELECT DEPARTMENT_ID "Dept#" , T1.JOB_ID "Job",  COUNT(T1.JOB_ID) "HowMany"
FROM JOBS T1 INNER JOIN EMPLOYEES T2 ON T1.JOB_ID = T2.JOB_ID
GROUP BY DEPARTMENT_ID, T1.JOB_ID HAVING COUNT(T1.JOB_ID) > 1
ORDER BY "HowMany" desc;






/* 4. For each job id display the job id and total amount paid each month for this type of the job. Exclude
job_id AD_PRES and AD_VP and also include only jobs that require more than $15,000 in total.
Sort the output so that top paid jobs are shown first. */


SELECT JOB_ID "Job#", SUM(SALARY) "Salary" FROM EMPLOYEES
GROUP BY JOB_ID HAVING SUM(SALARY) > 15000 AND JOB_ID NOT IN ('AD_PRES','AD_VP')
ORDER BY SUM(SALARY) DESC;

/* 5. For each manager number display how many persons he / she supervises. Exclude managers with
numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.
Sort the output so that manager numbers with the most supervised persons are shown first.
 */
 
 
 SELECT COUNT(EMPLOYEE_ID) "Supervises" FROM EMPLOYEES
 WHERE EMPLOYEE_ID NOT IN ('100','101','102')
 GROUP BY MANAGER_ID HAVING count(EMPLOYEE_ID) >= 2
 ORDER BY "Supervises" DESC;

/* 6. For each department show the latest and earliest hire date, but exclude departments 10
and 20 and also exclude those departments where the last person was hired in this century. Sort the
output so that most recent latest hire dates are shown first. */


SELECT MAX(HIRE_DATE) "Latest", MIN(HIRE_DATE) "Earliest" FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING TO_CHAR(MAX(HIRE_DATE), 'YYYY') < 2000
AND DEPARTMENT_ID NOT IN ('10','20')
ORDER BY 1 DESC;
