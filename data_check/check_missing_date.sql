-- 查看连续交易日缺失、时间序列不完整
WITH all_date AS (
    SELECT generate_series(MIN(trade_date),MAX(trade_date),'1 day'::interval) AS date
    FROM stock_daily
)
SELECT date AS missing_trade_date
FROM all_date
LEFT JOIN (SELECT DISTINCT trade_date FROM stock_daily) t ON all_date.date = t.trade_date
WHERE t.trade_date IS NULL;