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
