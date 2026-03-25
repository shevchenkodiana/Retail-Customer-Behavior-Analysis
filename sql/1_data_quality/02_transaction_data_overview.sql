SELECT
  COUNT(*)                                    AS total_rows,
  COUNT(DISTINCT household_key)               AS unique_customers,
  COUNT(DISTINCT basket_id)                   AS unique_baskets,
  MIN(DAY)                                    AS first_day,
  MAX(DAY)                                    AS last_day,
  MAX(DAY) - MIN(DAY)                         AS observation_window_days,
  ROUND(SUM(sales_value), 2)                  AS total_revenue,
  ROUND(AVG(sales_value), 2)                  AS avg_transaction_value
FROM final-project-dla.raw_data.transaction_data_raw;