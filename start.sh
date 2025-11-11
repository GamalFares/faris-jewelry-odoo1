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
# Use a Python wrapper to force the password
exec python3 -c "
import os
import sys
sys.argv = [
    'odoo',
    '--database', os.environ['PGDATABASE'],
    '--db_host', os.environ['PGHOST'], 
    '--db_port', os.environ['PGPORT'],
    '--db_user', os.environ['PGUSER'],
    '--db_password', os.environ['PGPASSWORD'],
    '--without-demo', 'all',
    '--proxy-mode',
    '--no-database-list'
]
from odoo.cli import main
main()
"