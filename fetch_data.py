import os
import sys
import logging
from google.cloud import bigquery
from google.cloud.bigquery import QueryJobConfig

# 1. Enable Debug Logging to reveal transport errors
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger()

# 2. Path to your verified key
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"C:\trading-data-analyst-d73dd0990641.json"

print("--- STARTING NETWORK DIAGNOSTIC STRESS TEST ---")

try:
    # 3. Force REST API over gRPC to bypass aggressive local firewalls
    client = bigquery.Client(
        project="trading-data-analyst",
        client_options={"api_endpoint": "https://bigquery.googleapis.com"}
    )

    # 4. Target the verified view
    query = """
    SELECT * FROM `trading-data-analyst.naira_volatility.volatility_analytics`
    ORDER BY trade_date DESC
    LIMIT 100
    """

    print("Sending query payload with a strict 30-second timeout...")

    # 5. Stress test with explicit small timeouts
    query_job = client.query(query)

    # Force server completion check with a hard timeout limit
    print("Waiting for server response...")
    results = query_job.result(timeout=30)

    print("Server responded! Pulling data frame via standard HTTP API...")
    df = results.to_dataframe(create_bqstorage_client=False)  # Bypasses Storage API blocks

    output_file = "naira_volatility_data.csv"
    df.to_csv(output_file, index=False)
    print(f"SUCCESS! Connection open. File saved to {output_file}")

except Exception as e:
    print("\n!!! DIAGNOSTIC CATCH: Network/Permission Wall Detected !!!")
    print(f"Error Type: {type(e).__name__}")
    print(f"Details: {e}")
    sys.exit(1)