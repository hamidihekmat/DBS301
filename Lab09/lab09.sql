SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, COMMISSION_PCT FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;



/* Create L09SalesRep Table For Employees (Dep#80) */

CREATE TABLE L09SalesRep (RepId NUMBER(6),
                        FName VARCHAR2(20), 
                        LName VARCHAR2(20), 
                        Phone# VARCHAR2(20),
                        Salary NUMBER(8,2),
                        Commission NUMBER(2,2));
                        
                        
/*  Insert into the table L09SalesRep */

INSERT INTO L09SalesRep (RepId, FName, LName, Phone#, Salary, Commission) (
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, COMMISSION_PCT FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80);

/* Check if data inserted */

SELECT * FROM L09SalesRep;
                        
/*  
 Results:

 3 rows inserted.


     REPID FNAME                LNAME                PHONE#                   SALARY COMMISSION
---------- -------------------- -------------------- -------------------- ---------- ----------
       149 Eleni                Zlotkey              011.44.1344.429018        10500         .2
       174 Ellen                Abel                 011.44.1644.429267        11000         .3
       176 Jonathon             Taylor               011.44.1644.429265         8600         .2
 
 */



 /* 2. Create L09Cust table. */

CREATE TABLE L09Cust (
   CUST#	  	NUMBER(6),
   CUSTNAME 	VARCHAR2(30),
   CITY 		VARCHAR2(20),
   RATING		CHAR(1),
   COMMENTS	VARCHAR2(200),
   SALESREP#	NUMBER(7) );



INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
501, 
'ABC LTD.', 
'Montreal', 
'C', 
201);


INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
502, 
'Black Giant', 
'Ottawa', 
'B', 
202);
/*--------------- */

INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
503, 
'Mother Goose', 
'London', 
'B', 
202);

INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
701, 
'BLUE SKY LTD', 
'Vancouver', 
'B', 
102); 

INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
702, 
'MIKE and SAM Inc.', 
'Kingston', 
'A', 
107);

INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
703, 
'RED PLANET', 
'Mississauga', 
'C', 
107);

INSERT INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES (
717, 
'BLUE SKY LTD', 
'Regina', 
'D', 
102);


/* Check if values inserted */

SELECT * FROM L09Cust;


/* 3. Create table L09GoodCust by using following columns but only if their rating is A or B. 
Column          	Type    	    
CustId		NUMBER	(6)	
Name		VARCHAR2(30)    
Location		VARCHAR2(20)     🡪 ALL these columns’ data types match ones
RepId		NUMBER(7)    	   in table L09Cust
*/

CREATE TABLE L09GoodCust (
   CustId NUMBER(6),
   Name VARCHAR2(30),
   Location VARCHAR2(20),
   RepId NUMBER(7));   
   
/* Insert Data into Tables */

INSERT INTO L09GoodCust VALUES (
502,
'Black Giant',
'Ottawa',
202);

INSERT INTO L09GoodCust VALUES (
503,
'Mother Goose',
'London',
202);

INSERT INTO L09GoodCust VALUES (
504,
'BLUE SKY LTD',
'Vancouver',
202);

INSERT INTO L09GoodCust VALUES (
701,
'MIKE and SAM inc.',
'Kingston',
10);



/* Check the if inserted */
SELECT * FROM L09GoodCust;


/* 4.  Now add new column to table L09SalesRep called JobCode that will be of variable character type with max length of 12.
Do a DESCRIBE L09SalesRep to ensure it executed */

ALTER TABLE L09SalesRep
ADD (JobCode VARCHAR2(12));


/* Check altered table */

DESC L09SalesRep;

/*
RESULTS
REPID            NUMBER(6)
FNAME            VARCHAR2(20)
LNAME            VARCHAR2(20)
PHONE#           VARCHAR2(20)
SALARY           NUMBER(8,2)
COMMISSION       NUMBER(2,2)
JOBCODE          VARCHAR2(12)
*/


/*
5.	Lengthen FNAME in L09SalesRep to 37. The result of a DESCRIBE should show it happening
*/

DESCRIBE L09SalesRep;

/* Leghten FNAME */

ALTER TABLE L09SalesRep
MODIFY FNAME VARCHAR2(37);

/* Check altered table */
DESCRIBE L09SalesRep;


/* You can only decrease the size or length of Name in L09GoodCust to the maximum length of data already stored.
Do it by using SQL and not by looking at each entry and counting the characters. May take two SQL statements
*/

SELECT MAX(LENGTH(FNAME)) FROM L09SalesREp;

ALTER TABLE L09SalesRep
MODIFY FNAME VARCHAR2(8);


/* Now get rid of the column JobCode in table L09SalesRep in a way that will not affect daily performance. */

ALTER TABLE L09SalesRep
DROP COLUMN JobCode CHECKPOINT 250;

/* Check dropped column */

DESC L09SalesRep;
