# Data Analysis with BigQuery

![BigQuery](https://img.shields.io/badge/BigQuery-Analytics-4285F4?logo=googlebigquery)
![SQL](https://img.shields.io/badge/SQL-Advanced-lightblue)
![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python)
![GCP](https://img.shields.io/badge/GCP-Cloud-4285F4?logo=googlecloud)
![License](https://img.shields.io/badge/License-MIT-green)

> Exploratory and business analytics on customer shopping data using BigQuery: advanced SQL (window functions, partitioning, clustering), schema management, and business insight extraction.

## Table of Contents
- [Dataset](#dataset)
- [Analysis Areas](#analysis-areas)
- [SQL Techniques](#sql-techniques)
- [Project Structure](#project-structure)
- [Setup](#setup)
- [Key Insights](#key-insights)

## Dataset
Customer shopping transactions dataset (~99K rows) with: customer demographics, product categories, purchase amounts, payment methods, and shopping frequency.

## Analysis Areas

| Analysis | Description |
|---|---|
| Revenue by product | Total sales aggregated by product category |
| Revenue by payment | Sales breakdown by payment method |
| Customer filtering | Multi-condition row filtering |
| Schema management | ALTER TABLE to add/modify columns |
| Partitioning & clustering | Cost-efficient table design |
| Average purchase | Mean spend per customer segment |

## SQL Techniques

```sql
-- Window function: running total spend per customer
SELECT customer_id, purchase_amount,
  SUM(purchase_amount) OVER (
    PARTITION BY customer_id
    ORDER BY invoice_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total
FROM customer_shopping.transactions;

-- Clustered + partitioned table for cost optimisation
CREATE TABLE customer_shopping.transactions_optimised
PARTITION BY DATE(invoice_date)
CLUSTER BY category, payment_method
AS SELECT * FROM customer_shopping.transactions;
```

## Project Structure
```
├── data/
│   └── customer_shopping_data.csv    # 99K transaction records
├── sql/
│   ├── total__sales_by_product.sql
│   ├── total_sales_by_payment_method.sql
│   ├── filtering_data.sql
│   ├── modify_table_schema.sql
│   ├── create_new_table_partitioning_clustering.sql
│   └── average_purchase_amount_by_customer.sql
├── docs/
│   ├── setup.md
│   ├── load_data.md
│   └── table_management.md
└── images/                           # Query result screenshots
```

## Setup
```bash
git clone https://github.com/jaiminbabariya7/Data-Analysis-BigQuery
# Upload data to BigQuery
bq load --autodetect --source_format=CSV \
  your_project:customer_shopping.transactions \
  data/customer_shopping_data.csv
```

## Skills Demonstrated
`BigQuery` · `Advanced SQL` · `Window Functions` · `Table Partitioning` · `Clustering` · `Data Analysis` · `GCP`
