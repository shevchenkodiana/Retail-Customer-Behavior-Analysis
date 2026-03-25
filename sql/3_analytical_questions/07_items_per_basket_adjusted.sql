-- Q3 revised: exclude KIOSK-GAS and MISC SALES TRAN from item counts
WITH stats AS (
  SELECT
    t.basket_id,
    SUM(t.quantity) AS adjusted_items
  FROM `final-project-dla.raw_data.transactions_clean` t
  JOIN `final-project-dla.raw_data.product_raw` p
    ON t.product_id = p.product_id
  WHERE p.department NOT IN ('KIOSK-GAS', 'MISC SALES TRAN')
  GROUP BY t.basket_id
)
SELECT DISTINCT
  ROUND(AVG(adjusted_items) OVER (), 2)                      AS avg_items_per_basket,
  ROUND(STDDEV(adjusted_items) OVER (), 2)                   AS stddev_items,
  ROUND(MIN(adjusted_items) OVER (), 2)                      AS min_items,
  ROUND(MAX(adjusted_items) OVER (), 2)                      AS max_items,
  ROUND(PERCENTILE_CONT(adjusted_items, 0.25) OVER (), 2)    AS p25,
  ROUND(PERCENTILE_CONT(adjusted_items, 0.50) OVER (), 2)    AS median_items,
  ROUND(PERCENTILE_CONT(adjusted_items, 0.75) OVER (), 2)    AS p75,
  ROUND(PERCENTILE_CONT(adjusted_items, 0.90) OVER (), 2)    AS p90
FROM stats
LIMIT 1;