SELECT
  COUNT(DISTINCT t.product_id)                    AS total_products_in_transactions,
  COUNT(DISTINCT p.product_id)                    AS matched_products_in_product_table,
  COUNT(DISTINCT t.product_id) - 
  COUNT(DISTINCT p.product_id)                    AS unmatched_products
FROM `final-project-dla.raw_data.transaction_data_raw` t
LEFT JOIN `final-project-dla.raw_data.product_raw` p
  ON t.product_id = p.product_id;