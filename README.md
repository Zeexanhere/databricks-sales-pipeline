# 🏭 Databricks Sales Analytics Pipeline

A complete end-to-end data engineering pipeline built on **Databricks Community Edition** using the **Medallion Architecture** (Bronze → Silver → Gold). This project covers all core Databricks concepts including Delta Lake, PySpark, SQL, Workflows, Dashboards, and Git Integration.

---

## 📌 Project Overview

| Component | Details |
|-----------|---------|
| **Platform** | Databricks Community Edition |
| **Language** | Python (PySpark), SQL |
| **Dataset** | Databricks Built-in `retail-org/sales_orders` |
| **Architecture** | Medallion (Bronze → Silver → Gold) |
| **Storage Format** | Delta Lake |
| **Orchestration** | Databricks Workflows |
| **Version Control** | GitHub |

---

## 🗂️ Project Structure

```
databricks-sales-pipeline/
│
├── 01_Bronze.ipynb          # Raw data ingestion → Delta table
├── 02_Silver.ipynb          # Data cleaning & transformation
├── 03_Gold.ipynb            # Aggregations & business metrics
├── 04_Delta_Features.ipynb  # Delta Lake features (Time Travel, Optimize, Vacuum)
└── README.md
```

---

## 🏗️ Architecture

```
Raw JSON Data (retail-org/sales_orders)
            │
            ▼
    ┌──────────────┐
    │    BRONZE    │  → Raw data saved as Delta table (no changes)
    └──────────────┘
            │
            ▼
    ┌──────────────┐
    │    SILVER    │  → Cleaned, flattened, enriched data
    └──────────────┘
            │
            ▼
    ┌──────────────┐
    │     GOLD     │  → Aggregated business-ready metrics
    └──────────────┘
            │
            ▼
    ┌──────────────┐
    │  DASHBOARD   │  → Visual insights (Databricks SQL)
    └──────────────┘
            │
            ▼
    ┌──────────────┐
    │   WORKFLOW   │  → Automated scheduled pipeline
    └──────────────┘
```

---

## 📓 Notebooks

### 01_Bronze — Raw Ingestion
- Reads raw JSON sales data from `/databricks-datasets/retail-org/sales_orders/`
- Creates `sales_db` database in Hive Metastore
- Saves raw data as-is to `sales_db.bronze_sales_orders` Delta table
- No transformations — preserves original data as source of truth

### 02_Silver — Cleaning & Transformation
- Loads from Bronze Delta table
- Explodes nested `ordered_products` array (one row per product per order)
- Converts Unix timestamp to readable datetime using `from_unixtime`
- Handles null and empty values safely using `nullif`
- Adds calculated column: `line_total = price × quantity`
- Drops duplicates and null records
- Saves to `sales_db.silver_sales_orders` Delta table

### 03_Gold — Aggregations
Creates 3 business-ready Gold tables:

| Table | Description |
|-------|-------------|
| `gold_revenue_by_customer` | Total revenue and order count per customer |
| `gold_revenue_by_product` | Total revenue and units sold per product |
| `gold_revenue_by_month` | Monthly revenue trend over time |

### 04_Delta_Features — Delta Lake Exploration
- `DESCRIBE HISTORY` — view full transaction log of a table
- `VERSION AS OF` — query historical versions (Time Travel)
- `OPTIMIZE` — compact small files for better query performance
- `VACUUM` — remove old files no longer needed by Delta

---

## 🗄️ Database & Tables

```
sales_db
├── bronze_sales_orders        (raw)
├── silver_sales_orders        (clean)
├── gold_revenue_by_customer   (aggregated)
├── gold_revenue_by_product    (aggregated)
└── gold_revenue_by_month      (aggregated)
```

---

## 📊 Dashboard

Built in **Databricks SQL Lakeview Dashboard** with 3 visualizations:
- 📈 **Line Chart** — Monthly Revenue Trend (`gold_revenue_by_month`)
- 📊 **Bar Chart** — Top 10 Products by Revenue (`gold_revenue_by_product`)
- 📊 **Bar Chart** — Top 10 Customers by Revenue (`gold_revenue_by_customer`)

---

## ⚙️ Workflow (Sales Pipeline Job)

Automated pipeline with 3 tasks running in sequence:

```
Bronze Task → Silver Task → Gold Task
```

Each task depends on the previous one completing successfully. Can be triggered manually or on a schedule.

---

## 🔑 Key Databricks Concepts Covered

- ✅ Cluster creation and management
- ✅ Notebook development (Python + SQL magic commands)
- ✅ PySpark DataFrames — read, transform, write
- ✅ Delta Lake — ACID transactions, transaction log
- ✅ Delta Time Travel — `VERSION AS OF`
- ✅ Medallion Architecture — Bronze, Silver, Gold
- ✅ Hive Metastore — databases and managed tables
- ✅ Databricks SQL — queries and visualizations
- ✅ Lakeview Dashboards
- ✅ Workflows & Jobs — multi-task orchestration
- ✅ Repos — Git integration with GitHub
- ✅ DBFS — Databricks File System

---

## 🚀 How to Run

1. Clone this repo into your Databricks workspace via **Repos**
2. Create a cluster (any single-node cluster works)
3. Run notebooks in order: `01_Bronze` → `02_Silver` → `03_Gold` → `04_Delta_Features`
4. Or use the **Sales Pipeline** Workflow job to run all automatically

---

## 👤 Author

**Zeeshan Ahmed**  
Built on Databricks Community Edition — February 2026
