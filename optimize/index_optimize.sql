-- 索引：股票代码 + 交易日期
CREATE INDEX idx_stock_code_trade_date
On stock_daily(stock_code, trade_date);
-- 统计分析表 加速查询
ANALYZE stock_daily