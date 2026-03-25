SELECT
  COUNT(*)                        AS total_rows,
  COUNTIF(household_key IS NULL)  AS null_household_key,
  COUNTIF(basket_id IS NULL)      AS null_basket_id,
  COUNTIF(DAY IS NULL)            AS null_day,
  COUNTIF(sales_value IS NULL)    AS null_sales_value,
  COUNTIF(quantity IS NULL)       AS null_quantity,
  COUNTIF(product_id IS NULL)     AS null_product_id
FROM final-project-dla.raw_data.transaction_data_raw;