-- Revenue and share of total by product category.
SELECT
    category,
    ROUND(SUM(amount), 2)                                         AS total_sales,
    ROUND(100 * SUM(amount) / SUM(SUM(amount)) OVER (), 1)        AS pct_of_total
FROM `PROJECT_ID.customer_data.customer_table`
GROUP BY category
ORDER BY total_sales DESC;
