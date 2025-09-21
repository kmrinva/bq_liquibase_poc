--liquibase formatted sql
--changeset poc-user:004_dim_product labels:bigquery,ddl context:prod,dev
--comment: Create liquibase_dim_product (product catalog)

CREATE TABLE IF NOT EXISTS `my_poc_dataset.liquibase_dim_product`
(
  product_id STRING OPTIONS(description="Product surrogate key (SKU or system id)"),
  product_name STRING OPTIONS(description="Business-facing product name"),
  category STRING OPTIONS(description="Product category, e.g., Accessories"),
  subcategory STRING OPTIONS(description="Product subcategory, e.g., Headphones"),
  brand STRING OPTIONS(description="Brand or manufacturer"),
  unit_price NUMERIC OPTIONS(description="List price in transaction currency"),
  currency STRING OPTIONS(description="ISO 4217 currency code, e.g., USD"),
  is_active BOOL OPTIONS(description="True if currently offered")
)
OPTIONS(description="Product dimension with category and pricing attributes");

ALTER TABLE `my_poc_dataset.liquibase_dim_product`
  ADD CONSTRAINT pk_liquibase_dim_product PRIMARY KEY(product_id) NOT ENFORCED;

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_dim_product`;
