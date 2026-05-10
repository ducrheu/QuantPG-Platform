--查询历史行情 ＋ 涨跌幅
SELECT trade_date,close,
		ROUND((close - LAG(close) OVER (ORDER BY trade_date)) / LAG(close) OVER (ORDER BY trade_date) * 100, 2) AS Pct_change
		FROM stock_daily
		WHERE stock_code = '600000'
		ORDER BY trade_date;

--查询账户所有订单流水
SELECT *
	FROM stock_order
	WHERE account_id = 1;

--计算账户持仓总成本
SELECT p.account_id, p.stock_code, b.stock_name, p.volume, p.cost_price,
		p.volume * p.cost_price AS total_cost,
		p.volume * d.close AS current_market_value,
		ROUND((d.close - p.cost_price) / p.cost_price * 100, 2) AS profit_pct
		FROM position p
		JOIN stock_basic b ON p.stock_code = b.stock_code
		JOIN stock_daily d ON p.stock_code = d.stock_code
		WHERE d.trade_date = (SELECT MAX(trade_date) FROM stock_daily WHERE stock_code = p.stock_code);

--查询所有策略回测收益率排名
SELECT s.strategy_name, s.strategy_type, b.annual_return, b.max_drawdown, b.sharpe_ratio
	FROM strategy s
	JOIN backest_result b ON s.strategy_id = b.strategy_id
	ORDER BY b.annual_return DESC;