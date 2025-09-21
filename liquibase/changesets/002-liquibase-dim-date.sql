--liquibase formatted sql
--changeset poc-user:002_dim_date labels:bigquery,ddl context:prod,dev
--comment: Create liquibase_dim_date (calendar attributes)

CREATE TABLE IF NOT EXISTS `my_poc_dataset.liquibase_dim_date`
(
  date_key DATE OPTIONS(description="Business date (YYYY‑MM‑DD) – surrogate natural key"),
  day_of_week INT64 OPTIONS(description="ISO day of week (1=Mon … 7=Sun)"),
  day_name STRING OPTIONS(description="Localized day name, e.g., Monday"),
  week_of_year INT64 OPTIONS(description="ISO week number (1–53)"),
  month INT64 OPTIONS(description="Month number (1–12)"),
  month_name STRING OPTIONS(description="Localized month name, e.g., January"),
  quarter INT64 OPTIONS(description="Quarter number (1–4)"),
  year INT64 OPTIONS(description="Calendar year, e.g., 2025"),
  is_business_day BOOL OPTIONS(description="True if typical business day")
)
PARTITION BY date_key
OPTIONS(description="Date dimension with standard calendar attributes");

ALTER TABLE `${project_id}.${dataset}.liquibase_dim_date`
  ADD CONSTRAINT pk_liquibase_dim_date PRIMARY KEY(date_key) NOT ENFORCED;

--rollback DROP TABLE IF EXISTS `my_poc_dataset.liquibase_dim_date`;
