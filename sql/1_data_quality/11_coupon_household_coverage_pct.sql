SELECT
  COUNT(DISTINCT t.household_key) AS total_households,
  COUNT(DISTINCT r.household_key) AS coupon_households,
  ROUND(
    COUNT(DISTINCT r.household_key) / COUNT(DISTINCT t.household_key) * 100, 2
  ) AS coupon_household_pct
FROM `final-project-dla.raw_data.transaction_data_raw` t
LEFT JOIN `final-project-dla.raw_data.coupon_redempt_raw` r
  ON t.household_key = r.household_key;