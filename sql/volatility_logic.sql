-- USD/NGN Volatility Analysis Logic
-- Author: Robert-Analytics
-- Description: Calculating Daily Returns and 30-Day Rolling Volatility

SELECT 
  trade_date,
  close_price,
  
  -- 1. Calculate Daily Log Return 
  -- (Log returns are preferred in finance for better statistical properties)
  LOG(close_price / LAG(close_price) OVER (ORDER BY trade_date)) AS daily_log_return,
  
  -- 2. Calculate 30-Day Rolling Volatility 
  -- (This uses the Standard Deviation of returns over a 30-day window)
  STDDEV(LOG(close_price / LAG(close_price) OVER (ORDER BY trade_date))) 
    OVER (ORDER BY trade_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS rolling_vol_30d,

  -- 3. Categorize Volatility Levels (Risk Assessment)
  CASE 
    WHEN ABS(daily_change_pct) > 0.02 THEN 'High Volatility'
    WHEN ABS(daily_change_pct) BETWEEN 0.005 AND 0.02 THEN 'Moderate'
    ELSE 'Stable'
  END AS risk_category

FROM 
  `your_project.naira_volatility.usd_ngn_cleaned`
ORDER BY 
  trade_date DESC;

CREATE OR REPLACE VIEW `trading-data-analyst.naira_volatility.volatility_analytics` AS
WITH BaseMetrics AS (
    -- 4.1 & 4.3: Calculate Daily Log Returns and True Range components
    SELECT
        trade_date,
        close_price,
        LOG(close_price / LAG(close_price) OVER (ORDER BY trade_date)) AS log_return,
        -- True Range = Max(High-Low, High-PrevClose, Low-PrevClose)
        GREATEST(
            high_price - low_price,
            ABS(high_price - LAG(close_price) OVER (ORDER BY trade_date)),
            ABS(low_price - LAG(close_price) OVER (ORDER BY trade_date))
        ) AS true_range
    FROM `trading-data-analyst.naira_volatility.usd_ngn_history`
),
VolatilityStats AS (
    -- 4.2 & 4.3: Annualized Rolling Volatility and ATR
    SELECT *,
        STDDEV(log_return) OVER (ORDER BY trade_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) * SQRT(252) AS vol_annualized_30d,
        AVG(true_range) OVER (ORDER BY trade_date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS atr_14d
    FROM BaseMetrics
),
RiskRegime AS (
    -- 4.4: Identify Dynamic Z-Score for volatility regimes
    SELECT *,
        (vol_annualized_30d - AVG(vol_annualized_30d) OVER (ORDER BY trade_date ROWS BETWEEN 251 PRECEDING AND CURRENT ROW))
        / NULLIF(STDDEV(vol_annualized_30d) OVER (ORDER BY trade_date ROWS BETWEEN 251 PRECEDING AND CURRENT ROW), 0) AS vol_z_score
    FROM VolatilityStats
)
SELECT * FROM RiskRegime;