 
-- Luigi Ekene Dimude
-- C0799030
-- CSD2206 Term Project
-- Term 1
-- Jim Cooper, Professor


-- ONTAKE CORPORATION ---------------


-- DROP TABLES ---------------

DROP TABLE on_products;
DROP TABLE on_customers;
DROP TABLE on_orders;
DROP TABLE on_order_details;
DROP TABLE on_warehouses;
DROP TABLE on_brands;
DROP TABLE on_models;
DROP TABLE on_inventories;
DROP TABLE on_electrical_ratings;
DROP TABLE on_colors;
DROP TABLE on_associates;
DROP TABLE on_zips;
DROP TABLE on_taxes;
DROP TABLE on_prefectures;


-- CREATE TABLES ---------------

CREATE TABLE on_products (
    product_id              INTEGER NOT NULL,
    model_id                INTEGER NOT NULL, 
    color_id                INTEGER NOT NULL,
    electrical_rating_id    INTEGER NOT NULL,
    stock_keeping_unit      VARCHAR (20),
    product_code            VARCHAR (20) NOT NULL       
);

CREATE TABLE on_customers (
    customer_id       INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY
    (START WITH 101 INCREMENT BY 1), -- customer_id is an Identity auto generated column 
    first_name        VARCHAR (30) NOT NULL,
    last_name         VARCHAR (30) NOT NULL,
    street_address    VARCHAR (30) NOT NULL,
    contact_number    DECIMAL (11,0) NOT NULL,
    zip_code          INTEGER NOT NULL
);

CREATE TABLE on_orders (
    order_id        INTEGER NOT NULL,
    order_date      DATE,
    tax_id          INTEGER NOT NULL,
    customer_id     INTEGER NOT NULL,
    associate_id    INTEGER NOT NULL
);

-- order_id is a sequence auto generated column
CREATE OR REPLACE SEQUENCE order_id
  START WITH 1001
  INCREMENT BY 1;

CREATE TABLE on_order_details (
    order_id        INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    quantity        DECIMAL (5,0) NOT NULL
);

CREATE TABLE on_warehouses (
    warehouse_id      INTEGER NOT NULL,
    warehouse_name    VARCHAR (30) NOT NULL,
    street_address    VARCHAR (50) NOT NULL,
    zip_code          INTEGER 
);

CREATE TABLE on_brands (
    brand_id      INTEGER NOT NULL,
    brand_name    VARCHAR (30) NOT NULL
);

CREATE TABLE on_models (
    model_id        INTEGER NOT NULL,
    model_name      VARCHAR (30) NOT NULL,
    brand_id        INTEGER NOT NULL,
    dimensions      VARCHAR (30),
    description     VARCHAR (90) NOT NULL,
    capacity        VARCHAR (30) NOT NULL,
    cost_per_unit   DECIMAL (9,2) NOT NULL, 
    unit_price      DECIMAL (9,2) NOT NULL,
    weight          DECIMAL (6,3)
);

CREATE TABLE on_inventories (
    product_id      INTEGER NOT NULL,
    warehouse_id    INTEGER NOT NULL,
    quantity        DECIMAL (8,0)
);

CREATE TABLE on_electrical_ratings (
    electrical_rating_id      INTEGER NOT NULL,
    electrical_rating         VARCHAR (40) NOT NULL
);

CREATE TABLE on_colors (
    color_id            INTEGER NOT NULL,
    product_color       VARCHAR (20) NOT NULL
);

CREATE TABLE on_associates (
    associate_id                INTEGER NOT NULL,
    first_name                  VARCHAR (30) NOT NULL,
    last_name                   VARCHAR (30) NOT NULL,
    contact_number              DECIMAL (11,0),
    social_security_number      DECIMAL (12,0) NOT NULL
);

CREATE TABLE on_zips (
    zip_code          INTEGER NOT NULL,
    prefecture_id     INTEGER,
    city              VARCHAR (40)
);

CREATE TABLE on_prefectures (
    prefecture_id     INTEGER NOT NULL,
    prefecture        VARCHAR (40) NOT NULL
);

CREATE TABLE on_taxes (
    tax_id      INTEGER NOT NULL,
    vat         DECIMAL (5,4) NOT NULL
);


-- ALTER TABLE ---------------

-- primary keys

ALTER TABLE on_products
ADD CONSTRAINT on_products_pk
PRIMARY KEY (product_id);

ALTER TABLE on_customers
ADD CONSTRAINT on_customers_pk
PRIMARY KEY (customer_id);

ALTER TABLE on_orders
ADD CONSTRAINT on_orders_pk
PRIMARY KEY (order_id);

ALTER TABLE on_order_details
ADD CONSTRAINT on_order_details_pk
PRIMARY KEY (order_id, product_id);

ALTER TABLE on_warehouses
ADD CONSTRAINT on_warehouses_pk
PRIMARY KEY (warehouse_id);

ALTER TABLE on_brands
ADD CONSTRAINT on_brands_pk
PRIMARY KEY (brand_id);

ALTER TABLE on_models
ADD CONSTRAINT on_models_pk
PRIMARY KEY (model_id);

ALTER TABLE on_inventories
ADD CONSTRAINT on_inventories_pk
PRIMARY KEY (product_id, warehouse_id);

ALTER TABLE on_electrical_ratings
ADD CONSTRAINT on_electrical_ratings_pk
PRIMARY KEY (electrical_rating_id);

ALTER TABLE on_colors
ADD CONSTRAINT on_colors_pk
PRIMARY KEY (color_id);

ALTER TABLE on_associates
ADD CONSTRAINT on_associates_pk
PRIMARY KEY (associate_id);

ALTER TABLE on_zips
ADD CONSTRAINT on_zips_pk
PRIMARY KEY (zip_code);

ALTER TABLE on_prefectures
ADD CONSTRAINT on_prefectures_pk
PRIMARY KEY (prefecture_id);

ALTER TABLE on_taxes
ADD CONSTRAINT on_taxes_pk
PRIMARY KEY (tax_id);

-- foreign keys

ALTER TABLE on_products
ADD CONSTRAINT on_products_model_id_fk
FOREIGN KEY (model_id)
REFERENCES on_models (model_id);

ALTER TABLE on_products
ADD CONSTRAINT on_products_color_id_fk
FOREIGN KEY (color_id)
REFERENCES on_colors (color_id);

ALTER TABLE on_products
ADD CONSTRAINT on_products_electrical_rating_id_fk
FOREIGN KEY (electrical_rating_id)
REFERENCES on_electrical_ratings (electrical_rating_id);

ALTER TABLE on_customers
ADD CONSTRAINT on_customers_zip_code_fk
FOREIGN KEY (zip_code)
REFERENCES on_zips (zip_code);

ALTER TABLE on_orders
ADD CONSTRAINT on_orders_tax_id_fk
FOREIGN KEY (tax_id)
REFERENCES on_taxes (tax_id);

ALTER TABLE on_orders
ADD CONSTRAINT on_orders_customer_id_fk
FOREIGN KEY (customer_id)
REFERENCES on_customers (customer_id);

ALTER TABLE on_orders
ADD CONSTRAINT on_orders_associate_id_fk
FOREIGN KEY (associate_id)
REFERENCES on_associates (associate_id);

ALTER TABLE on_order_details
ADD CONSTRAINT on_order_details_order_id_fk
FOREIGN KEY (order_id)
REFERENCES on_orders (order_id);

ALTER TABLE on_order_details
ADD CONSTRAINT on_order_details_product_id_fk
FOREIGN KEY (product_id)
REFERENCES on_products (product_id);

ALTER TABLE on_warehouses
ADD CONSTRAINT on_warehouses_zip_code_fk
FOREIGN KEY (zip_code)
REFERENCES on_zips (zip_code);

ALTER TABLE on_models
ADD CONSTRAINT on_models_brand_id_fk
FOREIGN KEY (brand_id)
REFERENCES on_brands (brand_id);

ALTER TABLE on_inventories
ADD CONSTRAINT on_inventories_product_id_fk
FOREIGN KEY (product_id)
REFERENCES on_products (product_id);

ALTER TABLE on_inventories
ADD CONSTRAINT on_inventories_warehouse_id_fk
FOREIGN KEY (warehouse_id)
REFERENCES on_warehouses (warehouse_id);

ALTER TABLE on_zips
ADD CONSTRAINT on_zips_prefecture_id_fk
FOREIGN KEY (prefecture_id)
REFERENCES on_prefectures (prefecture_id);

-- unique keys

ALTER TABLE on_associates 
ADD CONSTRAINT on_associates_contact_number_uk
UNIQUE (contact_number);

ALTER TABLE on_associates 
ADD CONSTRAINT on_associates_social_security_number_uk
UNIQUE (social_security_number);

ALTER TABLE on_colors 
ADD CONSTRAINT on_colors_product_color_uk
UNIQUE (product_color);

ALTER TABLE on_products 
ADD CONSTRAINT on_products_stock_keeping_unit_uk
UNIQUE (stock_keeping_unit);

ALTER TABLE on_products 
ADD CONSTRAINT on_products_product_code_uk
UNIQUE (product_code);

ALTER TABLE on_warehouses
ADD CONSTRAINT on_warehouses_warehouse_name_uk
UNIQUE (warehouse_name);

ALTER TABLE on_brands
ADD CONSTRAINT on_brands_brand_name_uk
UNIQUE (brand_name);

ALTER TABLE on_taxes
ADD CONSTRAINT on_taxes_vat_uk
UNIQUE (vat);

ALTER TABLE on_models
ADD CONSTRAINT on_models_model_name_uk
UNIQUE (model_name);

ALTER TABLE on_electrical_ratings
ADD CONSTRAINT on_electrical_ratings_electrical_rating_uk
UNIQUE (electrical_rating);

ALTER TABLE on_prefectures 
ADD CONSTRAINT on_prefectures_prefecture_uk
UNIQUE (prefecture);

-- default values

ALTER TABLE on_orders
ALTER COLUMN order_date
SET DEFAULT CURRENT_DATE;

ALTER TABLE on_orders
ALTER COLUMN tax_id
SET DEFAULT 1;

-- check constraints

ALTER TABLE on_orders
ADD CONSTRAINT on_orders_order_date_ck
CHECK ( order_date >= '2020-01-01' );

ALTER TABLE on_order_details
ADD CONSTRAINT on_order_details_quantity_ck
CHECK ( quantity BETWEEN 1 AND 10000 );

ALTER TABLE on_inventories
ADD CONSTRAINT on_inventories_quantity_ck
CHECK ( quantity BETWEEN 0 AND 10000000 );

ALTER TABLE on_models
ADD CONSTRAINT on_models_costPerUnit_ck
CHECK ( cost_per_unit > 5.00 );

ALTER TABLE on_models
ADD CONSTRAINT on_models_unitPrice_costPerUnit_ck
CHECK ( unit_price > cost_per_unit );

ALTER TABLE on_models
ADD CONSTRAINT on_models_weight_ck
CHECK ( weight BETWEEN 2.00 AND 100.00 );

ALTER TABLE on_taxes
ADD CONSTRAINT on_taxes_vat_ck
CHECK ( vat BETWEEN 0.0010 AND 2.0000 );

-- 5 digits for zip code in Japan (prefectures and cities only)
ALTER TABLE on_zips
ADD CONSTRAINT on_zips_zip_code_ck
CHECK ( zip_code < 99999 );


-- INSERT INTO TABLES ---------------

-- 10% VAT in Japan
INSERT INTO on_taxes VALUES
(1, 0.1000);

-- 11 digits for phone numbers and 12 digits for SSN in japan
INSERT INTO on_associates VALUES
(101, 'Ren', 'Yagami', 09021047878,  243600965185),
(102, 'Kim', 'Minota', 09087745690,  774983991069),
(103, 'Yumi', 'Minamino', 09033692961,  803281659056),
(104, 'Hana', 'Akari', 09078850893,  214476309129),
(105, 'Riku', 'Honoka', 09019341422,  952796226409);

INSERT INTO on_colors VALUES
(1, 'Stainless black' ),
(2, 'Premium white' ),
(3, 'Stainless white' ),
(4, 'Premium black' ),
(5, 'Stainless brown' );

INSERT INTO on_electrical_ratings VALUES
(1, '120V/60Hz 600W'),
(2, '120V/60Hz 500W'),
(3, '120V/60Hz 350W');

INSERT INTO on_brands VALUES
(1, 'ONTAKE Home'),
(2, 'ONTAKE Professional'),
(3, 'ONTAKE Green');

INSERT INTO on_models VALUES
(101, 'ONA-2010', 1, '8.46" x 8.6" x 9"', 'Automatic keep warm mode digital rice cooker', '5.5 cups/1.0 litres', 90.00, 135.00, 5.000),
(102, 'ONA-2020', 1, '8.25" x 8.5" x 9"', 'Platinum infused nonstick digital rice cooker', '5 cups/0.95 litres', 85.00, 125.00, 4.700),
(103, 'ONA-2030', 1, '8.40" x 8.6" x 9"', 'Micro computerized fuzzy logic technology', '6 cups/1.1 litres', 95.00, 140.00, 5.350),
(104, 'ONA-2040', 1, '8.40" x 8.6" x 9"', 'Automatic keep warm mode, extended reheating cycle', '6 cups/1.1 litres', 98.00, 143.00, 5.350),
(105, 'ONS-3010', 2, '9.46" x 9.6" x 10"', 'Digital rice cooker/multicooker with ceramic inner pot', '10 cups/1.8 litres', 130.00, 209.00, 7.000),
(106, 'ONS-3020', 2, '9.46" x 9.6" x 10"', 'Turbo rice cooker/multicooker', '10 cups/1.8 litres', 200.00, 349.99, 7.000),
(107, 'ONG-1220', 3, '8.25" x 8.5" x 9"', 'Eco-friendly digital rice cooker', '5 cups/0.95 litres', 95.00, 169.99, 4.800);

INSERT INTO on_prefectures VALUES
(1, 'Tokyo'),
(2, 'Osaka'),
(3, 'Hokkaido'),
(4, 'Chiba'),
(5, 'Fukushima'),
(6, 'Kyoto');

INSERT INTO on_zips VALUES
(57400, 2, 'Daitoshi'),
(58308, 2, 'Habikinoshi'),
(11400, 1, 'Kitaku'),
(04006, 1, 'Chuoku'),
(61001, 6, 'Joyoshi'),
(27800, 4, 'Nodashi'),
(04700, 3, 'Otarushi'),
(96343, 5, 'Tamurashi');

INSERT INTO on_warehouses VALUES
(1, 'Osaka''s warehouse', '10 Fukonominamicho', 57400),
(2, 'Hokkaido'' warehouse', '10-chome-16 Midori', 04700);

INSERT INTO on_products VALUES
(1, 101, 1, 3, 'ON10101WHR', 'NA201'),
(2, 101, 2, 3, 'ON10102WHR', 'NA202'),
(3, 102, 1, 2, 'ON10103WHR', 'NA203'),
(4, 102, 1, 1, 'ON10104WHR', 'NA204'),
(5, 103, 4, 3, 'ON10105WHR', 'NA205'),
(6, 103, 1, 3, 'ON10106WHR', 'NA206'),
(7, 104, 1, 3, 'ON10107WHR', 'NA207'),
(8, 105, 3, 1, 'ON10108WHR', 'NS301'),
(9, 105, 1, 1, 'ON10109WHR', 'NS302'),
(10, 105, 5, 1, 'ON10110WHR', 'NS303'),
(11, 106, 2, 2, 'ON10111WHR', 'NS304'),
(12, 106, 4, 2, 'ON10112WHR', 'NS305'),
(13, 107, 1, 3, 'ON10113WHR', 'NG221');

INSERT INTO on_inventories VALUES
(1, 1, 10000),
(2, 1, 10000),
(3, 2, 10000),
(4, 2, 20000),
(5, 1, 10000),
(6, 1, 5000),
(7, 1, 10000),
(8, 2, 7000),
(9, 2, 1000),
(10, 1, 10000),
(11, 2, 1000),
(12, 1, 1000),
(13, 1, 300);

INSERT INTO on_customers VALUES
(DEFAULT, 'Luis', 'San', '1 Fukonominamicho', 09022812963, 57400),
(DEFAULT, 'Yuriko', 'Shino', '3-chome-22 Konda', 09094670053, 58308),
(DEFAULT, 'Shinji', 'Kagawa', '3-chome-1-10 Higashijujo', 09097511152, 11400),
(DEFAULT, 'Kiyori', 'Minano', '5-chome-2-22 Fukono', 09091668142, 57400),
(DEFAULT, 'Michael', 'Lee', '5-chome-5 Ginza', 09088320945, 04006),
(DEFAULT, 'Mina', 'Kakashi', 'Sagisakayama-69-23 Tono', 09012989971, 61001),
(DEFAULT, 'Daiki', 'Tanaka', '1115-3 Yamazaki, Noda', 09009751587, 27800),
(DEFAULT, 'Mika', 'Miyazato', '3-chome-15 Midori', 09011969096, 04700),
(DEFAULT, 'Naomi', 'Osaka', '1-chome Funehikimachi Tobudai', 09021219674, 96343);

-- Order 1 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-01-02', DEFAULT, 101, 105);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 1, 2),
(PREVIOUS VALUE FOR order_id, 3, 1);

-- Order 2 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-01-05', DEFAULT, 102, 103);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 4),
(PREVIOUS VALUE FOR order_id, 13, 2);

-- Order 3 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-01-20', DEFAULT, 103, 102);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 4, 4),
(PREVIOUS VALUE FOR order_id, 13, 2);

-- Order 4 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-01-28', DEFAULT, 104, 101);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 5, 2),
(PREVIOUS VALUE FOR order_id, 1, 5),
(PREVIOUS VALUE FOR order_id, 12, 4);

-- Order 5 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-03', DEFAULT, 105, 104);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 6, 2),
(PREVIOUS VALUE FOR order_id, 7, 5),
(PREVIOUS VALUE FOR order_id, 10, 4);

-- Order 6 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-11', DEFAULT, 109, 101);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 8, 10),
(PREVIOUS VALUE FOR order_id, 12, 5),
(PREVIOUS VALUE FOR order_id, 2, 15),
(PREVIOUS VALUE FOR order_id, 4, 15),
(PREVIOUS VALUE FOR order_id, 13, 5);

-- Order 7 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-12', DEFAULT, 106, 103);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 1, 8),
(PREVIOUS VALUE FOR order_id, 11, 20);

-- Order 8 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-13', DEFAULT, 107, 104);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 11),
(PREVIOUS VALUE FOR order_id, 3, 7),
(PREVIOUS VALUE FOR order_id, 8, 4);

-- Order 9 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-13', DEFAULT, 108, 104);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 5, 10),
(PREVIOUS VALUE FOR order_id, 6, 23);

-- Order 10 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-15', DEFAULT, 108, 104);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 5, 10),
(PREVIOUS VALUE FOR order_id, 6, 3),
(PREVIOUS VALUE FOR order_id, 3, 11),
(PREVIOUS VALUE FOR order_id, 1, 4),
(PREVIOUS VALUE FOR order_id, 8, 1);

-- Order 11 --------------------------------------------------------------
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-02-16', DEFAULT, 103, 102);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 10),
(PREVIOUS VALUE FOR order_id, 3, 13),
(PREVIOUS VALUE FOR order_id, 4, 11),
(PREVIOUS VALUE FOR order_id, 1, 4),
(PREVIOUS VALUE FOR order_id, 8, 8);



-- CONSTRAINT UNIT TESTING ---------------

--Contstraint 1
--Date: November 16, 2020
--Description: Confirm NOT NULL constraint on brand_name column in on_brands table
INSERT INTO on_brands VALUES (4,'BrandName1'); --valid

--Expected Results: Insert fails with [SQL0407] INSERT not allowed by NOT NULL constraint.
-- Action:
INSERT INTO on_brands VALUES (5, NULL); --invalid;
--Actual Results: SQL Error [23502]: [SQL0407] Null values not allowed in column or variable BRAND_NAME.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 2
--Date: November 16, 2020
--Description: Confirm DEFAULT VALUE constraint of CURRENT_DATE on order_date column in on_orders table
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, DEFAULT, 1, 102, 105); --valid

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 1, 3),
(PREVIOUS VALUE FOR order_id, 3, 3);

--Expected Results: Insert success with 1 row updated. Default value for order_date: 2020-11-16
-- Action:
SELECT ORDER_ID, ORDER_DATE AS "ORDER_DATE - default value", TAX_ID, CUSTOMER_ID, ASSOCIATE_ID FROM on_orders
WHERE order_id = 1012; --inserted order_id
--Actual Results: on_orders (1012, 2020-11-16, 102, 105)
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 3
--Date: November 16, 2020
--Description: Confirm PRIMARY KEY constraint on product_id column in on_products table
INSERT INTO on_products VALUES (14, 101, 1, 3, 'ON10114WHR', 'NA214'); --valid

--Expected Results: Insert fails with [SQL0803] duplicate key value error. INSERT not allowed by PRIMARY KEY constraint.
-- Action:
INSERT INTO on_products VALUES (1, 102, 2, 4, 'ON10115WHR', 'NA215'); --invalid
--Actual Results: SQL Error [23505]: [SQL0803] Duplicate key value specified.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 4
--Date: November 16, 2020
--Description: Confirm PRIMARY KEY constraint on prefecture_id column in on_prefectures table
INSERT INTO on_prefectures VALUES (7, 'Prefecture1'); --valid

--Expected Results: Insert fails with [SQL0803] duplicate key value error. INSERT not allowed by PRIMARY KEY constraint.
-- Action:
INSERT INTO on_prefectures VALUES (1, 'Prefecture2'); --invalid
--Actual Results: SQL Error [23505]: [SQL0803] Duplicate key value specified.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 5
--Date: November 16, 2020
--Description: Confirm UNIQUE KEY constraint on electrical_rating column in on_electrical_ratings table
INSERT INTO on_electrical_ratings VALUES (4, '120V/60Hz 650W'); --valid

--Expected Results: Insert fails with [SQL0803] duplicate key value error. INSERT not allowed by UNIQUE KEY constraint.
-- Action:
INSERT INTO on_electrical_ratings VALUES (5, '120V/60Hz 600W'); --invalid
--Actual Results: SQL Error [23505]: [SQL0803] Duplicate key value specified.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 6
--Date: November 16, 2020
--Description: Confirm FOREIGN KEY constraint on prefecture_id column in on_zips table
INSERT INTO on_zips VALUES (05200, 3, 'Dateshi'); --valid

--Expected Results: Insert fails with [SQL0530] referential key value error. INSERT not allowed by FOREIGN KEY constraint.
-- Action:
INSERT INTO on_zips VALUES (90422, 8, 'Enobi'); --invalid
--Actual Results: SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint ON_ZIPS_PREFECTURE_ID_FK in IBM7826.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 7
--Date: November 16, 2020
--Description: Confirm FOREIGN KEY constraint on zip_code column in on_customers table
INSERT INTO on_customers VALUES (DEFAULT, 'James', 'Reid', '2 Fukonominamicho', 09032892763, 57400); --valid

--Expected Results: Insert fails with [SQL0530] referential key value error. INSERT not allowed by FOREIGN KEY constraint.
-- Action:
INSERT INTO on_customers VALUES (DEFAULT, 'Adam', 'Smith', '7-chome-21 Konda', 09095879051, 52208); --invalid
--Actual Results: SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint ON_CUSTOMERS_ZIP_CODE_FK in IBM7826.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 8
--Date: November 16, 2020
--Description: Confirm FOREIGN KEY constraint on brand_id column in on_models table
INSERT INTO on_models VALUES (108, 'new-model1', 2, '8.47" x 8.7" x 9"', 'Automatic keep warm mode mini digital rice cooker', '5.6 cups/1.1 litres', 70.00, 100.00, 5.200); --valid    

--Expected Results: Insert fails with [SQL0530] referential key value error. INSERT not allowed by FOREIGN KEY constraint.
-- Action:
INSERT INTO on_models VALUES (109, 'new-model2', 5, '8.40" x 8.7" x 8"', 'Eco-friendly mini digital rice cooker', '5.4 cups/1.1 litres', 75.00, 105.00, 5.300); --invalid
--Actual Results: SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint ON_MODELS_BRAND_ID_FK in IBM7826.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 9
--Date: November 16, 2020
--Description: Confirm FOREIGN KEY constraint on model_id column in on_products table
INSERT INTO on_products VALUES (15, 102, 3, 2, 'ON10116WHR', 'NA216'); --valid

--Expected Results: Insert fails with [SQL0530] referential key value error. INSERT not allowed by FOREIGN KEY constraint.
-- Action:
INSERT INTO on_products VALUES (16, 109, 2, 3, 'ON10117WHR', 'NA217'); --invalid
--Actual Results: SQL Error [23503]: [SQL0530] Operation not allowed by referential constraint ON_PRODUCTS_MODEL_ID_FK in IBM7826.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 10
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on order_date column in on_orders table
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-11-17', DEFAULT, 101, 103); --valid

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 1, 4),
(PREVIOUS VALUE FOR order_id, 3, 2);

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2019-11-17', DEFAULT, 101, 103); --invalid

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 1),
(PREVIOUS VALUE FOR order_id, 1, 2);
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 11
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on quantity column in on_order_details table
--Check constraint: quantity BETWEEN 1 AND 10000
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-11-17', DEFAULT, 102, 103);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 20),--valid
(PREVIOUS VALUE FOR order_id, 3, 100);--valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:

-- For less than 1 value
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-11-17', DEFAULT, 103, 102);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 0),--invalid
(PREVIOUS VALUE FOR order_id, 3, 0);--invalid

-- For greater than 10000 value
INSERT INTO on_orders
VALUES (NEXT VALUE FOR order_id, '2020-11-17', DEFAULT, 105, 103);

-- Order Lines
INSERT INTO on_order_details VALUES 
(PREVIOUS VALUE FOR order_id, 2, 10001),--invalid
(PREVIOUS VALUE FOR order_id, 3, 20000);--invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 12
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on quantity column in on_inventories table
--Check constraint: quantity BETWEEN 0 AND 10000000
INSERT INTO on_inventories VALUES (7, 2, 4000); --valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:

--For less than 0 value
INSERT INTO on_inventories VALUES (5, 2, -1); --invalid

--For greater than 10000000
INSERT INTO on_inventories VALUES (11, 1, 10000001); --invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 13
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on cost_per_unit column in on_models table
--Check constraint: cost_per_unit > 5
INSERT INTO on_models VALUES (109, 'new-model2', 3, '8.26" x 8.2" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5 cups/0.8 litres', 92.00, 136.00, 6.000); --valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:
INSERT INTO on_models VALUES (110, 'new-model3', 2, '8.36" x 8.3" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5.5 cups/1 litres', 3.00, 137.00, 6.200); --invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 14
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on unit_price and cost_per_unit columns in on_models table
--Check constraint: unit_price > cost_per_unit
INSERT INTO on_models VALUES (111, 'new-model3', 1, '8.26" x 8.2" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5.3 cups/0.92 litres', 100.00, 120.00, 6.000); --valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:
INSERT INTO on_models VALUES (112, 'new-model4', 3, '8.36" x 8.3" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5.2 cups/0.91 litres', 130.00, 120.00, 6.200); --invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 15
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on weight column in on_models table
--Check constraint: weight BETWEEN 2.00 AND 100.00
INSERT INTO on_models VALUES (113, 'new-model4', 1, '8.26" x 8.2" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5.1 cups/0.91 litres', 110.00, 140.00, 6.000); --valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:

--For less than 2.00 value
INSERT INTO on_models VALUES (114, 'new-model5', 2, '8.26" x 8.1" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5.1 cups/0.91 litres', 100.00, 140.00, 1.500); --invalid

--For greater than 100.00
INSERT INTO on_models VALUES (115, 'new-model6', 1, '8.26" x 8.1" x 8.3"', 'Automatic keep warm mode digital rice cooker', '5.1 cups/0.91 litres', 90.00, 140.00, 101.000); --invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 16
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on vat column in on_taxes table
--Check constraint: vat BETWEEN 0.0010 AND 2.0000
INSERT INTO on_taxes VALUES (2, 0.0800); --valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:

--For less than 0.0010 value
INSERT INTO on_taxes VALUES (3, 0.0009); --invalid

--For greater than 2.0000
INSERT INTO on_taxes VALUES (4, 2.2000); --invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------

--Contstraint 17
--Date: November 17, 2020
--Description: Confirm CHECK KEY constraint on zip_code columns in on_zips table
--Check constraint: zip_code < 99999
INSERT INTO on_zips VALUES (81400, 2, 'city1'); --valid

--Expected Results: Insert fails with [SQL0545]. INSERT not allowed by CHECK KEY constraint.
-- Action:
INSERT INTO on_zips VALUES (100000, 3, 'city2'); --invalid
--Actual Results: SQL Error [23513]: [SQL0545] INSERT, UPDATE, or MERGE not allowed by CHECK constraint.
--------------------------------------------------------------------------------------------------------------------------







