SELECT
  COUNT(*)                        AS total_redemptions,
  COUNT(DISTINCT household_key)   AS unique_households,
  COUNT(DISTINCT campaign)        AS unique_campaigns
FROM `final-project-dla.raw_data.coupon_redempt_raw`;