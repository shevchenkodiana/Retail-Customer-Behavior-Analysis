SELECT
  household_key,
  COUNT(*) AS occurrences
FROM final-project-dla.raw_data.hh_demographic_raw
GROUP BY household_key
HAVING COUNT(*) > 1;