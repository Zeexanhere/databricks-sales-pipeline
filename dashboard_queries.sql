-- ============================================================
-- DATABRICKS SALES ANALYTICS DASHBOARD - SQL QUERIES
-- ============================================================
-- These 3 queries power the Sales Analytics Dashboard.
-- Each query reads from a Gold layer table and feeds
-- one visualization (chart) in the Lakeview Dashboard.
-- ============================================================


-- ------------------------------------------------------------
-- QUERY 1: Monthly Revenue Trend
-- Chart Type: Line Chart
-- X Axis: month | Y Axis: total_revenue (Sum)
-- Purpose: Shows how total revenue changes month over month.
--          Helps identify seasonal trends and growth patterns.
-- ------------------------------------------------------------
SELECT
    month,
    total_revenue,
    total_orders
FROM sales_db.gold_revenue_by_month
ORDER BY month;


-- ------------------------------------------------------------
-- QUERY 2: Top 10 Products by Revenue
-- Chart Type: Bar Chart
-- X Axis: product_name | Y Axis: total_revenue (Sum)
-- Purpose: Identifies best-selling products by total revenue.
--          Helps business focus on high-performing inventory.
-- ------------------------------------------------------------
SELECT
    product_name,
    total_revenue,
    total_units_sold
FROM sales_db.gold_revenue_by_product
ORDER BY total_revenue DESC
LIMIT 10;


-- ------------------------------------------------------------
-- QUERY 3: Top 10 Customers by Revenue
-- Chart Type: Bar Chart
-- X Axis: customer_name | Y Axis: total_revenue (Sum)
-- Purpose: Identifies most valuable customers by spend.
--          Helps prioritize customer retention efforts.
-- ------------------------------------------------------------
SELECT
    customer_name,
    total_revenue,
    total_orders
FROM sales_db.gold_revenue_by_customer
ORDER BY total_revenue DESC
LIMIT 10;
