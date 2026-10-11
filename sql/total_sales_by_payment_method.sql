-- Transactions and revenue share by payment method.
SELECT
    payment_method,
    COUNT(*)                                                      AS transactions,
    ROUND(SUM(amount), 2)                                         AS total_sales,
    ROUND(100 * SUM(amount) / SUM(SUM(amount)) OVER (), 1)        AS pct_of_revenue
FROM `PROJECT_ID.customer_data.customer_table`
GROUP BY payment_method
ORDER BY total_sales DESC;
