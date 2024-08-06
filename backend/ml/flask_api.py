from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

# Load the model and scaler
with open('xgboost_model.pkl', 'rb') as file:
    model = pickle.load(file)

with open('scaler.pkl', 'rb') as file:
    scaler = pickle.load(file)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    features = np.array([data['Gender'], data['Married'], data['Dependents'], 
                         data['Education'], data['Self_Employed'], data['ApplicantIncome'], 
                         data['CoapplicantIncome'], data['Loan_Amount_Term'], data['SHG_ID']])
    features = features.reshape(1, -1)
    features_scaled = scaler.transform(features)
    prediction = model.predict(features_scaled)
    return jsonify({'prediction': float(prediction[0])})

if __name__ == '__main__':
    app.run(debug=True)