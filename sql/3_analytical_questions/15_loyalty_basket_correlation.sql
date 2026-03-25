-- Q7: Loyalty basket correlation
WITH household_stats AS (
  SELECT
    household_key,
    COUNT(DISTINCT basket_id) AS total_visits,
    AVG(basket_value) AS avg_basket_value,
    SUM(basket_value) AS total_spend
  FROM `final-project-dla.raw_data.basket_summary`
  GROUP BY household_key
)
SELECT
  ROUND(CORR(total_visits, avg_basket_value), 4) AS corr_visits_vs_avg_basket,
  ROUND(CORR(total_visits, total_spend), 4) AS corr_visits_vs_total_spend
FROM household_stats;