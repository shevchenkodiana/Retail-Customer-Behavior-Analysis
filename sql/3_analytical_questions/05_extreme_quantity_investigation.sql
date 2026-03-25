-- Q3: Find all products with suspiciously high quantities
SELECT
  t.product_id,
  p.department,
  p.commodity_desc,
  MAX(t.quantity)                     AS max_quantity,
  ROUND(AVG(t.quantity), 2)           AS avg_quantity,
  ROUND(AVG(t.sales_value / 
    NULLIF(t.quantity, 0)), 4)        AS avg_price_per_unit,
  COUNT(*)                            AS row_count
FROM `final-project-dla.raw_data.transactions_clean` t
JOIN `final-project-dla.raw_data.product_raw` p
  ON t.product_id = p.product_id
WHERE t.quantity > 100
GROUP BY t.product_id, p.department, p.commodity_desc
ORDER BY max_quantity DESC
LIMIT 30;