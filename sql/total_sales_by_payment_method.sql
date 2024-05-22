SELECT payment_method, SUM(price * quantity) AS total_sales
FROM data-analysis-bigquery-424100.customer_data.customer_table
GROUP BY payment_method;
