CREATE OR REPLACE TABLE `final-project-dla.raw_data.tableau_basket_level` AS
SELECT
  b.household_key,
  b.basket_id,
  b.day,
  b.basket_value,
  b.total_items,
  b.unique_products,
  d.age_desc,
  d.income_desc,
  d.kid_category_desc,
  d.household_size_desc,
  d.marital_status_code,
  CASE
    WHEN c.household_key IS NOT NULL THEN 'Coupon'
    ELSE 'Non-Coupon'
  END                                         AS coupon_household,
  CASE
    WHEN b.basket_value < 10   THEN '1. Under $10'
    WHEN b.basket_value < 20   THEN '2. $10-$20'
    WHEN b.basket_value < 50   THEN '3. $20-$50'
    WHEN b.basket_value < 100  THEN '4. $50-$100'
    ELSE                            '5. $100+'
  END                                         AS basket_value_tier
FROM `final-project-dla.raw_data.basket_summary` b
LEFT JOIN `final-project-dla.raw_data.hh_demographic_raw` d
  ON b.household_key = d.household_key
LEFT JOIN (
  SELECT DISTINCT household_key
  FROM `final-project-dla.raw_data.coupon_redempt_raw`
) c
  ON b.household_key = c.household_key;
