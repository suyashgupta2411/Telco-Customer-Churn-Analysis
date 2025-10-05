# scripts/data_cleaning.py

import pandas as pd
import numpy as np
import os

# Define paths
RAW_PATH = "data/raw/Telco-Customer-Churn.csv"
PROCESSED_PATH = "data/processed/Telco-Customer-Churn-Cleaned.csv"

def load_data(path=RAW_PATH):
    """Load the raw dataset"""
    print(f"Loading dataset from: {path}")
    df = pd.read_csv(path)
    print(f"Dataset loaded successfully. Shape: {df.shape}")
    return df

def inspect_data(df):
    """Basic inspection of dataset"""
    print("\n--- Data Info ---")
    print(df.info())
    print("\n--- Missing Values ---")
    print(df.isnull().sum())
    print("\n--- Sample Rows ---")
    print(df.head())

def clean_data(df):
    """Clean and preprocess Telco Churn data"""
    print("\nCleaning data...")

    # Strip whitespace from column names
    df.columns = df.columns.str.strip()

    # Remove spaces in 'TotalCharges' and convert to numeric
    df['TotalCharges'] = df['TotalCharges'].replace(" ", np.nan)
    df['TotalCharges'] = pd.to_numeric(df['TotalCharges'], errors='coerce')

    # Handle missing values in TotalCharges
    df['TotalCharges'].fillna(df['TotalCharges'].median(), inplace=True)

    # Encode gender as binary
    df['gender'] = df['gender'].map({'Female': 0, 'Male': 1})

    # Convert 'Yes'/'No' to 1/0 for Churn column
    df['Churn'] = df['Churn'].map({'Yes': 1, 'No': 0})

    # Drop customerID as it’s non-informative
    df.drop('customerID', axis=1, inplace=True)

    # Convert categorical columns to category dtype
    for col in df.select_dtypes('object').columns:
        df[col] = df[col].astype('category')

    print("Data cleaning completed.")
    print(f"Cleaned shape: {df.shape}")
    return df

def save_data(df, path=PROCESSED_PATH):
    """Save the cleaned data"""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    df.to_csv(path, index=False)
    print(f"Cleaned data saved to: {path}")

if __name__ == "__main__":
    df = load_data()
    inspect_data(df)
    cleaned_df = clean_data(df)
    save_data(cleaned_df)
