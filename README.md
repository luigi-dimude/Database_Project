# Database_Term1_Project (Individual project)
A design, model and implementation of a company's database implemented based on the Customer Sales Invoice and other information using an enterprise-level relational
database management system (RDBMS)


# Implementations
- Technical Documentation
- Entity Relationship Diagram
- Entity Relationship Diagram Language
- Relational Physical Model (Table & Text)
- Database build (SQL File)
- Business rules/Contraints
- Constraint Unit Testing

# Product Attributes - Sample Data
![image](https://user-images.githubusercontent.com/33835722/135760148-ecd6df27-026a-4834-9f6b-0196be4a6381.png)

# Product Attributes: Description
![image](https://user-images.githubusercontent.com/33835722/135760186-cd610645-7765-44b9-8ed3-0fd80614800a.png)

# Customer Sales Invoice - Sample Data
![image](https://user-images.githubusercontent.com/33835722/135760205-11c065a0-0b8f-4061-9e53-6675171be9e5.png)

# ERD: many to many relationship 
![ERD_many_to_many_relationship](https://user-images.githubusercontent.com/33835722/135745720-2a323957-80cc-4972-b6c3-b8f58e2f5d13.png)

# ERD Language: many to many relationship
![image](https://user-images.githubusercontent.com/33835722/135760228-45f88ab2-8e53-46ae-ac4c-c98f14bc4a52.png)

# ERD: many to many relationship resolved
![ERD_many_to_many_relationship_resolved](https://user-images.githubusercontent.com/33835722/135745729-cb5caf34-9eda-4e98-aef5-0eb769682032.png)

# ERD Language: many to many relationship resolved
![image](https://user-images.githubusercontent.com/33835722/135760261-589b8697-d951-42dc-bacf-bf8c02d7248b.png)

# Relational Physical Model: Table Format
![image](https://user-images.githubusercontent.com/33835722/135760280-0c86c15f-6039-4c70-9f70-92c0da057275.png)
![image](https://user-images.githubusercontent.com/33835722/135760302-6ddf9cfa-43ac-4c5d-be91-9a456339b6ed.png)
![image](https://user-images.githubusercontent.com/33835722/135760309-7904c7d3-b74e-4df8-a2e1-fc4ed4f5bd3a.png)

# Relational Physical Model: Text Format
![image](https://user-images.githubusercontent.com/33835722/135760327-dc7a5cdb-235d-4db9-8a59-4fa64bbb0e37.png)
![image](https://user-images.githubusercontent.com/33835722/135760334-08b87cc1-e4f6-4ed9-a91a-5a2f356e0465.png)

# Business Rules
![image](https://user-images.githubusercontent.com/33835722/135760348-b73f3b17-bb24-460c-9a7c-2902cf225cff.png)
![image](https://user-images.githubusercontent.com/33835722/135760358-da2b544a-4815-4943-b060-90c636df214a.png)
![image](https://user-images.githubusercontent.com/33835722/135760366-e54ee71b-9088-47fb-bb24-a7242a602a42.png)
![image](https://user-images.githubusercontent.com/33835722/135760370-a5d9d57d-228c-40c3-88f8-7212e0021c3e.png)

# Constraints Unit Testing
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
SELECT * FROM on_orders
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



