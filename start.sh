#!/bin/bash
set -e

echo "=========================================="
echo "🔍 PostgreSQL Connection Diagnostics"
echo "=========================================="

echo "1. Testing network connectivity..."
ping -c 2 dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com || echo "Ping failed"

echo "2. Testing port connectivity..."
nc -zv dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com 5432 || echo "Port test failed"

echo "3. Testing PostgreSQL connection with detailed error..."
PGPASSWORD="${DB_PASSWORD}" psql \
    "host=dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com \
     port=5432 \
     user=faris_jewelry_odoodb_omgw_user \
     password=${DB_PASSWORD} \
     dbname=faris_jewelry_odoodb_omgw \
     sslmode=prefer" \
    -c "SELECT version();"

echo "=========================================="
echo "🚀 Starting Odoo 18 with default settings"
echo "=========================================="

# Try starting Odoo with command-line parameters
/usr/bin/odoo \
    --db_host=dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com \
    --db_port=5432 \
    --db_user=faris_jewelry_odoodb_omgw_user \
    --db_password=${DB_PASSWORD} \
    --database=faris_jewelry_odoodb_omgw \
    --http-port=10000 \
    --without-demo=all \
    --proxy-mode