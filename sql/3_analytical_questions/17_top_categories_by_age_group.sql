-- Q9: Popular categories by age group
WITH age_category_revenue AS (
  SELECT
    d.age_desc AS age_group,
    p.department AS category,
    SUM(t.sales_value) AS total_revenue
  FROM `final-project-dla.raw_data.transactions_clean` t
  JOIN `final-project-dla.raw_data.product_raw` p
    ON t.product_id = p.product_id
  JOIN `final-project-dla.raw_data.hh_demographic_raw` d
    ON t.household_key = d.household_key
  GROUP BY d.age_desc, p.department
)
SELECT
  age_group,
  category,
  ROUND(total_revenue, 2) AS total_revenue,
  ROUND(
    total_revenue * 100.0 /
    SUM(total_revenue) OVER (PARTITION BY age_group),
    2
  ) AS pct_of_group_revenue,
  RANK() OVER (
    PARTITION BY age_group
    ORDER BY total_revenue DESC
  ) AS category_rank
FROM age_category_revenue
QUALIFY category_rank <= 5
ORDER BY age_group, category_rank;