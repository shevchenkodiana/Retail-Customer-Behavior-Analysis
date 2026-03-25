-- Q3: Investigate extreme quantity rows
SELECT
  t.household_key,
  t.basket_id,
  t.product_id,
  p.department,
  p.commodity_desc,
  t.quantity,
  t.sales_value,
  ROUND(t.sales_value / NULLIF(t.quantity, 0), 4)  AS price_per_unit,
  t.DAY
FROM `final-project-dla.raw_data.transactions_clean` t
JOIN `final-project-dla.raw_data.product_raw` p
  ON t.product_id = p.product_id
WHERE t.quantity > 500
ORDER BY t.quantity DESC
LIMIT 20;