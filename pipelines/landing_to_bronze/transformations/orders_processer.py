from pyspark import pipelines as dp
from pyspark.sql import functions as F
from utls import options as opts, const_paths as path


@dp.table(
    name="lakeflow_ingestion.bronze.bronze_orders", 
    comment="Raw data CDC for orders from Volumes to Bronze layer, append only"
)
def bronze_orders():
    return (
        spark.readStream.format("cloudFiles")
            .options(**opts.cloud_options)
            .load(path.ORDERS_VOLUME_PATH)
            .withColumn("ingest_timestamp", F.current_timestamp())    
    )