
DROP DATABASE IF EXISTS cafe_POS_v3;
CREATE DATABASE cafe_POS_v3;
USE cafe_POS_v3;

/*STAFF*/
DROP TABLE IF EXISTS STAFF;
CREATE TABLE STAFF(

    STA_ID VARCHAR(8),
    STA_FNAME VARCHAR(50),
    STA_LNAME VARCHAR(50),
    STA_PHONE VARCHAR(15),
    STA_DOB DATE,
    STA_SDATE DATE,
    STA_HOURLY_WAGE FLOAT(8),

    PRIMARY KEY(STA_ID)


);

INSERT INTO  STAFF VALUES('STA00001', 'Tom1', 'Kelly', '012345678901234', '1996-11-16', '2012-01-01', 5.5 );

SELECT 'STAFF TABLE' AS '';
SELECT * FROM STAFF;

/*ITEMS*/
DROP TABLE IF EXISTS ITEMS;
CREATE TABLE ITEMS(

    ITM_ID VARCHAR(8),
    ITM_NAME VARCHAR(50),
    ITM_DISC TEXT,
    ITM_PRICE FLOAT(8),
    ITM_AMOUNT INT,

    PRIMARY KEY(ITM_ID)

);
INSERT INTO ITEMS VALUES('ITEM0001', 'Can', 'Canned Drink', 1.0, 50);

SELECT 'ITEMS TABLE' AS '';
SELECT * FROM ITEMS;

/*FILLINGS*/
DROP TABLE IF EXISTS FILLINGS;
CREATE TABLE FILLINGS(

    FILL_ID VARCHAR(8),
    FILL_NAME VARCHAR(255),
    FILL_FILLING_DESC VARCHAR(255),

    PRIMARY KEY (FILL_ID)

);
INSERT INTO FILLINGS VALUES('FILL0001', 'TUNA', 'TUNA');

SELECT 'FILLINGS TABLE' AS '';
SELECT * FROM FILLINGS;

/*CATEGORY*/
DROP TABLE IF EXISTS CATEGORY;
CREATE TABLE CATEGORY(

    CAT_ID VARCHAR(8),
    CAT_NAME VARCHAR(50),
    CAT_TYPE VARCHAR(50),

    PRIMARY KEY(CAT_ID) 

);
INSERT INTO CATEGORY VALUES('CAT00001', 'Can', 'Drink');

SELECT 'CATEGORY TABLE' AS '';
SELECT * FROM CATEGORY;

/*TABLES*/
DROP TABLE IF EXISTS TABLES;
CREATE TABLE TABLES(

    TBL_ID VARCHAR(8),
    TBL_NAME VARCHAR(80),
    TBL_LOC VARCHAR(250),

    PRIMARY KEY(TBL_ID)

);
INSERT INTO TABLES VALUES('TBL00001', 'Window', 'Under the window');

SELECT 'TABLES TABLE' AS '';
SELECT * FROM TABLES;

/*Orders Table*/
DROP TABLE IF EXISTS ORDERS;
CREATE TABLE ORDERS(

    ORD_ID VARCHAR(8),
    ORD_TIME TIME,
    ORD_TBL_ID VARCHAR(8),
    ORD_KITCHEN_COMP BOOLEAN,
    ORD_FOH_COMP BOOLEAN,
    ORD_TOTAL FLOAT NOT NULL,

    PRIMARY KEY(ORD_ID),
    FOREIGN KEY(ORD_TBL_ID) REFERENCES TABLES(TBL_ID)

);

INSERT INTO ORDERS VALUES('ORD00001', '14:50:56', 'TBL00001', FALSE, FALSE, 11.75);

SELECT 'ORDERS TABLES' AS '';
SELECT * FROM ORDERS;

/*TRANSACTIONS*/
DROP TABLE IF EXISTS TRANSACTIONS;

CREATE TABLE TRANSACTIONS (

    T_ID VARCHAR(8),
    T_AMOUNT FLOAT(8),
    T_TIME TIME,
    T_DATE DATE,

    PRIMARY KEY (T_ID)

);

INSERT INTO TRANSACTIONS VALUES('T0000001', 3.50, '16:23:12', '2017-05-19');

SELECT 'TRANSACTIONS TABLE' AS '';
SELECT * FROM TRANSACTIONS;

/*TRANSACTIONS_ORDERS*/
DROP TABLE IF EXISTS TRANSACTION_ORDERS;

CREATE TABLE TRANSACTIONS_ORDERS (

    T_O_T_ID VARCHAR(8),
    T_O_ORD_ID VARCHAR(8),
    T_O_TYPE VARCHAR (8),

    PRIMARY KEY (T_O_T_ID, T_O_ORD_ID, T_O_TYPE),
    FOREIGN KEY (T_O_ORD_ID) REFERENCES ORDERS(ORD_ID),
    FOREIGN KEY (T_O_T_ID) REFERENCES TRANSACTIONS(T_ID)

);

INSERT INTO TRANSACTIONS_ORDERS VALUES('T0000001','ORD00001', 'A');
SELECT 'TRANSACTION_ORDERS TABLE' AS '';
SELECT * FROM TRANSACTIONS_ORDERS;

/*FILLINGS_ITEMS*/
DROP TABLE IF EXISTS FILLINGS_ITEMS;

CREATE TABLE FILLINGS_ITEMS(

    FI_FILL_ID VARCHAR(8),
    FI_ITM_ID VARCHAR(8),

    PRIMARY KEY(FI_FILL_ID, FI_ITM_ID),
    FOREIGN KEY (FI_FILL_ID) REFERENCES FILLINGS(FILL_ID),
    FOREIGN KEY(FI_ITM_ID) REFERENCES ITEMS(ITM_ID) 

);

INSERT INTO FILLINGS_ITEMS VALUES('FILL0001', 'ITEM0001');

SELECT 'FILLINGS_ITEMS TABLE' AS '';
SELECT * FROM FILLINGS_ITEMS;

/*ITEM_CATEGORY*/
DROP TABLE IF EXISTS ITEM_CATEGORY;

CREATE TABLE ITEM_CATEGORY(

    IC_ITM_ID VARCHAR(8),
    IC_CAT_ID VARCHAR(8),

    PRIMARY KEY (IC_CAT_ID, IC_ITM_ID),
    FOREIGN KEY(IC_ITM_ID) REFERENCES ITEMS(ITM_ID),
    FOREIGN KEY(IC_CAT_ID) REFERENCES CATEGORY(CAT_ID)

);
INSERT INTO ITEM_CATEGORY VALUES('ITEM0001', 'CAT00001');

SELECT 'ITEM_CATEGORY TABLE' AS'';
SELECT * FROM ITEM_CATEGORY;

/*ORDER_ITEMS*/
DROP TABLE IF EXISTS ORDER_ITEMS;

CREATE TABLE ORDER_ITEMS(

    OI_ID INT AUTO_INCREMENT, 
    OI_ORD_ID VARCHAR(8),
    OI_ITM_ID VARCHAR(8),
    OI_NOTES VARCHAR(255),
    OI_AMOUNT INT,

    PRIMARY KEY(OI_ID),
    FOREIGN KEY(OI_ORD_ID) REFERENCES ORDERS(ORD_ID),
    FOREIGN KEY(OI_ITM_ID) REFERENCES ITEMS(ITM_ID)
);
INSERT INTO ORDER_ITEMS VALUES(NULL, 'ORD00001', 'ITEM0001', 'NONE', 2);

SELECT 'ORDER_ITEMS' AS '';
SELECT * FROM ORDER_ITEMS;

/*ROLES*/
DROP TABLE IF EXISTS ROLES;

CREATE TABLE ROLES(

    ROLE_ID VARCHAR(8),
    ROLE_NAME VARCHAR(50),
    ROLE_DIS VARCHAR(1024),

    PRIMARY KEY(ROLE_ID)

);
INSERT INTO ROLES VALUES('ROLE0001', 'Barista', 'Makes Coffee and performs most tasks front of house');

SELECT 'ROLES TABLE' AS '';
SELECT * FROM ROLES;

/*STAFF_ROLES*/
DROP TABLE IF EXISTS STAFF_ROLES;

CREATE TABLE STAFF_ROLES(

    SR_STA_ID VARCHAR(8),
    SR_ROLE_ID VARCHAR(8),
    
    PRIMARY KEY(SR_STA_ID, SR_ROLE_ID),
    FOREIGN KEY(SR_STA_ID) REFERENCES STAFF(STA_ID),
    FOREIGN KEY(SR_ROLE_ID) REFERENCES ROLES(ROLE_ID)
    
);
INSERT INTO STAFF_ROLES VALUES('STA00001', 'ROLE0001');

SELECT 'STAFF_ROLES TABEL' AS '';
SELECT * FROM STAFF_ROLES;

/*TABS*/
CREATE TABLE TABS(

    TAB_ID VARCHAR(8),
    TAB_NAME VARCHAR(255),
    TAB_DATE_OPEND DATE,
    TAB_PAID BOOLEAN,

    PRIMARY KEY(TAB_ID)

);
INSERT INTO TABS VALUES('TAB00001', 'Art Group', '2017-07-20', FALSE);

SELECT 'TABS TABLE' AS '';
SELECT * FROM TABS;

/*ORDER_TABS*/
DROP TABLE IF EXISTS ORDER_TABS;

CREATE TABLE ORDERS_TABS(

    OT_TAB_ID VARCHAR(8),
    OT_ORD_ID VARCHAR(8),

    PRIMARY KEY (OT_ORD_ID, OT_TAB_ID),
    FOREIGN KEY (OT_ORD_ID) REFERENCES ORDERS(ORD_ID),
    FOREIGN KEY (OT_TAB_ID) REFERENCES TABS(TAB_ID)

);
INSERT INTO ORDERS_TABS VALUES('TAB00001', 'ORD00001');

SELECT 'ORDERS_TABS TABLE' AS '';
SELECT * FROM ORDERS_TABS;

DROP TABLE IF EXSISTS FILLINGS_ORDERS;

CREATE TABLE FILLINGS_ORDERS(

    FO_ORD_ID VARCHAR(8),
    FO_ITM_ID VARCHAR(8),
    FO_FILLING_ID VARCHAR(8),

    PRIMARY KEY (FO_ORD_ID, FO_ITM_ID, FO_FILLING_ID),
    FOREIGN KEY (FO_ORD_ID) REFERENCES ORDERS(ORD_ID),
    FOREIGN KEY (FO_ITM_ID) REFERENCES ITEMS(ITM_ID),
    FOREIGN KEY (FO_FILLING_ID) REFERENCES FILLINGS(FILL_ID)

);
INSERT INTO FILLINGS_ORDERS VALUES('ORD00001', 'ITEM0001', 'FILL0001');
SELECT * FROM FILLINGS_ORDERS;




