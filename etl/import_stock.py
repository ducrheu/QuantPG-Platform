import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

# 加载本地.env文件里的隐私配置
load_dotenv()

# 从环境变量安全读取配置，代码里没有任何明文账号密码
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")

# 拼接数据库连接URL
DB_URL = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

engine = create_engine(DB_URL)

# 读取本地 CSV 文件
df = pd.read_csv('../data/stock_daily_data.csv')

# 简单数据过滤：删除空行 无效数据
df = df.dropna(axis = 0)

# 导入数据库 重复数据不会新增
df.to_sql(
    name = 'stock_daily',
    con = engine,
    if_exists = 'append',
    index = False
)

print("导入成功！")