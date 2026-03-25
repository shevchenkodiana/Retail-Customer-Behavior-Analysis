-- Q6: Category preferences by kids composition
WITH kid_households AS (
  SELECT
    t.basket_id,
    t.product_id,
    t.sales_value,
    d.kid_category_desc                               AS kid_category
  FROM `final-project-dla.raw_data.transactions_clean` t
  JOIN `final-project-dla.raw_data.hh_demographic_raw` d
    ON t.household_key = d.household_key
),
category_revenue AS (
  SELECT
    kid_category,
    p.department                                      AS category,
    ROUND(SUM(sales_value), 2)                        AS total_revenue,
    ROUND(SUM(sales_value) * 100.0 /
      SUM(SUM(sales_value)) OVER 
      (PARTITION BY kid_category), 2)                 AS pct_of_group_revenue
  FROM kid_households k
  JOIN `final-project-dla.raw_data.product_raw` p
    ON k.product_id = p.product_id
  GROUP BY kid_category, p.department
)
SELECT
  kid_category,
  category,
  total_revenue,
  pct_of_group_revenue,
  RANK() OVER (
    PARTITION BY kid_category
    ORDER BY total_revenue DESC
  )                                                   AS revenue_rank
FROM category_revenue
WHERE pct_of_group_revenue >= 1.0
ORDER BY kid_category, revenue_rank;