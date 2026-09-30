-- ============================================================
-- FOOD DELIVERY PERFORMANCE & CUSTOMER ANALYTICS PIPELINE
-- Roll Number: 23052151
-- Business Questions
-- ============================================================

USE DATABASE FOOD_DELIVERY_23052151;

USE SCHEMA ANALYTICS;


-- ============================================================
-- BUSINESS QUESTION 1
-- ============================================================
-- Which restaurants have the highest late-delivery rates,
-- and how does late delivery relate to customer ratings?
-- ============================================================

SELECT
    RESTAURANT_ID,
    RESTAURANT_NAME,
    CITY,
    CUISINE_TYPE,
    DELIVERED_ORDERS,
    LATE_ORDERS,
    ROUND(LATE_DELIVERY_RATE, 2) AS LATE_DELIVERY_PERCENTAGE,
    ROUND(AVERAGE_CUSTOMER_RATING, 2) AS AVERAGE_CUSTOMER_RATING
FROM RESTAURANT_PERFORMANCE
WHERE DELIVERED_ORDERS > 0
ORDER BY LATE_DELIVERY_RATE DESC;


-- ============================================================
-- BUSINESS QUESTION 2
-- ============================================================
-- Which customer segments contribute the most revenue,
-- and how does their ordering behaviour change over time?
-- ============================================================

WITH SEGMENT_TOTALS AS (
    SELECT
        CUSTOMER_SEGMENT,
        SUM(TOTAL_ORDERS) AS TOTAL_ORDERS,
        SUM(UNIQUE_CUSTOMERS) AS UNIQUE_CUSTOMERS,
        SUM(TOTAL_REVENUE) AS TOTAL_REVENUE,
        AVG(AVERAGE_ORDER_VALUE) AS AVERAGE_ORDER_VALUE
    FROM CUSTOMER_SEGMENT_PERFORMANCE
    GROUP BY CUSTOMER_SEGMENT
)

SELECT
    CUSTOMER_SEGMENT,
    TOTAL_ORDERS,
    UNIQUE_CUSTOMERS,
    ROUND(TOTAL_REVENUE, 2) AS TOTAL_REVENUE,
    ROUND(AVERAGE_ORDER_VALUE, 2) AS AVERAGE_ORDER_VALUE
FROM SEGMENT_TOTALS
ORDER BY TOTAL_REVENUE DESC;


-- ============================================================
-- BUSINESS QUESTION 2A
-- MONTHLY CUSTOMER SEGMENT TREND
-- ============================================================

SELECT
    ORDER_MONTH,
    CUSTOMER_SEGMENT,
    TOTAL_ORDERS,
    UNIQUE_CUSTOMERS,
    ROUND(TOTAL_REVENUE, 2) AS TOTAL_REVENUE,
    ROUND(AVERAGE_ORDER_VALUE, 2) AS AVERAGE_ORDER_VALUE
FROM CUSTOMER_SEGMENT_PERFORMANCE
ORDER BY
    ORDER_MONTH,
    TOTAL_REVENUE DESC;


-- ============================================================
-- BUSINESS QUESTION 3
-- ============================================================
-- Which food categories generate the highest revenue,
-- and which categories receive the strongest customer ratings?
-- ============================================================

SELECT
    CATEGORY,
    ITEMS_SOLD,
    ROUND(TOTAL_REVENUE, 2) AS TOTAL_REVENUE,
    ROUND(AVERAGE_CUSTOMER_RATING, 2) AS AVERAGE_CUSTOMER_RATING
FROM CATEGORY_PERFORMANCE
ORDER BY TOTAL_REVENUE DESC;