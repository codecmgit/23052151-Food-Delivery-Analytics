# Food Delivery Performance & Customer Analytics Pipeline

**Roll Number:** 23052151  
**Project Type:** End-to-End Data Engineering & Analytics Pipeline  
**Domain:** Food Delivery Analytics  
**Primary Platform:** Databricks  
**Target Platform:** Snowflake  

---

## 1. Project Overview

The Food Delivery Performance & Customer Analytics Pipeline is an end-to-end data engineering and analytics project designed to transform raw food delivery data into business-ready analytical datasets.

The project follows a layered data architecture using:

- Raw CSV files
- Bronze layer
- Silver layer
- Gold layer
- Snowflake handover preparation
- Business analytics

The pipeline processes customer, restaurant, menu, order, delivery, order-item, and review data to answer practical business questions related to delivery performance, customer segments, revenue, food categories, and customer ratings.

---

## 2. Problem Statement

Food delivery platforms generate large amounts of data from customers, restaurants, orders, deliveries, menu items, and reviews.

Raw operational data may contain:

- Duplicate records
- Missing values
- Invalid numeric values
- Orphan records
- Inconsistent data types
- Delivery performance information that is difficult to analyze directly

The objective of this project is to build a reliable data pipeline that cleans and transforms the raw data into structured business-ready datasets that can be used for analytics and decision-making.

---

## 3. Objectives

The main objectives of the project are:

1. Ingest raw food delivery CSV datasets into Databricks.
2. Preserve raw data in the Bronze layer.
3. Clean and validate the data in the Silver layer.
4. Handle duplicate and orphan records.
5. Create business-focused Gold analytical datasets.
6. Automate the Bronze → Silver → Gold pipeline using a Databricks Job.
7. Export Gold datasets for Snowflake handover.
8. Prepare Snowflake loading and business-analysis SQL scripts.
9. Answer three business questions using actual project data.
10. Provide a reusable and organized project structure.

---

## 4. Dataset

The project uses a synthetic relational food delivery dataset created for educational and analytics purposes.

The dataset contains seven related CSV files:

| Dataset | Description |
|---|---|
| customers.csv | Customer information |
| restaurants.csv | Restaurant information |
| menu_items.csv | Menu item information |
| orders.csv | Food delivery orders |
| order_items.csv | Items included in orders |
| delivery_details.csv | Delivery timing information |
| reviews.csv | Customer review and rating information |

### Raw record counts

| Dataset | Raw Records |
|---|---:|
| Customers | 20,000 |
| Restaurants | 500 |
| Menu Items | 5,000 |
| Orders | 102,000 |
| Order Items | 165,248 |
| Delivery Details | 100,000 |
| Reviews | 80,000 |

The raw orders dataset intentionally contains duplicate records so that data-quality processing can be demonstrated.

---

## 5. Data Relationships

The major relationships between the datasets are:

customers.customer_id
        |
        v
orders.customer_id

restaurants.restaurant_id
        |
        v
orders.restaurant_id

orders.order_id
        |
        +------------------> order_items.order_id
        |
        +------------------> delivery_details.order_id
        |
        +------------------> reviews.order_id

menu_items.item_id
        |
        v
order_items.item_id

---

## 6. Architecture

The project follows a layered data pipeline:

                    RAW CSV FILES
                         |
                         v
                +----------------+
                |   DATABRICKS   |
                |     BRONZE     |
                +----------------+
                         |
                         v
                +----------------+
                |   DATABRICKS   |
                |     SILVER     |
                +----------------+
                         |
                         v
                +----------------+
                |   DATABRICKS   |
                |      GOLD      |
                +----------------+
                         |
                         v
                  GOLD CSV EXPORT
                         |
                         v
                +----------------+
                |    SNOWFLAKE   |
                |     STAGE      |
                +----------------+
                         |
                         v
                    COPY INTO
                         |
                         v
                SNOWFLAKE GOLD
                     TABLES
                         |
                         v
                 BUSINESS SQL

The detailed architecture diagram is available in:

architecture/23052151_Food_Delivery_Architecture.png

--

## 7. Data Processing Layers
Bronze Layer

The Bronze layer stores the raw datasets after ingestion into Databricks.

The raw structure is preserved without applying business transformations.

Seven datasets were ingested:

Customers
Restaurants
Menu Items
Orders
Order Items
Delivery Details
Reviews

Bronze data was stored as Delta datasets under:

/Volumes/workspace/capstone_23052151/bronze_data/
Silver Layer

The Silver layer performs data cleaning and transformation.

The following processing was performed:

Data type correction
Duplicate order removal
Invalid numeric values handled using safe casting
Orphan order-item records removed
Missing review ratings retained as NULL
Delivery delay calculated
Late-delivery indicator created
Related datasets joined where required

The raw orders dataset contained:

102,000 records

After duplicate removal:

100,000 valid orders

The Silver layer contains cleaned business entities and a delivery-performance dataset.

Silver data was stored under:

/Volumes/workspace/capstone_23052151/silver_data/
Gold Layer

The Gold layer contains business-ready analytical datasets.

Three Gold datasets were created:

1. Restaurant Performance
restaurant_performance

Contains:

Restaurant ID
Restaurant name
City
Cuisine type
Delivered orders
Late orders
Late delivery rate
Average customer rating

2. Customer Segment Performance
customer_segment_performance

Contains:

Order month
Customer segment
Total orders
Unique customers
Total revenue
Average order value
3. Category Performance
category_performance

Contains:

Food category
Items sold
Total revenue
Average customer rating

Gold data was stored under:

/Volumes/workspace/capstone_23052151/gold_data/

--

## 8. Databricks Job

A multi-task Databricks Job was created:

23052151_Food_Delivery_Pipeline

The dependency structure is:

Bronze_Ingestion
       |
       v
Silver_Transformation
       |
       v
Gold_Analytics

The job was successfully executed.

The corresponding evidence is available in:

screenshots/05_job/

--

## 9. Snowflake Handover

The Gold datasets were exported from Databricks into CSV format for Snowflake handover.

The export contains:

restaurant_performance
customer_segment_performance
category_performance

The export location in Databricks is:

/Volumes/workspace/capstone_23052151/gold_data/snowflake_export

The Snowflake handover notebook is:

notebooks/23052151_Snowflake_Handover.ipynb

The Snowflake SQL script is:

sql/23052151_Snowflake_Handover.sql

The Gold export evidence is available in:

screenshots/06_snowflake/
Snowflake access limitation

During project execution, creation/access of the Snowflake account was blocked by signup/network issues.

Therefore, the project includes:

Completed Databricks Gold export
Snowflake handover notebook
Snowflake database/schema setup SQL
File format definition
Stage definition
COPY INTO commands
COPY_HISTORY query
Business analysis SQL

However, no Snowflake execution results are claimed where execution could not be verified.

--

## 10. Business Questions

The Gold layer was designed to answer three main business questions.

Question 1
Which restaurants have the highest late-delivery rates, and how does late delivery relate to customer ratings?

The analysis uses:

Delivered orders
Late orders
Late delivery percentage
Average customer rating

Examples from the analysis include restaurants with late-delivery rates around 89–90%.

The results allow restaurant delivery performance to be compared with customer ratings.

Question 2
Which customer segments contribute the most revenue, and how does their ordering behaviour change over time?

Overall customer segment results:

Customer Segment	Total Orders	Total Revenue
Regular	39,598	63,803,902.01
Frequent	25,819	41,859,196.91
Budget	24,619	39,787,345.47
Premium	9,964	16,079,735.78

The project also contains monthly customer-segment results covering:

January 2024 – December 2024

This allows changes in order volume, revenue, and average order value to be analyzed over time.

Question 3
Which food categories generate the highest revenue, and which categories receive the strongest customer ratings?

The Gold analysis produced the following results:

Category	Items Sold	Total Revenue	Average Rating
Desserts	38,135	18,714,029.37	4.09
Pizza	37,263	18,528,633.16	4.08
Bengali	36,624	18,296,798.61	4.07
Beverages	38,178	18,212,546.67	4.10
Chinese	37,133	18,146,177.67	4.07
Burger	36,608	17,840,841.70	4.08
Healthy	35,913	17,486,553.28	4.08
Biryani	35,426	17,481,760.14	4.10
South Indian	35,207	16,822,839.57	4.08

--

## 11. Technologies Used
Data Engineering
Databricks
Apache Spark
PySpark
Delta Lake
Data Storage
Databricks Volumes
Delta datasets
CSV files
Data Warehouse Handover
Snowflake
Snowflake Stage
COPY INTO
COPY_HISTORY
Development
Python
SQL
VS Code
Git/GitHub

--

## 12. Project Structure
Food_Delivery_Analytics/
│
├── architecture/
│   └── 23052151_Food_Delivery_Architecture.png
│
├── data/
│   └── raw/
│       ├── customers.csv
│       ├── restaurants.csv
│       ├── menu_items.csv
│       ├── orders.csv
│       ├── order_items.csv
│       ├── delivery_details.csv
│       └── reviews.csv
│
├── documentation/
│   └── one_page_proposal.txt
│
├── notebooks/
│   ├── 23052151_Bronze_Ingestion.ipynb
│   ├── 23052151_Silver_Transformation.ipynb
│   ├── 23052151_Gold_Analytics.ipynb
│   └── 23052151_Snowflake_Handover.ipynb
│
├── sql/
│   ├── 23052151_Project_Setup.sql
│   ├── 23052151_Snowflake_Handover.sql
│   └── 23052151_Business_Questions.sql
│
├── screenshots/
│   ├── 01_setup/
│   ├── 02_bronze/
│   ├── 03_silver/
│   ├── 04_gold/
│   ├── 05_job/
│   ├── 06_snowflake/
│   └── 07_final/
│
└── README.md

--

## 13. Data Quality Handling

The project intentionally includes several data-quality challenges to demonstrate realistic data engineering practices.

Duplicate Orders

The raw orders dataset contained duplicate records.

Raw orders:       102,000
Silver orders:    100,000
Duplicates removed: 2,000
Invalid Numeric Values

Some order-item records contained invalid numeric values such as:

NA

Safe casting was used to prevent the pipeline from failing.

Orphan Order Items

Order-item records without a valid parent order were removed during Silver transformation.

Missing Ratings

Missing review ratings were retained as NULL rather than being replaced with artificial values.

Cancelled Orders

Cancelled orders without an actual delivery time were handled appropriately during delivery-performance calculations.

--

## 14. Testing and Verification

The pipeline was tested at multiple stages.

Bronze
Raw record counts checked
Delta datasets verified
Silver
Duplicate removal verified
Orphan records checked
Data-quality transformations verified
Cleaned datasets verified
Gold
Three analytical datasets verified
Business metrics calculated
Final business questions executed successfully in Databricks
Job

The complete:

Bronze → Silver → Gold

workflow was executed successfully through the Databricks Job.

--

## 15. Screenshots and Evidence

Project evidence is organized under:

screenshots/

The folders represent:

01_setup
02_bronze
03_silver
04_gold
05_job
06_snowflake
07_final

The screenshots demonstrate:

Raw data ingestion
Bronze validation
Silver transformations
Gold analytics
Databricks Job configuration
Successful Job execution
Gold export
Final business analysis

--

## 16. Challenges and Learnings
Challenges
Data Quality

The raw data contained duplicates, invalid numeric values, orphan records, and missing values.

These issues required careful transformation logic rather than simply dropping records.

Spark Data Type Handling

Invalid numeric values initially caused casting problems. Safe casting using try_cast was used to allow invalid values to become NULL without stopping the pipeline.

Snowflake Access

Snowflake account creation was affected by signup/network issues during implementation. The Databricks-to-Snowflake handover preparation was therefore completed, while actual Snowflake execution could not be verified.

Learnings

This project provided practical experience with:

Databricks
PySpark
Delta Lake
Data-layer architecture
Data cleaning
Data quality handling
Aggregation
Business analytics
Databricks Jobs
SQL
Snowflake handover concepts
Pipeline documentation

--

## 17. Future Improvements

Possible future improvements include:

Complete live Snowflake loading once account access is available.
Add automated data-quality monitoring.
Add pipeline scheduling.
Add dashboard visualizations for business users.
Add automated alerts for high late-delivery restaurants.
Add customer retention and churn analysis.
Add predictive models for delivery delays.
Add automated pipeline failure notifications.

--

## 18. Conclusion

The Food Delivery Performance & Customer Analytics Pipeline demonstrates an end-to-end data engineering workflow from raw CSV files to business-ready analytical datasets.

The project successfully implements:

Raw Data
   ↓
Bronze
   ↓
Silver
   ↓
Gold
   ↓
Business Analysis

The pipeline handles realistic data-quality issues, creates reusable Gold datasets, automates the Databricks processing workflow, and prepares the resulting datasets for Snowflake handover.

The final Gold layer provides analytical results for restaurant delivery performance, customer segment revenue and ordering behaviour, and food-category performance.

19. Key Project Files

Databricks Notebooks
23052151_Bronze_Ingestion.ipynb
23052151_Silver_Transformation.ipynb
23052151_Gold_Analytics.ipynb
23052151_Snowflake_Handover.ipynb

SQL Files
23052151_Project_Setup.sql
23052151_Snowflake_Handover.sql
23052151_Business_Questions.sql

Architecture
23052151_Food_Delivery_Architecture.png

--

## Project Author

Roll Number: 23052151
Project: Food Delivery Performance & Customer Analytics Pipeline