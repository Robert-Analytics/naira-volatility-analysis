# 📉 Naira Volatility Analysis (USD/NGN)
**A Quantitative Study of Exchange Rate Fluctuations (2022–2024)**

---

## 🎯 Project Objective
This project analyzes the historical volatility of the Nigerian Naira (NGN) against the US Dollar (USD). By leveraging SQL and Power BI, I identify high-risk periods, correlation with global market events, and the impact of domestic policy shifts on currency stability.

## 🛠️ Tech Stack & Methodology
- **Data Engineering**: Python for initial ingestion and ETL.
- **Data Analysis**: SQL (Window Functions) to calculate Rolling Volatility and Daily Percentage Change.
- **Visualization**: Power BI for dynamic trend dashboards and risk-level heatmaps.
- **Domain Focus**: Risk Management, Macroeconomics, and Forex Market Microstructure.

## 🔍 Key Research Questions
1. **Regime Analysis**: How do periods of official "Devaluation Jumps" (discontinuous step-functions) statistically differ from periods of "Managed Float" (continuous daily variance) between 1995 and 2024?
2. **Policy Transmission Lag**: What is the quantifiable lag (in trading days) between major CBN liquidity interventions/policy unifications and the stabilization of market volatility?
3. **Dynamic Risk Orchestration**: How do rolling 30-day Annualized Volatility and ATR metrics perform as dynamic, real-time indicators for USD/NGN risk compared to traditional static thresholding?

## 📂 Repository Structure
- `📂 data/` — Raw CSV files (CBN source) and cleaned datasets.
- `📂 sql/` — Scripts for volatility calculations (Standard Deviation, Moving Averages).
- `📂 visuals/` — High-resolution Power BI dashboard screenshots and PDFs.
- `📂 docs/` — Brief report summarizing the findings for stakeholders.

## 📈 Roadmap & Status
- [x] Data Sourcing (CBN Historical Data)
- [x] Data Cleaning & SQL Transformation (In Progress)
- [ ] Power BI Dashboard Development
- [ ] Final Insights Report

---
### 💡 Why this matters
In the Nigerian Fintech space, understanding currency risk is vital for cross-border transactions and liquidity management. This project serves as a framework for automating currency risk assessment.

## 📊 Key Results

### Initial Data Insights

- **Dataset Span:** 1995 – 2024 (7,000+ entries)
- **Cleaning Actions:** Standardized ISO dates, removed empty volume metrics, and normalized percentage changes
- **SQL Milestone:** Successfully implemented Rolling 30-Day Standard Deviation to track "Volatility Clusters" during major policy shifts

**Connect with the Developer:**
[LinkedIn](https://www.linkedin.com/in/robert-analytics) | [X (Twitter)](https://x.com/rrobertemanuel)
