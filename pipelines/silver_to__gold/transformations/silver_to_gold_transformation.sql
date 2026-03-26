USE CATALOG lakeflow_ingestion;
USE SCHEMA gold;


--Create customers_sale table by joining silver_orders, and silver_customers tables. And, perform a bit of business aggregations 

CREATE OR REFRESH MATERIALIZED VIEW gold_customers_sales AS (
  SELECT
    ord.customer_id,
    cust.customer_name,
    SUM(ord.order_amount) AS total_revenu,
    COUNT(ord.order_id) AS total_orders,
    AVG(ord.order_amount) AS avg_order_values
  FROM lakeflow_ingestion.silver.silver_orders ord
  JOIN lakeflow_ingestion.silver.silver_customers cust 
    ON ord.customer_id = cust.customer_id
  GROUP BY 1,2
  ORDER BY total_revenu DESC
)