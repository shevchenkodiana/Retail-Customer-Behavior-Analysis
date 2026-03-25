-- Q9: Popular categories by income group
WITH income_category_revenue AS (
  SELECT
    d.income_desc AS income_group,
    p.department AS category,
    SUM(t.sales_value) AS total_revenue
  FROM `final-project-dla.raw_data.transactions_clean` t
  JOIN `final-project-dla.raw_data.product_raw` p
    ON t.product_id = p.product_id
  JOIN `final-project-dla.raw_data.hh_demographic_raw` d
    ON t.household_key = d.household_key
  GROUP BY d.income_desc, p.department
)
SELECT
  income_group,
  category,
  ROUND(total_revenue, 2) AS total_revenue,
  ROUND(
    total_revenue * 100.0 /
    SUM(total_revenue) OVER (PARTITION BY income_group),
    2
  ) AS pct_of_group_revenue,
  RANK() OVER (
    PARTITION BY income_group
    ORDER BY total_revenue DESC
  ) AS category_rank
FROM income_category_revenue
QUALIFY category_rank <= 5
ORDER BY income_group, category_rank;