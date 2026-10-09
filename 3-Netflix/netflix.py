import pandas as pd

df = pd.read_csv('./data/netflix_titles.csv')
new_df = df.dropna()

list = new_df.groupby('country')
print(list)
# for row in new_df.itertuples():
#     print(row.groupby('country'))