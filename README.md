# 📊 Data Warehouse & Analytics Project

A complete end-to-end **Data Warehouse** project built using **SQL Server**, following the **Medallion Architecture (Bronze → Silver → Gold)**.
This repository includes data ingestion, transformation, modeling, and analytical SQL exploration.

---

## 🏗️ Architecture Overview

### **Bronze Layer**

* Raw CRM + ERP CSV files loaded into SQL Server
* No transformations applied (source-of-truth layer)

### **Silver Layer**

* Cleansing, standardization, resolving duplicates
* Harmonizing CRM + ERP data
* Integration model created for business usability

### **Gold Layer**

* Star Schema (Fact + Dimensions)
* Business-ready analytical tables for reporting

---

## 📂 Repository Structure

```
datasets/
│── source_crm/                 # CRM CSV files
│── source_erp/                 # ERP CSV files

docs/
│── Medallion.drawio
│── Integration_Model.drawio
│── Integration_Model_Silver.drawio
│── Data_Mart_Star_Diagram.drawio
│── data_catalog.md
│── naming_conventions.md

scripts/
│── analysis/                   # SQL analysis queries
│   ├── 1_Database_Exploration.sql
│   ├── 2_Dimension_Exploration.sql
│   ├── 3_Date_Exploration.sql
│   ├── 4_Measures_Exploration.sql
│   ├── 5_Magnitude_Analysis.sql
│   ├── 6_Ranking_Analysis.sql
│
│── bronze/
│   ├── ddl_bronze.sql
│   ├── proc_load_bronze.sql
│
│── silver/
│   ├── ddl_silver.sql
│   ├── proc_load_silver.sql
│   ├── init_database.sql
│
│── gold/
│   ├── ddl_gold.sql

tests/
│── quality_checks_silver.sql
│── quality_checks_gold.sql
```

---

## 🚀 What This Project Demonstrates

* ✔️ SQL Server Data Warehouse Design
* ✔️ ETL using Stored Procedures
* ✔️ Medallion Architecture Implementation
* ✔️ Integration of ERP + CRM systems
* ✔️ Star Schema Modeling
* ✔️ Analytical SQL (ranking, measures, date analysis, dimensions)

---

## 📘 How to Use

1. Run `init_database.sql`
2. Execute **Bronze** DDL + Load procedures
3. Execute **Silver** DDL + Transform procedures
4. Execute **Gold** DDL to create fact/dimension tables
5. Use `analysis/` queries for insights
6. Validate data using `tests/`

---

## 🛡️ License

MIT License — free to use with attribution.

---
