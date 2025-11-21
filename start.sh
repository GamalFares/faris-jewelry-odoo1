#!/bin/bash
set -e

echo "=========================================="
echo "🔍 Testing PostgreSQL Connection"
echo "=========================================="

# Test if we can connect to PostgreSQL at all
echo "Testing connection to PostgreSQL..."
if PGPASSWORD="${DB_PASSWORD}" psql \
    "host=dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com \
     port=5432 \
     user=faris_jewelry_odoodb_omgw_user \
     password=${DB_PASSWORD} \
     dbname=faris_jewelry_odoodb_omgw \
     sslmode=disable" \
    -c "SELECT 1;" 2>/dev/null; then
    echo "✅ SUCCESS: Can connect WITHOUT SSL"
    echo "Starting Odoo with SSL disabled..."
    SSL_MODE="disable"
else
    echo "❌ FAILED: Cannot connect without SSL"
    echo "Trying with SSL..."
    if PGPASSWORD="${DB_PASSWORD}" psql \
        "host=dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com \
         port=5432 \
         user=faris_jewelry_odoodb_omgw_user \
         password=${DB_PASSWORD} \
         dbname=faris_jewelry_odoodb_omgw \
         sslmode=require" \
        -c "SELECT 1;" 2>/dev/null; then
        echo "✅ SUCCESS: Can connect WITH SSL"
        SSL_MODE="require"
    else
        echo "❌ CRITICAL: Cannot connect with or without SSL"
        echo "Please check:"
        echo "1. Database is running in Render"
        echo "2. Password is correct"
        echo "3. Hostname is correct"
        exit 1
    fi
fi

echo "=========================================="
echo "🚀 Starting Odoo with SSL mode: ${SSL_MODE}"
echo "=========================================="

# Create configuration based on test results
cat > /tmp/odoo.conf << EOF
[options]
addons_path = /usr/lib/python3/dist-packages/odoo/addons
data_dir = /var/lib/odoo
admin_passwd = admin
db_host = dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com
db_port = 5432
db_user = faris_jewelry_odoodb_omgw_user
db_password = ${DB_PASSWORD}
db_name = faris_jewelry_odoodb_omgw
without_demo = all
http_port = 10000
proxy_mode = True
db_sslmode = ${SSL_MODE}
workers = 1
list_db = False
EOF

# Start Odoo
echo "Starting Odoo server..."
exec /usr/bin/odoo --config=/tmp/odoo.conf