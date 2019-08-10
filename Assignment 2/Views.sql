--How much Referral Fee was given on Jan 26 2019 and to whom?
create view ReferralFee as
select  p.firstname||' '||p.lastname as Name ,referralcashfee as "Referral Fee"from referral r
join transactions t on (r.referralid = t.transactionid) join person p on (r.personid = p.personid)
where t.transactiondate = to_date('26-Jan-19','DD-Mon-YY');

select* from referralfee;
drop view referralfee;

--How many clients made a perchase from John Wicke?
create view NumofClients as
    select Distinct(firstname), lastname from person p 
    left join clienttrans ct on(p.personID = ct.clientID)
    where ct.TypeID = 1
    order by firstname;

SELECT * FROM NumofClients;
drop view NumofClients

-- Show the  transactions that was made starting in 2020?

CREATE VIEW TransNewYear AS
(SELECT * 
FROM TRANSACTIONS
WHERE EXTRACT(YEAR FROM TO_DATE(TRANSACTIONDATE, 'DD-MON-YY')) > 2019);

SELECT * FROM TransNewYear;

drop view TransNewYear;


-- How many properties were sold between this year and that year?
create view NumofPropSold as
SELECT  * FROM TRANSACTIONS
    WHERE EXTRACT(YEAR FROM TO_DATE(TRANSACTIONDATE, 'DD-MON-YY')) BETWEEN 2018 AND 2020
    ORDER BY TRANSACTIONDATE;

select * from NumofPropSold;
drop view NumofPropSold;