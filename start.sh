#!/bin/bash
set -e

echo "Starting Odoo with custom database settings..."
echo "Testing database connection..."

# Test connection with detailed error
python3 -c "
import psycopg2
import sys
try:
    conn = psycopg2.connect(
        dbname='${PGDATABASE}',
        user='${PGUSER}',
        password='${PGPASSWORD}',
        host='${PGHOST}',
        port='${PGPORT}',
        connect_timeout=10
    )
    print('✅ Database connection successful')
    conn.close()
except Exception as e:
    print(f'❌ Database connection failed: {e}')
    sys.exit(1)
"

sleep 5

echo "Starting Odoo server..."
exec /entrypoint.sh odoo \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --db_name="${PGDATABASE}" \
    --without-demo=all \
    --proxy-mode \
    --no-database-list