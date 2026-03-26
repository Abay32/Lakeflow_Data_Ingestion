use catalog `lakeflow_ingestion`;
use schema `silver`;

-- Silver Orders 
CREATE OR REFRESH MATERIALIZED VIEW silver_orders AS (
  SELECT 
    order_id,
    customer_id,
    cast(order_amount as decimal(10,2)) as order_amount,
    order_status,
    max(ts) as updated_at
  FROM lakeflow_ingestion.bronze.bronze_orders
  WHERE lower(operation) != 'delete'
  GROUP BY 1,2,3,4
)