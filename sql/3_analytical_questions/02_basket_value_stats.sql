-- Q2: Basket value distribution
SELECT DISTINCT
  ROUND(AVG(basket_value) OVER (), 2)                        AS avg_basket_value,
  ROUND(STDDEV(basket_value) OVER (), 2)                     AS stddev_basket_value,
  ROUND(MIN(basket_value) OVER (), 2)                        AS min_basket_value,
  ROUND(MAX(basket_value) OVER (), 2)                        AS max_basket_value,
  ROUND(PERCENTILE_CONT(basket_value, 0.25) OVER (), 2)      AS p25,
  ROUND(PERCENTILE_CONT(basket_value, 0.50) OVER (), 2)      AS median_basket_value,
  ROUND(PERCENTILE_CONT(basket_value, 0.75) OVER (), 2)      AS p75,
  ROUND(PERCENTILE_CONT(basket_value, 0.90) OVER (), 2)      AS p90
FROM `final-project-dla.raw_data.basket_summary`
LIMIT 1;