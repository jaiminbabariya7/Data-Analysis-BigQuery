CREATE TABLE data-analysis-bigquery-424100.customer_data.customer_table_2
PARTITION BY invoice_date
CLUSTER BY category
AS
SELECT * FROM data-analysis-bigquery-424100.customer_data.customer_table;
