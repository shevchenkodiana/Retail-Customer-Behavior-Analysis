SELECT COUNT(*) AS total_duplicate_rows
FROM (
  SELECT household_key, basket_id, product_id, DAY, COUNT(*) AS occurrences
  FROM final-project-dla.raw_data.transaction_data_raw
  GROUP BY household_key, basket_id, product_id, DAY
  HAVING COUNT(*) > 1
);