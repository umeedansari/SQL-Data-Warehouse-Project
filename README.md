# Data Warehouse and Analytics Project 🚀

Welcome to the **Data Warehouse and Analytics Project** repository!  
This project demonstrates a comprehensive data warehousing and analytics solution—from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in **data engineering and analytics**.

---

## 🏗️ **Data Architecture**

The data architecture follows **Medallion Architecture**:  
1. **Bronze Layer**: Stores raw data as-is from the source systems (CSV files imported into SQL Server Database).  
2. **Silver Layer**: Data cleansing, standardization, and normalization processes prepare the data for analysis.  
3. **Gold Layer**: Houses business-ready data modeled into a **star schema** required for reporting and analytics.

---

## 📖 **Project Overview**

### **Highlights**
1. **Data Architecture**: Modern Data Warehouse design using Bronze-Silver-Gold layers.  
2. **ETL Pipelines**: Extract, transform, and load data from source systems into the warehouse.  
3. **Data Modeling**: Creation of fact and dimension tables optimized for analytical queries.  
4. **Analytics & Reporting**: Generating SQL-based reports and dashboards for actionable insights.

🎯 Showcase skills in:  
- SQL Development  
- Data Architecture  
- Data Engineering  
- ETL Pipelines  
- Data Modeling  
- Data Analytics  

---

## 🚀 **Project Requirements**

### **Building the Data Warehouse**

#### **Objective**
Develop a SQL Server-based data warehouse to consolidate sales data, enabling analytical reporting and informed decision-making.

#### **Specifications**
- **Data Sources**: Import data from ERP and CRM (provided as CSV files).  
- **Data Quality**: Cleanse and resolve data quality issues.  
- **Integration**: Combine sources into a user-friendly data model designed for analytical queries.  
- **Scope**: Focus on the latest dataset only; historization of data is not required.  
- **Documentation**: Provide clear documentation of the data model for business stakeholders and analytics teams.

---

### **Analytics & Reporting**

#### **Objective**
Deliver SQL-based analytics for detailed insights into:  
- **Customer Behavior**: Segmentation, lifetime value, purchasing trends.  
- **Product Performance**: Analysis of sales, revenue, and product metrics.  
- **Sales Trends**: Seasonality, key sales periods, and patterns over time.

#### **Deliverables**
1. **Actionable Insights**:  
   - Total sales revenue and growth trends.  
   - Top customers, products, and categories.  
   - Customer behavior segmentation (e.g., VIP, Regular, New).  
2. **Reports & Dashboards**: SQL outputs to build dashboards in Power BI/Tableau for interactive insights.

---
## **Report Details**

### **Customer Report**

Purpose: Consolidates key customer metrics and behaviors.

   Highlights:
   1. Gathers fields:
      - Names
      - Ages
      - Transaction details
   2. Segments customers:
      - VIP
      - Regular
      - New
      - Age groups
   3. Aggregates metrics:
      - Total orders
      - Total sales
      - Total quantity purchased
      - Total products
      - Lifespan (in months)
   4. Calculates KPIs:
      - Recency (months since last order)
      - Average Order Value (AOV)
      - Average Monthly Spend

### **Product Report**  
   Purpose:  - Consolidates key product metrics and behaviors.  
   Highlights:  
   1. Gathers fields:  
      - Product name  
      - Category  
      - Subcategory  
      - Cost  
   2. Segments products by revenue:  
      - High-Performers  
      - Mid-Range  
      - Low-Performers  
   3. Aggregates metrics:  
      - Total orders  
      - Total sales  
      - Total quantity sold  
      - Total customers (unique)  
      - Lifespan (in months)  
   4. Calculates KPIs:  
      - Recency (months since last sale)  
      - Average Order Revenue (AOR)  
      - Average Monthly Revenue  
