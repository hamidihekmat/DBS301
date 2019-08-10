-- ---------------------------------
/* 	DBS301 Assignment 2 - Summer 2019
    Authors: ["Hekmat Hamidi", "Jake Catering", "Daniel Emelianenko", "Nigel Chan"]
    This creation script is original work written by
    ["Hekmat Hamidi", "Jake Catering", "Daniel Emelianenko", "Nigel Chan"].
    No code in this file is copied from any other source 
    including any person, textbook, or on-line resource except those provided
    by the course instructor. We have not shared this file with anyone
    or anything except for submission for grading.  
    I understand that the Academic Honesty Policy will be enforced and violators 
    will be reported and appropriate action will be taken.'''
	*/

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80

SET PAGESIZE 100
SET ECHO OFF

Prompt ******  Dropping existing tables (IF THEY ARE THERE) ....

drop trigger checkOwnership;
Drop table advertisement;
drop table condo;
drop table house;
drop table referral;
drop table ownership;
drop table clienttrans;
drop table transactions;
drop table property;
drop table area;
drop table school;
DROP TABLE schoolType;
drop table salesrepresentative;
DROP TABLE country;
DROP TABLE province;
drop table adtypes;
DROP TABLE transactionType;
DROP TABLE clientType;
DROP TABLE propertyType;
DROP TABLE advertisingOutlets;
drop table person;
DROP TABLE contactType;
DROP TABLE agency;

    
Prompt ******  Creating countries table ....

-- Create countries Table (countries table aready exist in database)

CREATE TABLE country
(
    countryid integer,
    countryname varchar2(30),
    CONSTRAINT country_pkey PRIMARY KEY (countryid)
);

-- Insert player Records
-- Prompt ******  Inserting country Records table ....
-- SET ECHO OFF
-- INSERT INTO country VALUES (1,'Canada');


Prompt ******  Creating provinces table ....

-- Create province Table

CREATE TABLE province
(
    provinceid integer,
    provincename varchar2(30),
    countryid integer,
    CONSTRAINT province_pkey PRIMARY KEY (provinceid)
);

-- Insert province Records
-- Prompt ******  Inserting province Records table ....
-- SET ECHO OFF
-- INSERT INTO province VALUES (1,'Ontario',1);



Prompt ******  Creating area table ....

-- Create area Table

CREATE TABLE area
(
    areaid integer,
    areaname varchar2(30),
    generalcomments varchar2(100),
    schoolid int,
    CONSTRAINT area_pkey PRIMARY KEY (areaid)
);


-- Insert area Records
-- Prompt ******  Inserting area Records table ....
-- SET ECHO OFF
-- INSERT INTO area VALUES (1,'Yorkland', 'quiet neighbourhood','1');


Prompt ******  Creating school table ....

-- Create school Table

CREATE TABLE school
(
    schoolid integer,
    schoolname varchar2(50),
    schooltypeid int,
    CONSTRAINT school_pkey PRIMARY KEY (schoolid)
);


-- Insert school Records
-- Prompt ******  Inserting school Records table ....
-- SET ECHO OFF
-- INSERT INTO school VALUES (1,'Seneca College',1);

Prompt ******  Creating schooltype table ....

-- Create schooltype Table

CREATE TABLE schooltype
(
    schooltypeid integer,
    typename varchar2(50),
    CONSTRAINT schooltype_pkey PRIMARY KEY (schooltypeid)
);


-- Insert schooltype Records
-- Prompt ******  Inserting schooltype Records table ....
-- SET ECHO OFF
-- INSERT INTO schooltype VALUES (1,'College');



Prompt ******  Creating agency table ....

-- Create agency Table

CREATE TABLE agency
(
    agencyid integer,
    agencyname varchar2(50),
    phonenumber varchar2(11), -- 1 (888) 673-1234" -> "18886731234"
    CONSTRAINT agency_pkey PRIMARY KEY (agencyid)
);


-- Insert agency Records
-- Prompt ******  Inserting agency Records table ....
-- SET ECHO OFF
-- INSERT INTO agency VALUES (1,'House For cheap', '18886731234');


Prompt ******  Creating salesrepresentitive table ....

-- Create salesrepresentitive Table

CREATE TABLE salesrepresentative
(
    agentid integer,
    agencyid integer,
    CONSTRAINT salesrepresentative_pkey PRIMARY KEY (agentid)
);


-- Insert salesrepresentitive Records
-- Prompt ******  Inserting salesrepresentitive Records table ....
-- SET ECHO OFF
-- INSERT INTO salesrepresentitive VALUES (1,2);


Prompt ******  Creating transactions table ....

-- Create transactions Table

CREATE TABLE transactions
(
    transactionid integer,
    transactiondate date,
    sellingprice DOUBLE PRECISION,
    propertyid int,
    buyeragentid int,
    selleragentid int,
    CONSTRAINT transactions_pkey PRIMARY KEY (transactionid)
);

-- Insert transactions Records
-- Prompt ******  Inserting transactions Records table ....
-- SET ECHO OFF
-- INSERT INTO transactions VALUES (1,TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'),87888.00,1,1,1);

Create table TransactionType
(
    typeID int primary key,
    description varchar2(10)
);

-- This Table must have records before inserting into the transaction table.
-- insert into transactiontype values (1, 'Buying')

create table person (
    personID int primary key,
    firstName varchar2(20) not null,
    lastName varchar2(20) not null,
    email varchar2(70),
    contactNumber varchar2(20) not null,
    contactNumberType int
);

-- Before inserting into this table, make sure you have records inside the contactNumberType table
-- insert into person values(1, Jake, Carating, jakecarating@gmail.com, 6479729543, 1);
create table ContactType(
    contactTypeID int primary key,
    typeName varchar2(20)
);
    
create table ClientType(
    clientTypeID int primary key,
    description varchar2(20)
);

create table clientTrans(
    TransactionID int,
    clientID int,
    typeID int,
    constraint clientTrans_PK primary key(transactionID, clientID));
    
create table ownership(
    ownershipID number primary key,
    clientID number,
    ownershipPercentage double precision check(ownershipPercentage <= 1.00 and ownershipPercentage >= 0.00),
    propertyID number,
    clientTypeID number
);

create table referral(
    referralID number primary key,
    referralCashFee double precision not null,
    personID number
);
    
create table property(
    propertyID number primary key,
    numOfBedrooms number not null,
    numOfBathrooms number not null,
    squareArea number not null,
    listingPrice double precision not null,
    streetName varchar2(40) not null,
    postalCode varchar2(10) not null,
    city varchar2(25) not null,
    agencyID number ,
    areaID number,
    provinceID number,
    countryID number,
    outletID number,
    Percentage double precision default 1.00 not null
);

create table PropertyType(
    propertyTypeID number primary key,
    typeName varchar2(15)
);

create table House(
    houseID number primary key,
    parkingSpaces number,
    garage char(1) not null check(upper(garage) like 'Y' or upper(garage) like 'N'),
    lotSize number   
);


create table condo(
    condoID number primary key,
    unit number not null,
    maintenenceFee number not null
);

create table advertisement(
    adID number primary key,
    datePlaced date not null,
    costFee double precision not null,
    adTypeID number,
    outletID number,
    propertyID number
);

create table adTypes (
    adTypeID number primary key,
    nameType varchar(15)
);

create table AdvertisingOutlets(
    outletID number primary key,
    outletName varchar2(50),
    phoneNumber varchar2(20)
);


-- Adding Constraints:
-- DROP TABLE countries;
-- DROP TABLE provinces;
-- DROP TABLE area;
alter table area
add constraint schoolID_FK
foreign key (schoolID)
references School(schoolID);
-- DROP TABLE school;
alter table school
add constraint schoolTypeID_FK
foreign key (schoolTypeID)
references schoolType(schoolTypeID);
-- DROP TABLE schoolType;
-- DROP TABLE agency;
-- DROP TABLE salesRepresentitive;
alter table salesrepresentative
add constraint agentID_FK
foreign key (agentID)
references person(PersonID);
--DROP TABLE transactions;  <----
alter table transactions 
add constraint propertyID_FK
foreign key (propertyID)
references property(propertyID)
add constraint buyerAgentID_FK
foreign key (buyerAgentID)
references salesrepresentative(agentID)
add constraint sellerAgentID_FK
foreign key (sellerAgentID)
references salesrepresentative(agentID);

-- DROP TABLE transactionType;
-- DROP TABLE person;
alter table Person
add constraint ContactTypeID_FK
foreign key (contactNumberType)
references ContactType(ContactTypeID);
-- DROP TABLE contactType;
-- DROP TABLE clientType; <----
alter table clientTrans   
add constraint TransID_FK
foreign key (transactionID)
references transactions(transactionID)
add constraint clientID_FK
foreign key (clientID)
references person(personID);
-- DROP TABLE clientTrans;


-- DROP TABLE ownsership;  
alter table ownership
add constraint client_FK
foreign key (clientID)
references person(personID)
add constraint property_FK
foreign key (propertyID)
references property(propertyID)
add constraint clientType_FK
foreign key (clientTypeID)
references clientType(clientTypeID);

-- DROP TABLE referral;
alter table referral 
add constraint referralID_FK
foreign key (referralID)
references transactions(transactionID)
add constraint personID_FK
foreign key (personID)
references person(personID);

-- DROP TABLE property;

alter table property
add constraint agencyID_FK
foreign key (agencyID)
references agency(agencyID)
add constraint areaID_FK
foreign key (areaID)
references area(areaID)
add constraint province_FK
foreign key (provinceid)
references Province(provinceID)
add constraint countryID_FK
foreign key (countryID)
references country(countryID)
add constraint outletID_FK
foreign key (outletID)
references AdvertisingOutlets(outletID);
-- DROP TABLE propertyType;
-- DROP TABLE house;
alter table house
add constraint houseID_FK
foreign key (houseID)
references property(propertyID);
-- DROP TABLE condo;

alter table condo
add constraint condoID_FK
foreign key (condoID)
references property(propertyID);
--DROP TABLE advertisement;

alter table advertisement
add constraint adTypeID_FK00
foreign key (adtypeid)
references adtypes(adTypeID)
add constraint outletID_FK00
foreign key (outletID)
references advertisingoutlets(outletID)
add constraint property_FK00
foreign key (propertyID)
references property(propertyID);
--DROP TABLE adType;


--DROP TABLE advertisingOutlets;


-- Permissions:
grant all on advertisement to dbs301_192e08;
grant all on condo to dbs301_192e08;
grant all on house to dbs301_192e08;
grant all on referral to dbs301_192e08;
grant all on ownership to dbs301_192e08;
grant all on clienttrans to dbs301_192e08;
grant all on transactions to dbs301_192e08;
grant all on property to dbs301_192e08;
grant all on area to dbs301_192e08;
grant all on school to dbs301_192e08;
grant all on schoolType to dbs301_192e08;
grant all on salesRepresentitive to dbs301_192e08;
grant all on country to dbs301_192e08;
grant all on province to dbs301_192e08;
grant all on adtypes to dbs301_192e08;
grant all on transactionType to dbs301_192e08;
grant all on clientType to dbs301_192e08;
grant all on propertyType to dbs301_192e08;
grant all on advertisingOutlets to dbs301_192e08;
grant all on person to dbs301_192e08;
grant all on contactType to dbs301_192e08;
grant all on agency to dbs301_192e08;

grant all on advertisement to dbs301_192e07;
grant all on condo to dbs301_192e07;
grant all on house to dbs301_192e07;
grant all on referral to dbs301_192e07;
grant all on ownership to dbs301_192e07;
grant all on clienttrans to dbs301_192e07;
grant all on transactions to dbs301_192e07;
grant all on property to dbs301_192e07;
grant all on area to dbs301_192e07;
grant all on school to dbs301_192e07;
grant all on schoolType to dbs301_192e07;
grant all on salesRepresentitive to dbs301_192e07;
grant all on country to dbs301_192e07;
grant all on province to dbs301_192e07;
grant all on adtypes to dbs301_192e07;
grant all on transactionType to dbs301_192e07;
grant all on clientType to dbs301_192e07;
grant all on propertyType to dbs301_192e07;
grant all on advertisingOutlets to dbs301_192e07;
grant all on person to dbs301_192e07;
grant all on contactType to dbs301_192e07;
grant all on agency to dbs301_192e07;

grant all on advertisement to dbs301_192e12;
grant all on condo to dbs301_192e12;
grant all on house to dbs301_192e12;
grant all on referral to dbs301_192e12;
grant all on ownership to dbs301_192e12;
grant all on clienttrans to dbs301_192e12;
grant all on transactions to dbs301_192e12;
grant all on property to dbs301_192e12;
grant all on area to dbs301_192e12;
grant all on school to dbs301_192e12;
grant all on schoolType to dbs301_192e12;
grant all on salesRepresentitive to dbs301_192e12;
grant all on country to dbs301_192e12;
grant all on province to dbs301_192e12;
grant all on adtypes to dbs301_192e12;
grant all on transactionType to dbs301_192e12;
grant all on clientType to dbs301_192e12;
grant all on propertyType to dbs301_192e12;
grant all on advertisingOutlets to dbs301_192e12;
grant all on person to dbs301_192e12;
grant all on contactType to dbs301_192e12;
grant all on agency to dbs301_192e12;

grant all on advertisement to dbs301_192e09;
grant all on condo to dbs301_192e09;
grant all on house to dbs301_192e09;
grant all on referral to dbs301_192e09;
grant all on ownership to dbs301_192e09;
grant all on clienttrans to dbs301_192e09;
grant all on transactions to dbs301_192e09;
grant all on property to dbs301_192e09;
grant all on area to dbs301_192e09;
grant all on school to dbs301_192e09;
grant all on schoolType to dbs301_192e09;
grant all on salesRepresentitive to dbs301_192e09;
grant all on country to dbs301_192e09;
grant all on province to dbs301_192e09;
grant all on adtypes to dbs301_192e09;
grant all on transactionType to dbs301_192e09;
grant all on clientType to dbs301_192e09;
grant all on propertyType to dbs301_192e09;
grant all on advertisingOutlets to dbs301_192e09;
grant all on person to dbs301_192e09;
grant all on contactType to dbs301_192e09;
grant all on agency to dbs301_192e09;

revoke all on advertisement from public;
revoke all on condo from public;
revoke all on house from public;
revoke all on referral from public;
revoke all on ownership from public;
revoke all on clienttrans from public;
revoke all on transactions from public;
revoke all on property from public;
revoke all on area from public;
revoke all on school from public;
revoke all on schoolType from public;
revoke all on salesRepresentitive from public;
revoke all on country from public;
revoke all on province from public;
revoke all on adtypes from public;
revoke all on transactionType from public;
revoke all on clientType from public;
revoke all on propertyType from public;
revoke all on advertisingOutlets from public;
revoke all on person from public;
revoke all on contactType from public;
revoke all on agency from public;

commit;
/*
Drop table advertisement;
drop table condo;
drop table house;
drop table referral;
drop table ownership;
drop table clienttrans;
drop table transactions;
drop table property;
drop table area;
drop table school;
DROP TABLE schoolType;
drop table salesRepresentitive;
DROP TABLE country;
DROP TABLE province;
drop table adtypes;
DROP TABLE transactionType;
DROP TABLE clientType;
DROP TABLE propertyType;
DROP TABLE advertisingOutlets;
drop table person;
DROP TABLE contactType;
DROP TABLE agency;*/


Prompt ******  Creating checkownership trigger ....

/* Trigger to check ownsership */
create or replace trigger checkOwnership
  before insert or update on ownership
  for each row 
when(new.ownershipPercentage <> 1.00 and (new.ownershipPercentage < 1.00 and new.ownershipPercentage > 0.00))
declare
    propertyPercentage double precision;
    typeCL int;
    diff_per double precision;
    tempID int;
begin
    select percentage into propertyPercentage from property
    where propertyid = :new.propertyid;
    
    select propertyid INTO tempID from property  
    where propertyid = :new.propertyid;
  
   -- select clientTypeID from ownership into typeCL;
    diff_per := (propertyPercentage - :new.ownershipPercentage);
    update property
    set percentage = diff_per
    where propertyid = tempID;
    if( propertyPercentage = 0)
        THEN
            RAISE_APPLICATION_ERROR( -20001, 
                    'This property is already bought!' );
    end if;
END;

