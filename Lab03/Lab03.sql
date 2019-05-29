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
ORDER BY MAX(SALARY) DESC;

/* 3. Display how many people work the same job in the same department. Name these results Dept#, Job
and HowMany. Include only jobs that involve more than one person.
Sort the output so that jobs with the most people involved are shown first. */


SELECT DEPARTMENT_ID "Dept#" , COUNT(T1.JOB_ID) "HowMany"
FROM JOBS T1 INNER JOIN EMPLOYEES T2 ON T1.JOB_ID = T2.JOB_ID
GROUP BY DEPARTMENT_ID HAVING COUNT(T1.JOB_ID) > 1
ORDER BY "HowMany" desc;






/* 4. For each job id display the job id and total amount paid each month for this type of the job. Exclude
job_id AD_PRES and AD_VP and also include only jobs that require more than $15,000 in total.
Sort the output so that top paid jobs are shown first. */


SELECT JOB_ID "Job#", SALARY "Salary" FROM EMPLOYEES
WHERE JOB_ID NOT IN ('AD_RES','AD_VP')
AND SALARY > 15000; 

/* 5. For each manager number display how many persons he / she supervises. Exclude managers with
numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.
Sort the output so that manager numbers with the most supervised persons are shown first.
 */
 
 
 SELECT COUNT(EMPLOYEE_ID) "Supervises" FROM EMPLOYEES
 WHERE EMPLOYEE_ID NOT IN ('100','101','102')
 GROUP BY MANAGER_ID HAVING count(EMPLOYEE_ID) >= 2
 ORDER BY "Supervises" DESC;

