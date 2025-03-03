import requests
from bs4 import BeautifulSoup
import csv
import pandas as pd

def simple_scraper(url):
    data_list = []  
    response = requests.get(url)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        pubblicationData = soup.find_all("div", {"class": "line-list"})
        for data in pubblicationData:
            paragraphs = data.find_all('p')
            for paragraph in paragraphs:
                links = paragraph.find_all('a', href=True)
                for link in links:
                    href = link['href']
                    title = link.get_text().strip() 
                    contributors = visit_and_extract_internal_contributors(href)
                    data_list.append({
                        "Paper Title": title,
                        "Contributors": "; ".join(contributors)
                    })
    else:
        print(f"Request error, status code: {response.status_code}")

    with open('papers_data.csv', mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=["Paper Title", "Contributors"])
        writer.writeheader()
        writer.writerows(data_list)

def visit_and_extract_internal_contributors(url):
    contributors = []
    try:
        response = requests.get(url)
        if response.status_code == 200:
            soup = BeautifulSoup(response.text, 'html.parser')
            contributors_tags = soup.find_all('span', {"class": "internalContributor"})
            contributors = [contributor.get_text().strip() for contributor in contributors_tags]
        else:
            print(f"Failed to fetch {url}, status code: {response.status_code}")
    except requests.RequestException as e:
        print(f"Error while fetching {url}: {e}")
    return contributors

def clean_contributors(contributors):
    if pd.isna(contributors):
        return ""
    contributors_list = [name.strip() for name in contributors.split(';') if name.strip()]
    return '; '.join(contributors_list)

def clean():
    df = pd.read_csv('papers_data.csv')
    df['Contributors'] = df['Contributors'].apply(clean_contributors)
    df.to_csv('papers_data.csv', index=False)

def main():
    url = 'https://disi.unibo.it/it/ricerca/pubblicazioni?&pagesize=7523'
    simple_scraper(url)
    clean()
    
if __name__ == "__main__":
    main()
