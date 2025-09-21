--liquibase formatted sql
--changeset poc-user:003_dim_customer labels:bigquery,ddl context:prod,dev
--comment: Create liquibase_dim_customer (customer master)

CREATE TABLE IF NOT EXISTS `my_poc_dataset.liquibase_dim_customer`
(
  customer_id STRING OPTIONS(description="Customer surrogate key (UUID or system id)"),
  customer_name STRING OPTIONS(description="Customer full display name"),
  email STRING OPTIONS(description="Primary contact email"),
  phone STRING OPTIONS(description="Primary contact phone"),
  country STRING OPTIONS(description="Country/region"),
  state_province STRING OPTIONS(description="State or province code"),
  city STRING OPTIONS(description="City name"),
  postal_code STRING OPTIONS(description="Postal/ZIP code"),
  customer_since DATE OPTIONS(description="First purchase or onboarding date")
  status STRING OPTIONS(description="Lifecycle status, e.g., ACTIVE, INACTIVE")
)
OPTIONS(description="Customer dimension with contact and geography attributes");

ALTER TABLE `my_poc_dataset.liquibase_dim_customer`
  ADD CONSTRAINT pk_liquibase_dim_customer PRIMARY KEY(customer_id) NOT ENFORCED;

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_dim_customer`;
