"""Jalanin query dari file .sql ke shop.db.  Pakai: python run.py jawaban/q01.sql"""
import sqlite3
import sys
from pathlib import Path

import pandas as pd

con = sqlite3.connect(Path(__file__).parent / "shop.db")
sql = Path(sys.argv[1]).read_text(encoding="utf-8")
print(pd.read_sql(sql, con).to_string(max_rows=50))
