-- Q7: Loyalty segmentation
WITH household_stats AS (
  SELECT
    household_key,
    COUNT(DISTINCT basket_id)     AS total_visits,
    ROUND(SUM(basket_value), 2)   AS total_spend,
    ROUND(AVG(basket_value), 2)   AS avg_basket_value
  FROM `final-project-dla.raw_data.basket_summary`
  GROUP BY household_key
),
percentiles AS (
  SELECT
    PERCENTILE_CONT(total_visits, 0.33) OVER () AS p33_visits,
    PERCENTILE_CONT(total_visits, 0.66) OVER () AS p66_visits
  FROM household_stats
  LIMIT 1
)
SELECT
  CASE
    WHEN h.total_visits >= (SELECT p66_visits FROM percentiles)
      THEN '3. High Loyalty'
    WHEN h.total_visits >= (SELECT p33_visits FROM percentiles)
      THEN '2. Mid Loyalty'
    ELSE
      '1. Low Loyalty'
  END                                           AS loyalty_tier,
  COUNT(DISTINCT h.household_key)               AS total_households,
  ROUND(AVG(h.total_visits), 1)                 AS avg_visits,
  ROUND(AVG(h.total_spend), 2)                  AS avg_total_spend,
  ROUND(AVG(h.avg_basket_value), 2)             AS avg_basket_value,
  ROUND(SUM(h.total_spend), 2)                  AS tier_total_revenue,
  ROUND(SUM(h.total_spend) * 100.0 /
    SUM(SUM(h.total_spend)) OVER (), 2)         AS pct_of_total_revenue
FROM household_stats h
GROUP BY loyalty_tier
ORDER BY loyalty_tier DESC;