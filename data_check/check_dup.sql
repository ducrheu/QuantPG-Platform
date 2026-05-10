-- 同一天同一只股票出现多条重复数据
SELECT
    stock_code,
    trade_date,
    COUNT(*) AS cnt
FROM stock_daily
GROUP BY stock_code, trade_date
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
