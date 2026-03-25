SELECT
  COUNT(DISTINCT t.household_key)   AS total_households,
  COUNT(DISTINCT d.household_key)   AS households_with_demographics,
  ROUND(
    COUNT(DISTINCT d.household_key) / COUNT(DISTINCT t.household_key) * 100, 2
  )                                 AS demographic_coverage_pct
FROM `final-project-dla.raw_data.transaction_data_raw` t
LEFT JOIN `final-project-dla.raw_data.hh_demographic_raw` d
  ON t.household_key = d.household_key;
