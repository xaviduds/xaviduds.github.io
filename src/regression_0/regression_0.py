import os
import pandas as pd


script_dir = os.path.dirname(os.path.abspath(__file__))
data_path = os.path.join(script_dir, '../0_data/regression_0_cp.csv')

df = pd.read_csv(data_path)

print(df.head())
