CREATE OR REPLACE TABLE `final-project-dla.raw_data.tableau_transaction_level` AS
SELECT
  t.household_key,
  t.basket_id,
  t.product_id,
  t.day,
  t.sales_value,
  t.quantity,
  p.department                                AS category,
  p.commodity_desc,
  d.age_desc,
  d.income_desc,
  d.kid_category_desc,
  d.household_size_desc,
  d.marital_status_code,
  CASE
    WHEN c.household_key IS NOT NULL THEN 'Coupon'
    ELSE 'Non-Coupon'
  END                                         AS coupon_household
FROM `final-project-dla.raw_data.transactions_clean` t
LEFT JOIN `final-project-dla.raw_data.product_raw` p
  ON t.product_id = p.product_id
LEFT JOIN `final-project-dla.raw_data.hh_demographic_raw` d
  ON t.household_key = d.household_key
LEFT JOIN (
  SELECT DISTINCT household_key
  FROM `final-project-dla.raw_data.coupon_redempt_raw`
) c
  ON t.household_key = c.household_key;
