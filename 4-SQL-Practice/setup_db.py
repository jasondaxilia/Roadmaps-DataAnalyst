"""Build shop.db: toko online fiktif buat latihan SQL. Data deterministik (seed tetap)."""
import random
import sqlite3
from datetime import date, timedelta
from pathlib import Path

random.seed(42)
DB = Path(__file__).parent / "shop.db"
DB.unlink(missing_ok=True)
con = sqlite3.connect(DB)

con.executescript("""
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name        TEXT,
    city        TEXT,
    signup_date DATE
);
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name       TEXT,
    category   TEXT,
    price      INTEGER  -- rupiah
);
CREATE TABLE orders (
    order_id    INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date  DATE,
    status      TEXT     -- completed / cancelled / returned
);
CREATE TABLE order_items (
    order_id   INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity   INTEGER,
    unit_price INTEGER   -- harga saat beli (bisa beda dari products.price)
);
""")

cities = ["Jakarta", "Bandung", "Surabaya", "Medan", "Yogyakarta", "Makassar", "Semarang", None]
first = ["Andi", "Budi", "Citra", "Dewi", "Eka", "Fajar", "Gita", "Hadi", "Indah", "Joko",
         "Kevin", "Lina", "Made", "Nia", "Oscar", "Putri", "Rizky", "Sari", "Tono", "Wulan"]
last = ["Santoso", "Wijaya", "Pratama", "Lestari", "Siregar", "Nugroho", "Halim", "Saputra"]

start = date(2024, 1, 1)
customers = []
for i in range(1, 201):
    customers.append((i, f"{random.choice(first)} {random.choice(last)}",
                      random.choice(cities), (start + timedelta(days=random.randint(0, 600))).isoformat()))
con.executemany("INSERT INTO customers VALUES (?,?,?,?)", customers)

catalog = {
    "Elektronik": [("Earbuds", 350_000), ("Powerbank", 250_000), ("Smartwatch", 1_200_000),
                   ("Keyboard", 450_000), ("Mouse", 150_000), ("Monitor 24in", 1_800_000)],
    "Fashion": [("Kaos Polos", 80_000), ("Hoodie", 220_000), ("Sneakers", 650_000),
                ("Topi", 60_000), ("Jaket Denim", 400_000)],
    "Rumah Tangga": [("Rice Cooker", 500_000), ("Blender", 380_000), ("Panci Set", 300_000),
                     ("Lampu LED", 45_000)],
    "Buku": [("Novel", 95_000), ("Buku SQL", 150_000), ("Komik", 40_000)],
    "Kecantikan": [("Serum", 120_000), ("Sunscreen", 85_000), ("Lipstik", 70_000)],
}
products, pid = [], 1
for cat, items in catalog.items():
    for name, price in items:
        products.append((pid, name, cat, price))
        pid += 1
products.append((pid, "Produk Gak Laku", "Lainnya", 999_000))  # sengaja: gak pernah dibeli
con.executemany("INSERT INTO products VALUES (?,?,?,?)", products)

orders, items = [], []
for oid in range(1, 1501):
    c = random.choice(customers[:185])  # ~15 customer sengaja gak pernah order
    d = max(c[3], (start + timedelta(days=random.randint(0, 640))).isoformat())
    status = random.choices(["completed", "cancelled", "returned"], [85, 10, 5])[0]
    orders.append((oid, c[0], d, status))
    for p in random.sample(products[:-1], random.randint(1, 4)):
        discount = random.choice([1, 1, 1, 0.9, 0.8])
        items.append((oid, p[0], random.randint(1, 3), int(p[3] * discount)))
con.executemany("INSERT INTO orders VALUES (?,?,?,?)", orders)
con.executemany("INSERT INTO order_items VALUES (?,?,?,?)", items)
con.commit()

for t in ["customers", "products", "orders", "order_items"]:
    print(t, con.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0])
