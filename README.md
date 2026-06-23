# Belajar Data Analyst

A personal collection of data analysis practice projects, following the [Data Analyst roadmap](https://roadmap.sh/). Each numbered folder is a self-contained mini-project built while working through the roadmap, covering the data analyst workflow — from scraping raw data to cleaning and analyzing it.

## Projects

### `1-Python-Job-Listings-Scraper`
A web scraper that pulls job listings from the [Real Python fake-jobs](https://roadmap.sh/projects/job-listings-scraper) practice site. It uses `urllib` to fetch the page and BeautifulSoup to parse each job card, extracting the title, company, location, and application link. The results are written out to a `job_listings.csv` file you can open in any spreadsheet tool — a typical first step in a data project: getting messy real-world data into a structured format.

**Run it:**
```bash
pip install beautifulsoup4
python 1-Python-Job-Listings-Scraper/python-job-listings-scraper.py
```

### `2-Analysing-pharmaceutical-sales-data`
A pandas exercise analyzing a daily pharmaceutical sales dataset (`salesdaily.csv`)[Analysing Pharma Sales Data](https://roadmap.sh/projects/pharmaceutical-sales-data), where each drug category (ATC code) is its own column. The notebook works through a series of questions — total sales per category, best-selling drug, top sellers in specific months, which drug sold most often, highest average daily sales, and whether respiratory drugs (R03) show seasonal patterns. Practices the core pandas workflow: `read_csv`, boolean masking to filter rows, column selection, and aggregation with `sum`/`mean`/`groupby`.

**Run it:**
```bash
pip install pandas jupyter
jupyter notebook 2-Analysing-pharmaceutical-sales-data/analysing-pharmaceutical-sales-data.ipynb
```

## Requirements

- Python 3.x
- `beautifulsoup4`, `pandas`, `jupyter` (per-project; install as needed)
