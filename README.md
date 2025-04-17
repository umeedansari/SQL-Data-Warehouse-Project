# Data Warehouse Project

Welcome to the **Data Warehouse Project** repository! 🚀  
This project demonstrates a comprehensive solution for designing and implementing a modern **data warehouse**. It focuses on building scalable architectures, optimizing data storage, and delivering business-ready insights.

---

## 🏗️ Data Architecture

The data architecture for this project adheres to the **Medallion Architecture** with three distinct layers:

1. **Bronze Layer**:  
   Stores raw data from source systems without modifications, ensuring traceability and accuracy. Data is ingested into a SQL Server database.

2. **Silver Layer**:  
   This layer involves cleaning, standardizing, and transforming data to create a structured format suitable for analysis.

3. **Gold Layer**:  
   Contains highly organized business-ready data modeled into a **star schema**, tailored for analytics and reporting purposes.

---

## 📖 Project Overview

This project focuses on:

1. **Data Architecture Design**: Implementing **Bronze**, **Silver**, and **Gold** layers to create a modern data warehouse.
2. **ETL Processes**: Designing Extract, Transform, and Load (ETL) pipelines to move data seamlessly between layers.
3. **Data Modeling**: Creating optimized fact and dimension tables based on industry best practices to enable fast analytical queries.

🎯 This repository is a perfect showcase for anyone looking to demonstrate expertise in:
- **Data Warehousing**
- **ETL Development**
- **Data Architecture**

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.
