-- Multi-condition filter: 2022 card payments over 1,000 TL at one mall.
SELECT *
FROM `PROJECT_ID.customer_data.customer_table`
WHERE invoice_date BETWEEN DATE '2022-01-01' AND DATE '2022-12-31'
  AND payment_method IN ('Credit Card', 'Debit Card')
  AND amount > 1000
  AND shopping_mall = 'Kanyon';
