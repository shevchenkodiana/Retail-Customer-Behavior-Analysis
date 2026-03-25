SELECT
  COUNT(DISTINCT household_key)           AS households_with_demographics,
  COUNTIF(age_desc IS NULL)               AS null_age,
  COUNTIF(income_desc IS NULL)            AS null_income,
  COUNTIF(household_size_desc IS NULL)    AS null_household_size,
  COUNTIF(marital_status_code IS NULL)    AS null_marital_status
FROM final-project-dla.raw_data.hh_demographic_raw;