-- ============================================================
-- FOOD DELIVERY PERFORMANCE & CUSTOMER ANALYTICS PIPELINE
-- Roll Number: 23052151
-- Snowflake Gold Handover
-- ============================================================

-- ============================================================
-- 1. CREATE DATABASE AND SCHEMA
-- ============================================================

CREATE DATABASE IF NOT EXISTS FOOD_DELIVERY_23052151;

CREATE SCHEMA IF NOT EXISTS FOOD_DELIVERY_23052151.ANALYTICS;

USE DATABASE FOOD_DELIVERY_23052151;

USE SCHEMA ANALYTICS;


-- ============================================================
-- 2. CREATE CSV FILE FORMAT
-- ============================================================

CREATE FILE FORMAT IF NOT EXISTS FOOD_DELIVERY_CSV_FORMAT
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
NULL_IF = ('NULL', 'null', '');


-- ============================================================
-- 3. CREATE INTERNAL STAGE
-- ============================================================

CREATE STAGE IF NOT EXISTS FOOD_DELIVERY_GOLD_STAGE
FILE_FORMAT = FOOD_DELIVERY_CSV_FORMAT;


-- ============================================================
-- 4. CREATE GOLD TABLES
-- ============================================================

CREATE OR REPLACE TABLE RESTAURANT_PERFORMANCE (
    RESTAURANT_ID VARCHAR,
    RESTAURANT_NAME VARCHAR,
    CITY VARCHAR,
    CUISINE_TYPE VARCHAR,
    DELIVERED_ORDERS INTEGER,
    LATE_ORDERS INTEGER,
    LATE_DELIVERY_RATE DOUBLE,
    AVERAGE_CUSTOMER_RATING DOUBLE
);


CREATE OR REPLACE TABLE CUSTOMER_SEGMENT_PERFORMANCE (
    ORDER_MONTH VARCHAR,
    CUSTOMER_SEGMENT VARCHAR,
    TOTAL_ORDERS INTEGER,
    UNIQUE_CUSTOMERS INTEGER,
    TOTAL_REVENUE DOUBLE,
    AVERAGE_ORDER_VALUE DOUBLE
);


CREATE OR REPLACE TABLE CATEGORY_PERFORMANCE (
    CATEGORY VARCHAR,
    ITEMS_SOLD INTEGER,
    TOTAL_REVENUE DOUBLE,
    AVERAGE_CUSTOMER_RATING DOUBLE
);


-- ============================================================
-- 5. UPLOAD GOLD CSV FILES TO THE STAGE
-- ============================================================
-- The Databricks Gold datasets were exported as CSV files.
-- Upload the three exported CSV files/folders to:
--
-- FOOD_DELIVERY_GOLD_STAGE
--
-- using Snowflake's Snowsight interface.
--
-- The expected datasets are:
-- restaurant_performance
-- customer_segment_performance
-- category_performance


-- ============================================================
-- 6. LOAD RESTAURANT PERFORMANCE
-- ============================================================

COPY INTO RESTAURANT_PERFORMANCE
FROM @FOOD_DELIVERY_GOLD_STAGE
PATTERN = '.*restaurant_performance.*\.csv'
FILE_FORMAT = FOOD_DELIVERY_CSV_FORMAT
ON_ERROR = 'CONTINUE';


-- ============================================================
-- 7. LOAD CUSTOMER SEGMENT PERFORMANCE
-- ============================================================

COPY INTO CUSTOMER_SEGMENT_PERFORMANCE
FROM @FOOD_DELIVERY_GOLD_STAGE
PATTERN = '.*customer_segment_performance.*\.csv'
FILE_FORMAT = FOOD_DELIVERY_CSV_FORMAT
ON_ERROR = 'CONTINUE';


-- ============================================================
-- 8. LOAD CATEGORY PERFORMANCE
-- ============================================================

COPY INTO CATEGORY_PERFORMANCE
FROM @FOOD_DELIVERY_GOLD_STAGE
PATTERN = '.*category_performance.*\.csv'
FILE_FORMAT = FOOD_DELIVERY_CSV_FORMAT
ON_ERROR = 'CONTINUE';


-- ============================================================
-- 9. VERIFY LOADED TABLES
-- ============================================================

SELECT COUNT(*) AS RESTAURANT_ROWS
FROM RESTAURANT_PERFORMANCE;

SELECT COUNT(*) AS CUSTOMER_SEGMENT_ROWS
FROM CUSTOMER_SEGMENT_PERFORMANCE;

SELECT COUNT(*) AS CATEGORY_ROWS
FROM CATEGORY_PERFORMANCE;


-- ============================================================
-- 10. COPY HISTORY
-- ============================================================

SELECT
    FILE_NAME,
    STATUS,
    ROW_COUNT,
    ROW_PARSED,
    LAST_LOAD_TIME
FROM TABLE(
    INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME => 'RESTAURANT_PERFORMANCE',
        START_TIME => DATEADD('DAY', -7, CURRENT_TIMESTAMP())
    )
)
ORDER BY LAST_LOAD_TIME DESC;