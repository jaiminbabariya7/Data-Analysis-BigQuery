-- Partitioned + clustered copy: date filters prune partitions, and filters
-- on category / payment_method skip blocks inside each partition.
CREATE OR REPLACE TABLE `PROJECT_ID.customer_data.customer_table_optimised`
PARTITION BY invoice_date
CLUSTER BY category, payment_method
AS
SELECT * FROM `PROJECT_ID.customer_data.customer_table`;
