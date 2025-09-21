--liquibase formatted sql
--changeset poc-user:0005_dim_store labels:bigquery,ddl context:prod,dev
--comment: Create liquibase_dim_store (channels/locations)

CREATE TABLE IF NOT EXISTS `my_poc_dataset.liquibase_dim_store`
(
  store_id STRING OPTIONS(description="Store or channel id"),
  store_name STRING OPTIONS(description="Display name of store/channel"),
  channel STRING OPTIONS(description="Sales channel, e.g., ONLINE, RETAIL"),
  country STRING OPTIONS(description="Country/region"),
  state_province STRING OPTIONS(description="State or province code"),
  city STRING OPTIONS(description="City name"),
  open_date DATE OPTIONS(description="Opening/go-live date"),
  status STRING OPTIONS(description="Operational status, e.g., OPEN, CLOSED")
)
OPTIONS(description="Store/channel dimension for sales attribution");

ALTER TABLE `my_poc_dataset.liquibase_dim_store`
  ADD CONSTRAINT pk_liquibase_dim_store PRIMARY KEY(store_id) NOT ENFORCED;

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_dim_store`;
