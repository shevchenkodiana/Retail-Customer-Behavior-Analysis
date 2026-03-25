SELECT
  -- Sales value flags
  COUNTIF(sales_value < 0)                                    AS negative_sales,
  COUNTIF(sales_value = 0)                                    AS zero_sales,
  COUNTIF(quantity <= 0)                                      AS zero_or_negative_quantity,

  -- Value range
  ROUND(MIN(sales_value), 2)                                  AS min_sales_value,
  ROUND(MAX(sales_value), 2)                                  AS max_sales_value,
  MAX(quantity)                                               AS max_quantity,

  -- Breakdown of zero/negative combinations
  COUNTIF(sales_value = 0 AND quantity <= 0)                  AS zero_sales_and_zero_qty,
  COUNTIF(sales_value = 0 AND quantity > 0)                   AS zero_sales_positive_qty,
  COUNTIF(sales_value > 0 AND quantity <= 0)                  AS positive_sales_non_positive_qty,

  -- Total rows for reference
  COUNT(*)                                                    AS total_rows
FROM `final-project-dla.raw_data.transaction_data_raw`;