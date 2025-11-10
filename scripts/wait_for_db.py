#!/usr/bin/env python3
import os
import time
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def wait_for_db():
    max_retries = 30
    retry_count = 0
    
    while retry_count < max_retries:
        try:
            conn = psycopg2.connect(
                host=os.getenv('PGHOST'),
                port=os.getenv('PGPORT', 5432),
                user=os.getenv('PGUSER'),
                password=os.getenv('PGPASSWORD'),
                database=os.getenv('PGDATABASE', 'postgres')
            )
            print("Database connection successful!")
            conn.close()
            return True
        except Exception as e:
            retry_count += 1
            print(f"Database connection failed (attempt {retry_count}/{max_retries}): {e}")
            time.sleep(2)
    
    print("Failed to connect to database after maximum retries")
    return False

if __name__ == '__main__':
    wait_for_db()