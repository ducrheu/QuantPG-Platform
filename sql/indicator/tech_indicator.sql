-- 五日均线 十日均线计算
SELECT
    stock_code,
    trade_date,
    close_price,
    AVG(close_price) OVER(PARTITION BY stock_code ORDER BY trade_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS ma5,
    AVG(close_price) OVER(PARTITION BY stock_code ORDER BY trade_date ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS ma10
FROM stock_daily
ORDER BY stock_code, trade_date;

-- 单日涨跌幅
SELECT
    stock_code,
    trade_date,
    close_price,
    (close_price - LAG(close_price, 1) OVER(PARTITION BY stock_code ORDER BY trade_date)) / LAG(close_price, 1) OVER(PARTITION BY stock_code ORDER BY trade_date) AS daily_return
FROM stock_daily;