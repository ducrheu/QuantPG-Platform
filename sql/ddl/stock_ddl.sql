-- 股票基础信息表
CREATE TABLE stock_basic(
    stock_code VARCHAR(10) PRIMARY KEY,
    stock_name VARCHAR(30) NOT NULL,
    exchange VARCHAR(5) NOT NULL CHECK (exchange IN ('SH', 'SZ')),
    industry VARCHAR(50),
    list_date DATE,
    create_time TIMESTAMP
);

-- 日线行情表
CREATE TABLE stock_daily(
    id SERIAL PRIMARY KEY,
    stock_code VARCHAR(10) NOT NULL,
    trade_date DATE NOT NULL,
    open NUMERIC(10,2),
    high NUMERIC(10,2),
    low NUMERIC(10,2),
    close NUMERIC(10,2) NOT NULL,
    volume BIGINT,
    amount NUMERIC(15,2),
    UNIQUE (stock_code, trade_date)
);
-- 行情表高频查询联合索引
CREATE INDEX idx_stock_daily_code_date ON stock_daily(stock_code, trade_date);

-- 交易账户表
CREATE TABLE trading_account(
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(30) NOT NULL,
    broker VARCHAR(30),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 股票订单表
CREATE TABLE stock_order(
    order_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES trading_account(account_id),
    stock_code VARCHAR(10) NOT NULL REFERENCES stock_basic(stock_code),
    order_side VARCHAR(5) NOT NULL CHECK(order_side IN ('BUY', 'SELL')),
    price NUMERIC(10,2) NOT NULL,
    volume BIGINT NOT NULL,
    status VARCHAR(10) DEFAULT 'FILLED' CHECK (status IN('PENDING', 'FILLED', 'CANCELED'))
);

-- 量化策略表
CREATE TABLE strategy(
    strategy_id SERIAL PRIMARY KEY,
    strategy_name VARCHAR(50) NOT NULL UNIQUE,
    strategy_type VARCHAR(20) CHECK (strategy_type IN ('TREND','MEAN_REVERT','MULTI_FACTOR')),
    description TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 策略回测结果表
CREATE TABLE backtest_result(
    bt_id SERIAL PRIMARY KEY,
    strategy_id INT NOT NULL REFERENCES strategy(strategy_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    annual_return NUMERIC(8,4),
    max_drawdown NUMERIC(8,4),
    sharpe_ratio NUMERIC(6,2),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);