-- ============================================================================
-- Script 1: 008_create_sales_reporting_table.sql - VALID SYNTAX
-- ============================================================================

--liquibase formatted sql

--changeset author:john.doe id:008-create-sales-reporting-table
--comment: Create flat reporting table with 7 columns for sales analytics

CREATE TABLE `my_poc_migrations.liquibase_sales_reporting` (
  report_id STRING NOT NULL,
  customer_id STRING NOT NULL,
  product_name STRING,
  sale_amount NUMERIC(10,2),
  sale_date DATE,
  region STRING,
  created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
PARTITION BY sale_date
CLUSTER BY region, customer_id
OPTIONS(
  description="Sales reporting table for analytics and dashboards",
  labels=[("environment", "poc"), ("team", "analytics")]
);

--rollback DROP TABLE IF EXISTS `my_poc_migrations.liquibase_sales_reporting`;
