-- 跨表一致性校验：检测行情表存在、但股票基础信息表不存在的股票代码
SELECT
    DISTINCT stock_code
FROM stock_daily
WHERE stock_code NOT IN (
    SELECT stock_code FROM stock_basic
);