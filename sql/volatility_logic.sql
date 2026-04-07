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
