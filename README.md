# 📊 Data Warehouse & Advanced Analytics Project

A complete end-to-end **SQL Server Data Warehouse + Analytics** project designed using the **Medallion Architecture (Bronze → Silver → Gold)**.
The repository showcases data ingestion, cleansing, modeling, and advanced analytics used in real data engineering & analyst workflows.

---

## 🏗️ Architecture Overview

### **Bronze Layer — Raw Data**

* Direct load of CRM & ERP CSV files
* No transformations applied
* Acts as the *source-of-truth* layer

### **Silver Layer — Cleaned + Standardized**

* Deduplication, normalization, business rules
* CRM & ERP integration
* Provides consistent, analysis-ready data

### **Gold Layer — Business Data Mart**

* Star schema (Fact + Dimensions)
* Metrics modeled for BI tools (Power BI, Tableau)
* Used by dashboards & analytical SQL

---

## 📂 Repository Structure

```
datasets/
│── source_crm/                     # CRM raw CSVs
│── source_erp/                     # ERP raw CSVs

docs/
│── Medallion.drawio
│── Integration_Model.drawio
│── Integration_Model_Silver.drawio
│── Data_Mart_Star_Diagram.drawio
│── data_catalog.md
│── naming_conventions.md

scripts/
│── analysis/                       # Standard EDA & SQL analysis
│   ├── 1_Database_Exploration.sql
│   ├── 2_Dimension_Exploration.sql
│   ├── 3_Date_Exploration.sql
│   ├── 4_Measures_Exploration.sql
│   ├── 5_Magnitude_Analysis.sql
│   ├── 6_Ranking_Analysis.sql

│── advance_analysis/               # Advanced Analytics (Final Additions)
│   ├── 1_Changes_Over_Time_Analysis.sql
│   ├── 2_Cumulative_Analysis.sql
│   ├── 3_Performance_Analysis.sql
│   ├── 4_Part_To_Whole_Analysis.sql
│   ├── 5_Data_Segmentation.sql
│   ├── 6_Build_Customer_Report.sql
│   ├── 7_Build_Product_Report.sql

│── bronze/
│   ├── ddl_bronze.sql
│   ├── proc_load_bronze.sql

│── silver/
│   ├── ddl_silver.sql
│   ├── proc_load_silver.sql
│   ├── init_database.sql

│── gold/
│   ├── ddl_gold.sql

tests/
│── quality_checks_silver.sql
│── quality_checks_gold.sql
```

---

## 🎯 Features Covered

### **📥 1. ETL & Data Engineering**

* Automated loading using stored procedures
* Raw → Clean → Business-Model data flow
* Surrogate keys, SCD handling, deduplication

### **📐 2. Data Modeling**

* Complete Star Schema

  * Fact Sales
  * Dim Customers
  * Dim Products
  * Dim Date
* Relationship mapping for BI tools

### **📈 3. Analytical SQL (Advance Analytics)**

Inside the `advance_analysis/` folder:

✔ Change-Over-Time Trends
✔ Cumulative & Running Totals
✔ Performance Analysis (vs AVG, vs Previous Periods)
✔ Part-To-Whole Analysis
✔ Data Segmentation (CASE-WHEN logic)
✔ Full Customer Report (KPIs)
✔ Full Product Report (KPIs)

### **📊 4. BI-Ready Reporting**

* Power BI / Tableau pulls directly from Gold Layer
* Clean SQL views:

  * `report_customers`
  * `report_products`

---

## 🚀 How to Run This Project

1. **Initialize the database**

   ```
   scripts/silver/init_database.sql
   ```

2. **Load Bronze layer**

   * Run `ddl_bronze.sql`
   * Execute `proc_load_bronze.sql`

3. **Transform into Silver**

   * Run `ddl_silver.sql`
   * Execute `proc_load_silver.sql`

4. **Build Gold Data Mart**

   * Run `ddl_gold.sql`

5. **Run Analysis**

   * Use queries from `/analysis` and `/advance_analysis`

6. **Run Data Quality Tests**

   * `/tests/quality_checks_silver.sql`
   * `/tests/quality_checks_gold.sql`

---

## 🧠 Skills Demonstrated

* Data Warehousing (SQL Server)
* ETL Design (Stored Procedures)
* Medallion Architecture
* Advanced SQL Analytics & Window Functions
* Star Schema Modeling
* BI Dashboard-Ready Data Preparation
* Real-world analytical reporting

---

## 🛡 License

MIT License — Free to use with attribution.

---
