USE CATALOG `lakeflow_ingestion`;
USE SCHEMA `silver`;

-- Silver customer transformatin 
CREATE OR REFRESH MATERIALIZED VIEW silver_customers AS
SELECT 
    customer_id,
    name AS customer_name,
    email AS customer_email,
    phone AS customer_phone,
    MAX(time_stamp) as updated_at
FROM 
  lakeflow_ingestion.bronze.bronze_customers
WHERE lower(operation) != 'delete'
GROUP BY 1,2,3,4;