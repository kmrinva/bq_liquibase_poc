--liquibase formatted sql
--changeset poc-user:006_fact_sales labels:bigquery,ddl context:prod,dev
--comment: Create liquibase_fact_sales (transaction grain: one row per item per order)

CREATE TABLE IF NOT EXISTS `my_poc_dataset.liquibase_fact_sales`
(
  sales_id STRING OPTIONS(description="Surrogate fact row id (optional if using natural keys)"),
  order_id STRING OPTIONS(description="Business order id"),
  order_line INT64 OPTIONS(description="Line number within the order"),
  order_date DATE OPTIONS(description="Order date (business date)"),
  customer_id STRING OPTIONS(description="FK to liquibase_dim_customer.customer_id"),
  product_id STRING OPTIONS(description="FK to liquibase_dim_product.product_id"),
  store_id STRING OPTIONS(description="FK to liquibase_dim_store.store_id"),
  quantity INT64 OPTIONS(description="Units sold"),
  unit_price NUMERIC OPTIONS(description="Unit price at time of sale"),
  discount_amt NUMERIC OPTIONS(description="Monetary discount amount for the line"),
  tax_amt NUMERIC OPTIONS(description="Tax amount for the line"),
  net_sales NUMERIC OPTIONS(description="Net extended price = quantity*unit_price - discount + tax")
)
PARTITION BY order_date
CLUSTER BY customer_id, product_id
OPTIONS(description="Sales fact at item-line grain; partitioned by order_date and clustered by keys");

ALTER TABLE `my_poc_dataset.liquibase_fact_sales`
  ADD CONSTRAINT pk_liquibase_fact_sales PRIMARY KEY (sales_id) NOT ENFORCED;

ALTER TABLE `my_poc_dataset.liquibase_fact_sales`
  ADD CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES `my_poc_dataset.liquibase_dim_customer` (customer_id) NOT ENFORCED;

ALTER TABLE `my_poc_dataset.liquibase_fact_sales`
  ADD CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES `my_poc_dataset.liquibase_dim_product` (product_id) NOT ENFORCED;

ALTER TABLE `my_poc_dataset.liquibase_fact_sales`
  ADD CONSTRAINT fk_sales_store FOREIGN KEY (store_id) REFERENCES `my_poc_dataset.liquibase_dim_store` (store_id) NOT ENFORCED;

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_fact_sales`;
