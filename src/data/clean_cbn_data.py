import pandas as pd
import os


def clean_cbn_data():
    # Get the directory where this script is currently located
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Construct the path to your data folder
    # This assumes your structure is: src/data/clean_cbn_data.py AND data/raw/USD_NGN_Raw.csv
    # '..' goes up one level to 'src', then another '..' goes to 'naira-volatility-analysis'
    input_file = os.path.join(script_dir, '..', '..', 'data', 'raw', 'USD_NGN_Raw.csv')
    output_dir = os.path.join(script_dir, '..', '..', 'data', 'interim')
    output_file = os.path.join(output_dir, 'usd_ngn_cleaned.csv')

    print(f"Attempting to read from: {input_file}")

    # Check if file exists before trying to read it
    if not os.path.exists(input_file):
        print(f"CRITICAL ERROR: Could not find file at {input_file}")
        print("Please check if the file is named exactly 'USD_NGN_Raw.csv' and is in the 'data/raw' folder.")
        return

    # Load the raw data
    df = pd.read_csv(input_file)

    # Drop the Volume column if it exists
    if 'Vol.' in df.columns:
        df = df.drop(columns=['Vol.'])

    # Rename columns
    df = df.rename(columns={
        'Date': 'trade_date',
        'Price': 'close_price',
        'Open': 'open_price',
        'High': 'high_price',
        'Low': 'low_price',
        'Change %': 'change_pct'
    })

    # Standardize Date
    df['trade_date'] = pd.to_datetime(df['trade_date'])

    # Clean Percentage column
    if df['change_pct'].dtype == 'object':
        df['change_pct'] = df['change_pct'].str.replace('%', '').astype(float) / 100

    # Sort and Save
    df = df.sort_values('trade_date').reset_index(drop=True)

    os.makedirs(output_dir, exist_ok=True)
    df.to_csv(output_file, index=False)
    print(f"Pipeline Success: Cleaned data saved to {output_file}")


if __name__ == "__main__":
    clean_cbn_data()