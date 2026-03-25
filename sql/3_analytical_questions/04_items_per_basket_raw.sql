-- Q3: Items per basket
WITH stats AS (
  SELECT total_items
  FROM `final-project-dla.raw_data.basket_summary`
)
SELECT DISTINCT
  ROUND(AVG(total_items) OVER (), 2)                        AS avg_items_per_basket,
  ROUND(STDDEV(total_items) OVER (), 2)                     AS stddev_items,
  ROUND(MIN(total_items) OVER (), 2)                        AS min_items,
  ROUND(MAX(total_items) OVER (), 2)                        AS max_items,
  ROUND(PERCENTILE_CONT(total_items, 0.25) OVER (), 2)      AS p25,
  ROUND(PERCENTILE_CONT(total_items, 0.50) OVER (), 2)      AS median_items,
  ROUND(PERCENTILE_CONT(total_items, 0.75) OVER (), 2)      AS p75,
  ROUND(PERCENTILE_CONT(total_items, 0.90) OVER (), 2)      AS p90
FROM stats
LIMIT 1;