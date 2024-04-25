#Import modules
import plotly.graph_objects as go
import plotly.express as px
import numpy as np
import pandas as pd
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.model_selection import LeaveOneOut
from sklearn.linear_model import LinearRegression
from sklearn.metrics import accuracy_score, f1_score

# Collect data
df = pd.read_csv('05_regression_0_cp.csv')
# df = pd.read_csv('src/dataPortifolio/regression_0/05_regression_0_cp.csv')
print(df.head())
print('---')

# Deal with missing data
numeric_columns = df.select_dtypes(include=[np.number]).columns
df[numeric_columns] = df[numeric_columns].fillna(df[numeric_columns].mean())

# Storage Y

# Normalize numeric columns
numeric_columns = df.select_dtypes(include=[np.number]).columns
df[numeric_columns] = ((df[numeric_columns] - df[numeric_columns].min())) / (df[numeric_columns].max() - df[numeric_columns].min())

# Create a 3D visualization for there are 3 features
fig = px.scatter_3d(df, x='Country', y='Age', z='Salary',
                    title='Salary by Country and Age',
                    labels={'Country': 'Country', 'Age': 'Age', 'Salary': 'Salary'})

fig.write_html('3d_scatter_plot.html')

# Encoding

# Country: One-hot enconding
# encoder = OneHotEncoder(sparse_output=False)
# encoded_countries = encoder.fit_transform(df[['Country']])
# encoded_df = pd.DataFrame(encoded_countries, columns=encoder.get_feature_names_out(['Country']))
# df = df.join(encoded_df).drop('Country', axis=1)

df.drop(columns="Country", inplace=True)

# Purchased: Simple mapping
df['Purchased'] = df['Purchased'].map({'Yes': 1, 'No': 0})


# Train-test split 


X = df.drop('Purchased', axis=1).values
y = df['Purchased'].values

# Initialize LeaveOneOut and LogisticRegression
loo = LeaveOneOut()
log_reg = LinearRegression()

# Lists to store the true labels and predicted labels for each test set
true_labels = []
predicted_labels = []

# Perform leave-one-out cross-validation
for train_index, test_index in loo.split(X):
    X_train, X_test = X[train_index], X[test_index]
    y_train, y_test = y[train_index], y[test_index]
    
    # Fit the model
    log_reg.fit(X_train, y_train)
    
    # Make predictions
    y_pred = log_reg.predict(X_test)
    
    # Store the true and predicted labels
    true_labels.append(y_test[0])
    predicted_labels.append(y_pred[0])

# Calculate and print the F1 score
f1 = f1_score(true_labels, predicted_labels)
print(f'F1 Score: {f1}')
# Trainning


# Prediction


# Evaluation

print('---')

print(df.head(12))
# print(df_encoded.head())
