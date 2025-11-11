#!/bin/bash
set -e

echo "Starting Odoo with official image"
echo "Database: ${PGDATABASE}"
echo "Host: ${PGHOST}"
echo "Port: ${PGPORT}"
echo "User: ${PGUSER}"

# Test database connection first
echo "Testing database connection..."
python3 -c "
import psycopg2
try:
    conn = psycopg2.connect(
        dbname='${PGDATABASE}',
        user='${PGUSER}',
        password='${PGPASSWORD}',
        host='${PGHOST}',
        port='${PGPORT}'
    )
    print('✅ Database connection successful')
    conn.close()
except Exception as e:
    print(f'❌ Database connection failed: {e}')
    exit(1)
"

sleep 5

echo "Starting Odoo server..."
exec /entrypoint.sh odoo \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all