# SQL Practice — Toko Online "TokoKita"

Kamu data analyst baru di TokoKita. Manager, tim marketing, dan tim produk nanya macem-macem. Jawab pakai SQL.

## Setup

```bash
cd 4-SQL-Practice
python setup_db.py                 # bikin shop.db
python run.py jawaban/q01.sql      # jalanin query dari file
```

Atau buka `shop.db` di DB Browser for SQLite / extension VS Code "SQLite Viewer". Dialek: **SQLite**.

## Schema

```
customers   (customer_id, name, city, signup_date)
products    (product_id, name, category, price)
orders      (order_id, customer_id, order_date, status)       -- completed / cancelled / returned
order_items (order_id, product_id, quantity, unit_price)      -- revenue item = quantity * unit_price
```

**Aturan bisnis:** revenue = cuma order `completed`. Kecuali soal bilang lain.

---

## Level 1 — SELECT, WHERE, ORDER BY, LIMIT

1. Tampilkan 10 produk termahal (nama, kategori, harga).
2. Ada berapa customer dari Bandung?
3. Customer mana aja yang `city`-nya kosong? *(hint: `= NULL` gak jalan)*
4. Tampilkan semua produk kategori Fashion dengan harga di bawah 300rb, urut termurah.
5. Order apa aja yang terjadi di bulan Desember 2024?

## Level 2 — Aggregate & GROUP BY

6. Jumlah order per status. Berapa persen order yang cancelled?
7. Jumlah customer per kota, urut terbanyak. Kota kosong tampilkan sebagai `'Unknown'`.
8. Rata-rata, min, max harga produk per kategori.
9. Kategori mana yang punya lebih dari 4 produk? *(WHERE vs HAVING)*
10. Total revenue per bulan selama 2025. *(hint: `strftime`)*

## Level 3 — JOIN

11. Top 10 customer berdasarkan total belanja (nama, kota, total).
12. Revenue per kategori produk. Kategori mana paling cuan?
13. Produk mana yang **gak pernah** terjual sama sekali? *(LEFT JOIN … IS NULL)*
14. Customer mana yang udah daftar tapi **belum pernah** order?
15. Berapa kali tiap produk dibeli dengan diskon (`unit_price < price`)? Produk mana paling sering didiskon?
16. Kota mana yang punya average order value (AOV) tertinggi? *(AOV = revenue / jumlah order)*

## Level 4 — Subquery & CTE

17. Produk yang harganya di atas rata-rata harga semua produk.
18. Customer yang total belanjanya di atas rata-rata total belanja semua customer.
19. Berapa customer yang order cuma sekali vs lebih dari sekali? *(one-time vs repeat buyer)*
20. Untuk tiap customer: tanggal order pertama, order terakhir, jumlah hari di antaranya.
21. Return rate per kategori: dari semua order yang memuat produk kategori X, berapa persen yang `returned`?

## Level 5 — Window Functions

22. Ranking produk berdasarkan revenue **di dalam kategorinya masing-masing**. Ambil top 2 per kategori. *(`RANK()` / `ROW_NUMBER()` + `PARTITION BY`)*
23. Revenue per bulan + revenue bulan sebelumnya + growth % month-over-month. *(`LAG`)*
24. Running total revenue sepanjang waktu (kumulatif per bulan).
25. Untuk tiap order, berapa hari jarak dari order sebelumnya oleh customer yang sama?
26. Bagi customer ke 4 grup (quartile) berdasarkan total belanja. Berapa rata-rata belanja tiap grup? *(`NTILE`)*

## Level 6 — Case Bisnis (gabungan)

27. **Cohort retention.** Kelompokkan customer berdasarkan bulan order pertama. Dari tiap cohort, berapa persen yang order lagi di bulan ke-1, ke-2, ke-3 setelahnya?
28. **RFM segmentation.** Hitung Recency (hari sejak order terakhir, anggap hari ini `2025-10-01`), Frequency (jumlah order), Monetary (total belanja). Beri skor 1–4 tiap dimensi pakai `NTILE`, lalu label: "Champions", "At Risk", "Lost", dsb. Aturan label bebas, tapi jelaskan.
29. **Market basket.** Pasangan produk mana yang paling sering dibeli dalam order yang sama? *(self-join `order_items`)*
30. **Churn.** Customer yang dulu aktif (≥3 order) tapi gak order dalam 120 hari terakhir (patokan `2025-10-01`). Siapa aja, dan berapa total belanja mereka dulu? Ini list buat tim marketing kirim voucher.

## Level 7 — Data Cleaning & Sanity Check

31. **Data quality report.** Dalam 1 query, tampilkan: jumlah customer tanpa kota, jumlah order yang tanggalnya **sebelum** signup customer-nya, jumlah order yang tanggalnya **setelah** `2025-10-01`, jumlah item dengan `unit_price > price` produk. *(1 baris, banyak kolom — scalar subquery)*
32. Ada nama customer yang dobel. Tampilkan nama dobel, berapa kali muncul, dan list `customer_id`-nya dalam 1 kolom. *(hint: `group_concat`)*
33. Cek konsistensi: total revenue dari `order_items` (completed) harus sama dengan jumlah revenue per kategori. Bikin query yang output-nya `'OK'` atau `'MISMATCH'`.

## Level 8 — EXISTS, UNION, EXCEPT

34. Customer yang pernah beli **Elektronik** DAN **Fashion** (order completed). Kerjain 2 cara: `EXISTS` dan `INTERSECT`.
35. Customer yang pernah order tapi **semua** order-nya cancelled/returned (gak pernah ada yang completed). *(NOT EXISTS / EXCEPT)*
36. Bikin 1 tabel laporan gabungan: baris per kategori (revenue) + 1 baris `'TOTAL'` di paling bawah. *(UNION ALL)*

## Level 9 — Window Function Lanjutan

37. **Moving average 3 bulan** revenue. *(`AVG() OVER (ORDER BY ... ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)`)*
38. Untuk tiap customer: produk apa yang dibeli di order **pertama** mereka? *(`ROW_NUMBER` / `FIRST_VALUE`)*
39. Kontribusi tiap produk terhadap revenue kategorinya (%), tanpa subquery terpisah. *(`SUM() OVER (PARTITION BY ...)`)*
40. **Pareto 80/20.** Urutkan customer dari belanja terbesar, hitung cumulative % revenue. Berapa persen customer yang menyumbang 80% revenue?
41. **Median** total belanja per customer. SQLite gak punya `MEDIAN()` — akalin pakai window function.

## Level 10 — Case Bisnis Lanjutan

42. **Kalender lengkap.** Revenue harian Desember 2024, tapi tanggal yang gak ada order tetap muncul dengan revenue 0. *(recursive CTE bikin deret tanggal + LEFT JOIN)*
43. **Gaps & islands.** Untuk tiap customer, cari streak **bulan berturut-turut** terpanjang dia order (completed).
44. **Year-over-year.** Bandingkan revenue Feb–Sep 2025 vs Feb–Sep 2024 per kategori, plus growth %. Kategori mana yang turun? *(pivot pakai `SUM(CASE WHEN ...)`)*
45. **Time-to-second-order.** Rata-rata berapa hari dari order pertama ke order kedua customer? Bandingkan per kota.
46. **Product affinity lift.** Dari Q29, hitung *lift* tiap pasangan: `P(A&B) / (P(A) * P(B))` dengan P = proporsi order yang memuat produk itu. Lift > 1 = sering dibeli bareng beneran, bukan kebetulan laku.
47. **Customer lifetime value sederhana.** Per customer: AOV × frekuensi order per bulan aktif × 12. Top 10.
48. **Discount effectiveness.** Bandingkan order yang ada item diskonnya vs yang gak ada: rata-rata nilai order, jumlah item per order, return rate.
49. **Cohort revenue.** Mirip Q27, tapi isinya total revenue tiap cohort di bulan ke-0, 1, 2, 3 (bukan % customer).
50. **Dashboard satu query.** Per bulan: revenue, jumlah order, AOV, customer baru (order pertama di bulan itu), customer returning, MoM growth revenue. Ini yang biasanya ditaruh di Metabase/Looker.

---

## Tips

- Simpan tiap jawaban di `jawaban/qXX.sql`.
- Selalu cek hasil masuk akal: total revenue per kategori dijumlah harus = total revenue keseluruhan.
- Hati-hati **double counting** pas JOIN `orders` ke `order_items` (1 order bisa banyak item). Soal 16 & 21 jebakannya di sini.
- Q42 & Q43 paling susah. Kerjain belakangan.
- Q41: median = nilai tengah. Pikirin `ROW_NUMBER` + `COUNT(*) OVER ()`.
- Q43: trik klasik islands = `nomor_bulan - ROW_NUMBER()` → hasilnya konstan selama berturut-turut.
