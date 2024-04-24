import plotly.graph_objects as go
import numpy as np
import pandas as pd
from sklearn.preprocessing import OneHotEncoder
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split


df = pd.read_csv('05_regression_0_cp.csv')
print(df.head())
print('---')


def hold_one_out(df, model, metric=accuracy_score):
    """
    Perform hold-one-out evaluation on a dataset.
    
    Parameters:
    - df: pandas DataFrame containing the dataset
    - model: a trained sklearn model
    - metric: function to evaluate the model's performance (default is accuracy)
    
    Returns:
    - scores: list of scores for each hold-one-out iteration
    """
    scores = []
    for i in range(len(df)):
        # Split the dataset into training and testing sets
        train_df = df.drop(i)
        test_df = df.iloc[[i]]
        
        # Separate features and labels
        X_train = train_df.drop('label', axis=1)
        y_train = train_df['label']
        X_test = test_df.drop('label', axis=1)
        y_test = test_df['label']
        
        # Train the model on the training set
        model.fit(X_train, y_train)
        
        # Make predictions on the test set
        y_pred = model.predict(X_test)
        
        # Calculate the metric
        score = metric(y_test, y_pred)
        scores.append(score)
    
    return scores


def fillna_with_mean(df):
    numeric_columns = df.select_dtypes(include=[np.number]).columns
    df[numeric_columns] = df[numeric_columns].fillna(df[numeric_columns].mean())
    
    return df


df = fillna_with_mean(df)

Y = df['Purchased']
df.drop(columns="Purchased", inplace=True)

# df_encoded = pd.get_dummies(df, columns=['Country'])
# df_encoded = df_encoded.astype(int)




import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Create a 3D subplot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Extract data
x = df['Country']
y = df['Age']
z = df['Salary']

# Create a scatter plot
ax.scatter(x, y, z, alpha=0.5)

# Set labels
ax.set_xlabel('Country')
ax.set_ylabel('Age')
ax.set_zlabel('Salary')

# Set title
ax.set_title('Salary by Country and Age')

# Show the plot
plt.show()











print('---')

print(df.head())
# print(df_encoded.head())
