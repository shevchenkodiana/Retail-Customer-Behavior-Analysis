-- Q7: Top households by spend
SELECT
  b.household_key,
  COUNT(DISTINCT b.basket_id)                       AS total_visits,
  ROUND(SUM(b.basket_value), 2)                     AS total_spend,
  ROUND(AVG(b.basket_value), 2)                     AS avg_basket_value,
  ROUND(MAX(b.basket_value), 2)                     AS max_basket_value,
  ROUND(MIN(b.basket_value), 2)                     AS min_basket_value,
  MIN(b.day)                                        AS first_visit_day,
  MAX(b.day)                                        AS last_visit_day,
  MAX(b.day) - MIN(b.day)                           AS active_days
FROM `final-project-dla.raw_data.basket_summary` b
GROUP BY b.household_key
ORDER BY total_spend DESC
LIMIT 20;