# 📉 Institutional FX Volatility Analytics Engine (USD/NGN)
**A BigQuery & Power BI Macro Risk Architecture (2022–2026)**

---

## 🎯 Project Overview
This project engineers an institutional-grade risk monitoring architecture to analyze and visualize the historical volatility regimes of the Nigerian Naira (NGN) against the US Dollar (USD). By offloading heavy analytical calculations to Google BigQuery and designing a dynamic semantic layer in Power BI, this engine isolates macro risk regimes, identifies structural tail-risk anomalies, and provides portfolio managers with an interactive toolkit for currency risk assessment.

## 🛠️ Tech Stack & Architecture
* **Data Warehouse**: Google BigQuery (`trading-data-analyst.naira_volatility`)
* **Data Modeling**: SQL View Layer (Log Returns, 30-Day Rolling Volatility, Z-Scores)
* **Business Intelligence**: Power BI Desktop (Dynamic cross-filtering, heatmap matrix, and KPI risk scorecards)
* **Domain Focus**: Financial Risk Management, Quantitative Analytics, Forex Market Microstructure

---

## 📐 Analytics Schema & Data Dictionary
The core processing relies on the `volatility_analytics` table materialized within BigQuery, structured to optimize front-end reporting performance:

| Field Name | Type | Description |
| :--- | :--- | :--- |
| **trade_date** | DATE | Primary key for calendar dimensions and time-series mapping |
| **close_price** | FLOAT | Daily official closing exchange rate |
| **log_return** | FLOAT | Continuous daily returns calculated via $\ln(P_t / P_{t-1})$ |
| **true_range** | FLOAT | Absolute high-to-low intraday price dispersion metric |
| **vol_annualized_30d** | FLOAT | Rolling 30-day annualized standard deviation of log returns |
| **atr_14d** | FLOAT | 14-day Average True Range tracking absolute asset volatility |
| **vol_z_score** | FLOAT | Daily risk anomaly score measuring standard deviations from historical mean |

---

## 🔍 Core Macro Research Questions Answered
1. **Regime Discontinuity vs. Continuous Variance**: Quantified how sudden currency devaluations break traditional risk models, transitioning the market from tight managed bands to extreme volatility clusters.
2. **Granularity Smoothing Resolution**: Demonstrated how monthly aggregation can mask extreme daily risk events, while daily-level analysis preserves visibility into individual structural shocks. daily row parsing isolates exact structural failure points.
3. **Dynamic Risk Orchestration**: Replaced static risk thresholds with a rolling $Z$-score anomaly framework to monitor real-time tail-risk shocks.

---

## 📊 Performance Layer & Key Insights

* **The Volatility Baseline**: Across the entire 2022–2026 macro-cycle, the USD/NGN pair maintained a baseline average annualized volatility of **19.3%**.
* **The June 2023 Tail-Risk Event**: On the removal of the currency peg, the engine isolated a historic single-day risk shock of **15.55 standard deviations ($Z$-score)** above the historical mean. 
* **Smoothing Discrepancy**: While the daily data printed a maximum risk shock of **15.55**, the aggregated monthly matrix smoothed June 2023 out to a localized average $Z$-score of **3.89**, demonstrating the vital importance of multi-granularity risk dashboards.

### Dashboard Architecture
The front-end design separates high-level executive KPIs from granular analytical exploration grids:
1. **Scorecard Layer**: Tracks global historical norms against worst-case maximum standard deviation spikes.
2. **Trend Timeline**: A continuous time-series visualization tracking structural volatility regimes.
3. **Heatmap Matrix Layer**: Features conditional formatting to enable rapid visual identification of out-of-bounds risk months.
4. **Control Layer**: An interactive date slicer allowing users to isolate specific macroeconomic windows.

---

## 📸 Dashboard Preview

> Power BI risk dashboard — four-layer architecture (KPI scorecard, trend timeline, heatmap matrix, date slicer).

![Dashboard Preview](visuals/dashboard_preview.png)

## 📂 Repository Structure
* `📂 data/` — Cleaned currency datasets and schema source definitions.
* `📂 sql/` — Scripts containing production queries for rolling window standard deviations and returns.
* `📂 visuals/` — Target layouts and high-fidelity screenshots of the production Power BI dashboard canvas.

## 📈 Roadmap & Execution Status
* [x] Ingest and structure historical raw FX data schemas.
* [x] Construct BigQuery SQL views for vectorized statistical computations.
* [x] Standardize Power BI semantic model data aggregations (Average vs Max).
* [x] Implement dynamic report cross-filtering and interactive date slicers.
* [x] Publish Medium documentation case study.

---
**Connect with the Developer:**
[LinkedIn](https://www.linkedin.com/in/robert-analytics) | [X (Twitter)](https://x.com/rrobertemanuel)
