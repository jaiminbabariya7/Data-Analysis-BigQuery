-- 00_create_typed_table.sql
-- The CSV stores invoice_date as DD/MM/YYYY, which BigQuery's autodetect
-- loads as STRING. Build the typed analysis table from the raw load:
-- real DATE column plus a line amount (price x quantity, Turkish lira).
CREATE OR REPLACE TABLE `PROJECT_ID.customer_data.customer_table` AS
SELECT
    invoice_no,
    customer_id,
    gender,
    age,
    category,
    quantity,
    price,
    ROUND(price * quantity, 2)              AS amount,
    payment_method,
    PARSE_DATE('%d/%m/%Y', invoice_date)    AS invoice_date,
    shopping_mall
FROM `PROJECT_ID.customer_data.raw_customer_table`;
