-- Q3: most often categories excluding KIOSK-GAS and MISC SALES TRAN from item counts
WITH large_baskets AS (
  SELECT basket_id
  FROM (
    SELECT
      t.basket_id,
      SUM(t.quantity) AS adjusted_items
    FROM `final-project-dla.raw_data.transactions_clean` t
    JOIN `final-project-dla.raw_data.product_raw` p
      ON t.product_id = p.product_id
    WHERE p.department NOT IN ('KIOSK-GAS', 'MISC SALES TRAN')
    GROUP BY t.basket_id
  )
  WHERE adjusted_items > 17
)
SELECT
  p.department                                                AS category,
  COUNT(DISTINCT t.basket_id)                                 AS appearances_in_large_baskets,
  ROUND(COUNT(DISTINCT t.basket_id) * 100.0 /
    SUM(COUNT(DISTINCT t.basket_id)) OVER (), 2)              AS pct_of_large_baskets,
  ROUND(AVG(t.sales_value), 2)                                AS avg_item_value
FROM `final-project-dla.raw_data.transactions_clean` t
JOIN `final-project-dla.raw_data.product_raw` p
  ON t.product_id = p.product_id
JOIN large_baskets lb
  ON t.basket_id = lb.basket_id
WHERE p.department NOT IN ('KIOSK-GAS', 'MISC SALES TRAN')
GROUP BY p.department
HAVING COUNT(DISTINCT t.basket_id) >= 1000
ORDER BY appearances_in_large_baskets DESC;