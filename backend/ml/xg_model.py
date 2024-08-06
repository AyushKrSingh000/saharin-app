import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from xgboost import XGBRegressor
import pickle

# Load and preprocess data
df = pd.read_csv('loan_data_set.csv')
columns_to_drop = ['Loan_ID', 'Credit_History', 'Property_Area', 'Loan_Status']
df = df.drop(columns=columns_to_drop)
df['SHG_ID'] = np.repeat(range(1, 32), 20)[:len(df)]
df = df.dropna()
df = df.replace(to_replace='3+', value=4)
df.replace({'Married':{'No':0,'Yes':1},'Gender':{'Male':1,'Female':0},'Self_Employed':{'No':0,'Yes':1},
                      'Education':{'Graduate':1,'Not Graduate':0}},inplace=True)
print(df.head(5))
# Prepare features and target
X = df.drop(columns=['LoanAmount'],axis=1)
y = df['LoanAmount']

# Split the data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Scale the features
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Train XGBoost model
xgb_model = XGBRegressor(random_state=42)
xgb_model.fit(X_train_scaled, y_train)

# Save the XGBoost model
with open('xgboost_model.pkl', 'wb') as file:
    pickle.dump(xgb_model, file)

# Save the scaler
with open('scaler.pkl', 'wb') as file:
    pickle.dump(scaler, file)

print("XGBoost model and scaler saved as pickle files.")