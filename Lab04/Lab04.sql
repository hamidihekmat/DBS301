/* 1. Display the department name, city, street address and postal code for all
 departments. Use the JOIN and USING form of syntax.
 Sort the output by department name descending. */
 
 
 SELECT DEPARTMENT_NAME "Department Name", CITY "City", STREET_ADDRESS "Street Adress", POSTAL_CODE "Postal Code"
 FROM DEPARTMENTS JOIN LOCATIONS USING (LOCATION_ID)
 ORDER BY 1 DESC;
