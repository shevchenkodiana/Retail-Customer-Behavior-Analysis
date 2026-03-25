-- Q8: Coupon vs non-coupon household spending comparison
WITH coupon_households AS (
  SELECT DISTINCT household_key
  FROM `final-project-dla.raw_data.coupon_redempt_raw`
),
household_stats AS (
  SELECT
    b.household_key,
    COUNT(DISTINCT b.basket_id)           AS total_visits,
    ROUND(SUM(b.basket_value), 2)         AS total_spend,
    ROUND(AVG(b.basket_value), 2)         AS avg_basket_value,
    CASE
      WHEN c.household_key IS NOT NULL
      THEN 'Coupon'
      ELSE 'Non-Coupon'
    END                                   AS customer_type
  FROM `final-project-dla.raw_data.basket_summary` b
  LEFT JOIN coupon_households c
    ON b.household_key = c.household_key
  GROUP BY b.household_key, c.household_key
),
with_median AS (
  SELECT
    household_key,
    total_visits,
    total_spend,
    avg_basket_value,
    customer_type,
    PERCENTILE_CONT(avg_basket_value, 0.5)
      OVER (PARTITION BY customer_type)   AS median_basket_value
  FROM household_stats
)
SELECT
  customer_type,
  COUNT(DISTINCT household_key)           AS total_households,
  ROUND(AVG(total_visits), 1)             AS avg_visits,
  ROUND(AVG(total_spend), 2)              AS avg_total_spend,
  ROUND(AVG(avg_basket_value), 2)         AS avg_basket_value,
  ROUND(MAX(median_basket_value), 2)      AS median_basket_value,
  ROUND(SUM(total_spend), 2)              AS total_revenue,
  ROUND(SUM(total_spend) * 100.0 /
    SUM(SUM(total_spend)) OVER (), 2)     AS pct_of_total_revenue
FROM with_median
GROUP BY customer_type
ORDER BY customer_type DESC;