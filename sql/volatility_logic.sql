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