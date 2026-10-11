# Data Analysis with BigQuery

![BigQuery](https://img.shields.io/badge/BigQuery-Analytics-4285F4?logo=googlebigquery)
![SQL](https://img.shields.io/badge/SQL-Window%20Functions-lightblue)
![GCP](https://img.shields.io/badge/GCP-Cloud-4285F4?logo=googlecloud)
![License](https://img.shields.io/badge/License-MIT-green)

> Exploratory and business analysis of retail transactions in BigQuery: loading and typing raw CSV data, aggregations, window functions, schema changes, and a partitioned + clustered table for cheaper queries.

## Table of Contents
- [Dataset](#dataset)
- [Analysis Areas](#analysis-areas)
- [SQL Techniques](#sql-techniques)
- [Key Insights](#key-insights)
- [Project Structure](#project-structure)
- [Setup](#setup)

## Dataset
Public retail dataset of **99,457 transactions** from **10 shopping malls in Istanbul**, January 2021 to 8 March 2023, committed as `data/customer_shopping_data.csv`. Columns: invoice and customer IDs, gender, age, category, quantity, price (Turkish lira), payment method, invoice date (DD/MM/YYYY) and mall. Every `customer_id` appears exactly once.

## Analysis Areas

| File | What it does |
|---|---|
| `00_create_typed_table.sql` | Builds the analysis table from the raw load: parses the DD/MM/YYYY date (autodetect leaves it as STRING) and adds `amount = price × quantity` |
| `total_sales_by_category.sql` | Revenue and share of total per category |
| `total_sales_by_payment_method.sql` | Transactions and revenue share per payment method |
| `average_purchase_by_segment.sql` | Average and median purchase by gender and age band |
| `filtering_data.sql` | Multi-condition filter (date range, payment method, amount, mall) |
| `modify_table_schema.sql` | `ALTER TABLE ... ADD COLUMN` |
| `create_new_table_partitioning_clustering.sql` | Copy partitioned by `invoice_date`, clustered by `category, payment_method` |
| `window_functions.sql` | Monthly revenue with year-to-date running total and MoM growth; top-3 categories per mall with `RANK` and share of mall revenue |

## SQL Techniques

```sql
-- Year-to-date running total and month-over-month growth (window_functions.sql)
SUM(revenue) OVER (PARTITION BY EXTRACT(YEAR FROM month)
                   ORDER BY month
                   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ytd_revenue,
ROUND(100 * SAFE_DIVIDE(revenue - LAG(revenue) OVER (ORDER BY month),
                        LAG(revenue) OVER (ORDER BY month)), 1)       AS mom_growth_pct

-- Partitioned + clustered table for cost optimisation
CREATE OR REPLACE TABLE `PROJECT_ID.customer_data.customer_table_optimised`
PARTITION BY invoice_date
CLUSTER BY category, payment_method
AS SELECT * FROM `PROJECT_ID.customer_data.customer_table`;
```

## Key Insights
Computed from the committed CSV with the queries in `sql/`.

- **Three categories carry the business:** Clothing 45.3%, Shoes 26.5% and Technology 23.0% of revenue (94.8% combined); the other five categories add up to 5.2%.
- **Cash still leads:** 44.9% of revenue, then credit card 35.0% and debit card 20.1%.
- **Two malls ≈ 40% of revenue:** Mall of Istanbul (20.2%) and Kanyon (20.1%).
- **Skewed baskets:** average purchase ≈ 2,529 TL but the median is ≈ 600 TL, pulled up by high-priced Technology and Shoes lines.
- **Gender changes volume, not basket size:** women make 59.8% of transactions, but average spend is almost identical (≈ 2,525 TL vs ≈ 2,534 TL).
- **Flat year over year:** ≈ 114.6M TL in 2021 vs ≈ 115.4M TL in 2022 (2023 covers only Jan to early March).
- **Limitation:** each customer appears once, so repeat-purchase or customer-lifetime analysis isn't possible with this data.

## Project Structure
```
├── data/
│   └── customer_shopping_data.csv    # 99,457 transactions
├── sql/                              # queries listed above (PROJECT_ID placeholder)
├── docs/
│   ├── setup.md
│   ├── load_data.md
│   └── table_management.md
├── images/                           # BigQuery console screenshots from the first run (ALTER TABLE, partitioned copy)
├── Makefile                          # make load / make run
└── .sqlfluff                         # SQL lint config (BigQuery dialect)
```

## Setup
```bash
git clone https://github.com/jaiminbabariya7/Data-Analysis-BigQuery
cd Data-Analysis-BigQuery

# Load the CSV into customer_data.raw_customer_table and build the typed table
make load PROJECT_ID=your-project

# Run the analysis queries
make run PROJECT_ID=your-project
```

## Skills Demonstrated
`BigQuery` · `SQL` · `Window Functions` · `Table Partitioning` · `Clustering` · `Schema Management` · `Data Analysis` · `GCP`
