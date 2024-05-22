SELECT customer_id, AVG(price * quantity) AS avg_purchase_amount
FROM data-analysis-bigquery-424100.customer_data.customer_table
GROUP BY customer_id;
