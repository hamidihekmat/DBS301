/* 1. Display last name and job id for all employees who perform the same job as Davies. Exclude Davies
from this query.
*/

SELECT LAST_NAME "Last Name", JOB_ID "Job ID" FROM EMPLOYEES WHERE JOB_ID = 
(SELECT JOB_ID FROM EMPLOYEES WHERE LAST_NAME = 'Davies') AND LAST_NAME != 'Davies';

