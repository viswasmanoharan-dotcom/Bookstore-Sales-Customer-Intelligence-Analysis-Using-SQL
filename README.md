# Bookstore-Sales-Customer-Intelligence-Analysis-Using-SQL

## Project Overview

This project focuses on analyzing bookstore sales, customer purchasing behavior, inventory performance, revenue trends, and marketing effectiveness using **MySQL 8.0**. The objective is to transform relational bookstore data into meaningful business insights through practical SQL queries and analytical techniques.

The project uses a relational database consisting of four interconnected tables: `books`, `customers`, `orders`, and `marketing_spend`. It demonstrates the practical application of SQL for data extraction, data aggregation, customer segmentation, sales performance evaluation, and business intelligence.

## Project Objectives

- Analyze book sales performance and identify top-selling books based on revenue and units sold.
- Monitor inventory levels and identify books with low stock availability.
- Evaluate customer purchasing behavior using Recency, Frequency, and Monetary (RFM) analysis.
- Identify returning, high-value, and potentially churned customers.
- Analyze monthly revenue trends and cumulative sales performance.
- Compare monthly revenue growth using historical sales data.
- Evaluate customer lifetime revenue against marketing acquisition expenditure.
- Identify top-performing book genres and customer acquisition trends.
- Apply advanced SQL techniques to solve practical business problems.

## Database Schema

The project consists of four relational tables:

| Table Name | Description | Key Columns |
|---|---|---|
| `books` | Stores book information and inventory details | book_id, title, genre, price, stock |
| `customers` | Contains customer information and registration details | customer_id, name, city, signup_date |
| `orders` | Records customer purchases and transaction details | order_id, customer_id, book_id, quantity, order_date |
| `marketing_spend` | Stores customer-level marketing expenditure | spend_id, customer_id, spend_amount |

**Database Relationships:**
- Customers → Orders (One-to-Many)
- Books → Orders (One-to-Many)
- Customers → Marketing Spend (One-to-Many)

Primary keys and foreign key constraints are implemented to maintain relational data integrity.

## SQL Concepts & Technical Skills

The project demonstrates the following SQL concepts:

### 1. Database Management & Data Retrieval
- Database and table creation using `CREATE DATABASE` and `CREATE TABLE`.
- Primary Key and Foreign Key constraints.
- Data insertion using `INSERT INTO`.
- Data retrieval using `SELECT`.
- Filtering records using `WHERE`.
- Sorting results using `ORDER BY`.

### 2. Joins & Data Aggregation
- INNER JOIN for combining multiple relational tables.
- Aggregate functions: `SUM()`, `COUNT()`, `MAX()`, and `AVG()`.
- Grouping records using `GROUP BY`.
- Filtering aggregated results using `HAVING`.
- Calculating total sales, revenue, and average order value.

### 3. Subqueries
- Scalar subqueries for average price comparisons.
- Nested subqueries for identifying high-spending customers.
- Comparing individual customer spending against average customer spending.
- Applying subqueries to solve business-oriented analytical questions.

### 4. Common Table Expressions (CTEs)
- Single CTEs using the `WITH` clause.
- Multiple CTEs for breaking down complex analytical queries.
- Customer-level RFM metrics calculation.
- Customer revenue analysis.
- Monthly revenue calculations.
- Genre-level sales analysis.

### 5. Window Functions
- `RANK()` for ranking books and genres by revenue.
- `ROW_NUMBER()` for assigning sequential rankings.
- `LAG()` for comparing current and previous month revenue.
- `SUM() OVER()` for calculating cumulative revenue.
- `PARTITION BY` for category-wise and customer-wise analysis.
- `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` for running totals.

### 6. Date & Business Analytics Functions
- `DATE_FORMAT()` for monthly sales analysis.
- `DATEDIFF()` for calculating customer purchase recency.
- `ROUND()` for numerical precision.
- `NULLIF()` for handling division-by-zero scenarios.

## Project Analysis & Business Questions

The project covers 18 practical SQL analysis steps:

| Step | Analysis / Query Name | Business Objective |
|---|---|---|
| 01 | Database & Schema Creation | Establish the relational database structure |
| 02 | Sample Data Insertion | Populate tables with sample bookstore records |
| 03 | Book Performance Analysis | Identify total units sold and revenue by book |
| 04 | Low Stock Inventory Alert | Identify books with stock below 15 units |
| 05 | Customer RFM Analysis | Calculate recency, frequency, and monetary value |
| 06 | Customer Revenue vs Marketing Spend | Compare customer revenue with acquisition expenditure |
| 07 | Monthly Sales Trend Analysis | Evaluate monthly revenue performance |
| 08 | Returning Customer Analysis | Identify customers with multiple orders |
| 09 | Average Order Value (AOV) | Calculate average revenue per order |
| 10 | Top 5 Books by Revenue | Rank books based on revenue generation |
| 11 | Cumulative Monthly Revenue | Calculate running total of monthly revenue |
| 12 | Month-over-Month Revenue Growth | Compare monthly revenue with the previous month |
| 13 | Above-Average Book Price Analysis | Identify books priced above the average |
| 14 | High-Spending Customer Analysis | Identify customers spending above the average |
| 15 | Customer Acquisition Trend | Analyze new customer registrations by month |
| 16 | Top-Selling Genre Analysis | Identify the highest-revenue genre each month |
| 17 | Customer Churn Analysis | Identify customers inactive for more than 365 days |

## Tools & Technologies

- **Database:** MySQL 8.0
- **SQL Environment:** MySQL Workbench
- **Query Language:** Structured Query Language (SQL)
- **Analytical Techniques:** Exploratory Data Analysis, Customer Segmentation, Revenue Analysis, Sales Trend Analysis, and Business Intelligence.

## Key Business Insights

The project is designed to generate actionable insights into:

- Book-level sales performance and revenue contribution.
- Inventory availability and low-stock identification.
- Customer purchasing frequency and lifetime revenue.
- Customer retention and potential churn identification.
- Monthly revenue trends and growth performance.
- Top-performing book genres.
- Marketing expenditure compared with customer-generated revenue.
- Customer acquisition and repeat-purchase behavior.

## Project Outcome

This project demonstrates the practical application of SQL in solving business-oriented analytical problems using relational datasets. It strengthens skills in database management, multi-table joins, aggregations, subqueries, CTEs, window functions, and customer analytics.

The project serves as a practical SQL portfolio demonstrating the ability to extract, transform, analyze, and interpret structured data to support data-driven business decisions.

## Repository Structure

```text
Bookstore-Sales-Customer-Intelligence-SQL/
│
├── SQL PROJECT.sql
└── README.md
```

## Author

**Viswas Manoharan**

Aspiring Data Analyst | Mathematics Graduate

**Technical Interests:** SQL | Python | Excel | Power BI | Data Analytics

