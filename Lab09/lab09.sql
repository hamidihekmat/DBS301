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





