-- window_functions.sql

-- 1. Monthly revenue with a running total per year and month-over-month growth
WITH monthly AS (
    SELECT
        DATE_TRUNC(invoice_date, MONTH)  AS month,
        SUM(amount)                      AS revenue
    FROM `PROJECT_ID.customer_data.customer_table`
    GROUP BY month
)
SELECT
    month,
    ROUND(revenue, 2)                                                      AS revenue,
    ROUND(SUM(revenue) OVER (PARTITION BY EXTRACT(YEAR FROM month)
                             ORDER BY month
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2)
                                                                           AS ytd_revenue,
    ROUND(100 * SAFE_DIVIDE(revenue - LAG(revenue) OVER (ORDER BY month),
                            LAG(revenue) OVER (ORDER BY month)), 1)        AS mom_growth_pct
FROM monthly
ORDER BY month;

-- 2. Category ranking and share of revenue inside each mall
SELECT
    shopping_mall,
    category,
    ROUND(SUM(amount), 2)                                                  AS revenue,
    RANK() OVER (PARTITION BY shopping_mall ORDER BY SUM(amount) DESC)     AS rank_in_mall,
    ROUND(100 * SUM(amount) / SUM(SUM(amount)) OVER (PARTITION BY shopping_mall), 1)
                                                                           AS pct_of_mall
FROM `PROJECT_ID.customer_data.customer_table`
GROUP BY shopping_mall, category
QUALIFY rank_in_mall <= 3
ORDER BY shopping_mall, rank_in_mall;
