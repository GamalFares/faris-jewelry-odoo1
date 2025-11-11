#!/bin/bash
set -e

echo "Starting Odoo with custom database settings..."
echo "Testing database connection..."

# Test connection with the exact same parameters Odoo will use
python3 -c "
import psycopg2
import time
try:
    # Test multiple times to ensure connection is stable
    for i in range(3):
        conn = psycopg2.connect(
            dbname='${PGDATABASE}',
            user='${PGUSER}',
            password='${PGPASSWORD}',
            host='${PGHOST}',
            port='${PGPORT}',
            connect_timeout=30
        )
        print(f'✅ Database connection successful (attempt {i+1})')
        conn.close()
        if i < 2:
            time.sleep(2)
except Exception as e:
    print(f'❌ Database connection failed: {e}')
    exit(1)
"

echo "All connection tests passed. Starting Odoo..."
sleep 10

# Start Odoo with explicit database initialization
exec /entrypoint.sh odoo \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --init=base \
    --without-demo=all \
    --proxy-mode