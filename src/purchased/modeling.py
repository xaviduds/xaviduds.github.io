import numpy as np
import pandas as pd
import plotly.graph_objects as go
import plotly.express as px
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, f1_score


df = pd.read_csv('dataset_cp.csv')

print(df.head())

df['Country'] = pd.factorize(df['Country'])[0] + 1
numeric_columns = df.select_dtypes(include=[np.number]).columns
df[numeric_columns] = df[numeric_columns].fillna(df[numeric_columns].mean())
df[numeric_columns] = ((df[numeric_columns] - df[numeric_columns].min())) / (df[numeric_columns].max() - df[numeric_columns].min())
df['Purchased'] = df['Purchased'].map({'Yes': 1.0, 'No': 0.0})

print(df.head())

print(df.shape)
print(df.dtypes)
print(df.corr())

fig = px.scatter_3d(df, x='Country', y='Age', z='Salary', title='Salary by Country and Age', labels={'Country': 'Country', 'Age': 'Age', 'Salary': 'Salary'})
fig.write_html('3d_scatter_plot.html')

knn = KNeighborsClassifier(n_neighbors=3)
X = df.drop('Purchased', axis=1).values
y = df['Purchased'].values
X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.2)
knn.fit(X_train, y_train)
y_pred = knn.predict(X_test)

print(f'F1 Score: {f1_score(y_test, y_pred)}')
