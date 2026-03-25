SELECT 'transaction_data' AS table_name, COUNT(*) AS row_count
FROM final-project-dla.raw_data.transaction_data_raw
UNION ALL
SELECT 'product', COUNT(*)
FROM final-project-dla.raw_data.product_raw
UNION ALL
SELECT 'hh_demographic', COUNT(*)
FROM final-project-dla.raw_data.hh_demographic_raw
UNION ALL
SELECT 'campaign_table', COUNT(*)
FROM final-project-dla.raw_data.campaign_table_raw
UNION ALL
SELECT 'coupon_redempt', COUNT(*)
FROM final-project-dla.raw_data.coupon_redempt_raw;
