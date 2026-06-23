import csv
import urllib.request
from bs4 import BeautifulSoup

url="https://realpython.github.io/fake-jobs/"
contents = urllib.request.urlopen(url).read()

soup = BeautifulSoup(contents, "html.parser")

card = soup.select("div.card-content")

list_jobs = []
for c in card:
    title = c.select_one("h2")
    company = c.select_one("h3.company")
    location = c.select_one("p.location")
    job_link = c.select("a.card-footer-item")
    if title and company:
        job_info = {
            "title": title.get_text() if title else "Title not specified",
            "company": company.get_text() if company else "Company not specified",
            "location": location.get_text().strip() if location else "Location not specified",
            "link": job_link[1].get("href") if len(job_link) > 1 else "Link not specified"
        }
        list_jobs.append(job_info)

filename = 'job_listings.csv'
with open(filename, mode='w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=["title", "company", "location", "link"])
    writer.writeheader()
    writer.writerows(list_jobs)