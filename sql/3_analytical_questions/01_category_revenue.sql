-- Q1: Revenue and transaction volume by product category
SELECT
  p.department                                    AS category,
  COUNT(DISTINCT t.basket_id)                     AS total_baskets,
  ROUND(SUM(t.sales_value), 2)                    AS total_revenue,
  ROUND(SUM(t.sales_value) * 100.0 /
    SUM(SUM(t.sales_value)) OVER (), 2)           AS revenue_pct,
  ROUND(AVG(t.sales_value), 2)                    AS avg_item_value
FROM `final-project-dla.raw_data.transactions_clean` t
JOIN `final-project-dla.raw_data.product_raw` p
  ON t.product_id = p.product_id
GROUP BY p.department
ORDER BY total_revenue DESC;
