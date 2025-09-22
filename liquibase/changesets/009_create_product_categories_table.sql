-- ============================================================================
-- Script 2: 009_create_product_categories_table.sql - INVALID SYNTAX
-- ============================================================================

--liquibase formatted sql

--changeset author:jane.smith id:009-create-product-categories-table
--comment: Create reference table with 3 columns for product categories

CREATE TABLE `my_poc_migrations.liquibase_product_categories` (
  category_id STRING NOT NULL,
  category_name STRING NOT NULL,
  description STRING
)
PARTITION BY category_id  -- ERROR: Cannot partition by STRING column
CLUSTER BY invalid_column  -- ERROR: Column doesn't exist
OPTIONS(
  description="Product category reference table"
  labels=[("environment", "poc")]  -- ERROR: Missing comma before labels
);

-- Additional syntax error in INSERT
INSERT INTO `my_poc_migrations.product_categories` 
VALUES 
  ('CAT001', 'Electronics', 'Electronic devices and accessories'),
  ('CAT002', 'Clothing', 'Apparel and fashion items'),
  ('CAT003', 'Home & Garden' 'Home improvement and gardening supplies');  -- ERROR: Missing comma

--rollback DROP TABLE IF EXISTS `my_poc_migrations.liquibase_product_categories`;