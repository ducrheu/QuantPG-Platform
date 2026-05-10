-- 价格为负数 为0 离谱高价脏数据
SELECT *
FROM stock_daily
WHERE close_price <= 0 OR close_price > 5000