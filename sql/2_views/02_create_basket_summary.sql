CREATE OR REPLACE VIEW `final-project-dla.raw_data.basket_summary` AS
SELECT
  household_key,
  basket_id,
  DAY,
  ROUND(SUM(sales_value), 2)  AS basket_value,
  SUM(quantity)               AS total_items,
  COUNT(DISTINCT product_id)  AS unique_products
FROM `final-project-dla.raw_data.transactions_clean`
GROUP BY household_key, basket_id, DAY;
