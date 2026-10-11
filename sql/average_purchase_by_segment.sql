-- Average and median purchase by gender and age band.
-- (Every customer_id appears once in this dataset, so per-customer averages
-- equal per-transaction values; segments are the meaningful grouping.)
SELECT
    gender,
    CASE
        WHEN age < 30 THEN '18-29'
        WHEN age < 45 THEN '30-44'
        WHEN age < 60 THEN '45-59'
        ELSE '60+'
    END                                                           AS age_band,
    COUNT(*)                                                      AS transactions,
    ROUND(AVG(amount), 2)                                         AS avg_purchase,
    APPROX_QUANTILES(amount, 2)[OFFSET(1)]                        AS median_purchase
FROM `PROJECT_ID.customer_data.customer_table`
GROUP BY gender, age_band
ORDER BY gender, age_band;
