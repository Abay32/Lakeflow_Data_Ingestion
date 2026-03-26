import dlt
from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utls import options as op, const_paths as path



def create_stream(path: str): 
    return (
        spark.readStream.format("cloudFiles")\
            .options(**op.cloud_options) \
            .load(path) \
            .withColumn("ingestion_timestamp", F.current_timestamp())
    )

# Dynamically create a function for each table
@dp.table(name="lakeflow_ingestion.bronze.bronze_customers", comment="Raw customers CDC ingestion form volume, append-only")
#@dlt.expect_or_drop("valid_schema", "schema = 'customers'")
def bronze_customers():
    cust_path = path.CUSTOMERS_VOLUME_PATH  # volume path for customers
    return create_stream(cust_path)
 