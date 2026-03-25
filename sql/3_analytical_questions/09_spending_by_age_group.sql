-- Q4: Spending behavior across age groups
WITH age_group_basket_stats AS (
  SELECT
    d.age_desc AS age_group,
    b.household_key,
    b.basket_id,
    b.basket_value,
    PERCENTILE_CONT(b.basket_value, 0.5)
      OVER (PARTITION BY d.age_desc) AS median_basket_value
  FROM `final-project-dla.raw_data.basket_summary` b
  JOIN `final-project-dla.raw_data.hh_demographic_raw` d
    ON b.household_key = d.household_key
)
SELECT
  age_group,
  COUNT(DISTINCT household_key) AS total_households,
  COUNT(DISTINCT basket_id) AS total_baskets,
  ROUND(SUM(basket_value), 2) AS total_revenue,
  ROUND(AVG(basket_value), 2) AS avg_basket_value,
  ROUND(MAX(median_basket_value), 2) AS median_basket_value,
  ROUND(SUM(basket_value) / COUNT(DISTINCT household_key), 2) AS avg_revenue_per_household,
  ROUND(
    COUNT(DISTINCT basket_id) * 1.0 /
    COUNT(DISTINCT household_key),
    2
  ) AS avg_visits_per_household
FROM age_group_basket_stats
GROUP BY age_group
ORDER BY avg_basket_value DESC;