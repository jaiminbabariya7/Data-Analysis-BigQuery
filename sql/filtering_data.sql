SELECT *
FROM data-analysis-bigquery-424100.customer_data.customer_table
WHERE invoice_date BETWEEN DATE('2023-01-01') AND DATE('2023-12-31');
