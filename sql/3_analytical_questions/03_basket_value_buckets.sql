-- Q2: Basket value buckets
SELECT
  CASE
    WHEN basket_value < 5        THEN '1. Under $5'
    WHEN basket_value < 10       THEN '2. $5–$10'
    WHEN basket_value < 20       THEN '3. $10–$20'
    WHEN basket_value < 30       THEN '4. $20–$30'
    WHEN basket_value < 50       THEN '5. $30–$50'
    WHEN basket_value < 75       THEN '6. $50–$75'
    WHEN basket_value < 100      THEN '7. $75–$100'
    ELSE                              '8. $100+'
  END                                              AS basket_size_bucket,
  COUNT(*)                                         AS basket_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_baskets,
  ROUND(AVG(basket_value), 2)                      AS avg_value_in_bucket
FROM `final-project-dla.raw_data.basket_summary`
GROUP BY basket_size_bucket
ORDER BY basket_size_bucket;