--liquibase formatted sql
--changeset poc-user:007_bad_table labels:bigquery,ddl context:poc
--comment: Create liquibase_bad_table

CREATE TABLE IF NOT EXISTS `my_poc_dataset.liquibase_bad_table`
(
  bad_id STRING OPTIONS(description="Surrogate bad row id (optional if using natural keys)"),
  order_id STRING OPTIONS(description="Business order id"),
  order_line INT64 OPTIONS(description="Line number within the order"),
  order_date DATE OPTIONS(description="Order date (business date)"),
  customer_id STRING OPTIONS(description="FK to liquibase_dim_customer.customer_id"),
  product_id STRING OPTIONS(description="FK to liquibase_dim_product.product_id"),
)
PARTITION BY order_date
CLUSTER BY customer_id, product_id
OPTIONS(description="Bad fact at item-line grain; partitioned by order_date and clustered by keys");

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_bad_table`;
