-- Schema change: add a nullable discount column (existing rows stay NULL).
ALTER TABLE `PROJECT_ID.customer_data.customer_table`
ADD COLUMN IF NOT EXISTS discount FLOAT64;
