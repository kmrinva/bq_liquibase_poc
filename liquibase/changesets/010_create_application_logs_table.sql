-- ============================================================================
-- Script 3: 010_create_application_logs_table.sql - VALID SYNTAX
-- ============================================================================

--liquibase formatted sql

--changeset author:mike.johnson id:010-create-application-logs-table
--comment: Create log table with 5 columns for application monitoring

CREATE TABLE `my_poc_dataset.liquibase_application_logs` (
  log_id STRING NOT NULL,
  log_level STRING NOT NULL,
  message STRING,
  source_application STRING,
  log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
PARTITION BY DATE(log_timestamp)
CLUSTER BY log_level, source_application
OPTIONS(
  description="Application logs for monitoring and debugging",
  labels=[("environment", "poc"), ("type", "logging")],
  partition_expiration_days=30
);

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_application_logs`;

--changeset author:mike.johnson id:003-insert-sample-log-data
--comment: Insert sample data into application logs table

INSERT INTO `my_poc_dataset.liquibase_application_logs` (log_id, log_level, message, source_application)
VALUES 
  ('LOG001', 'INFO', 'Application started successfully', 'web-api'),
  ('LOG002', 'ERROR', 'Database connection timeout', 'data-processor'),
  ('LOG003', 'WARN', 'High memory usage detected', 'analytics-engine'),
  ('LOG004', 'DEBUG', 'Processing user request', 'web-api'),
  ('LOG005', 'ERROR', 'Failed to process payment', 'payment-service');

-rollback DELETE FROM `my_poc_dataset.liquibase_application_logs` WHERE log_id IN ('LOG001', 'LOG002', 'LOG003', 'LOG004', 'LOG005');