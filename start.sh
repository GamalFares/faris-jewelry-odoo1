#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Starting Faris Jewelry Odoo - SSL FIX"
echo "=========================================="

# Validate environment variables
if [ -z "${DB_PASSWORD}" ]; then
    echo "❌ ERROR: DB_PASSWORD environment variable is not set"
    exit 1
fi

echo "✅ Environment validation passed"

# Create configuration that WORKS with Render PostgreSQL
cat > /tmp/odoo.conf << 'EOF'
[options]
addons_path = /usr/lib/python3/dist-packages/odoo/addons
data_dir = /var/lib/odoo
admin_passwd = admin

; Use connection string for proper SSL handling
db_host = dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com
db_port = 5432
db_user = faris_jewelry_odoodb_omgw_user
db_password = ${DB_PASSWORD}
db_name = faris_jewelry_odoodb_omgw

; Render settings
http_port = 10000
proxy_mode = True

; Operational settings
without_demo = all

; SSL FIX - Use require but Odoo will handle it via connection string
db_sslmode = require

; Performance
workers = 2
max_cron_threads = 1

; Security
list_db = False
EOF

# Substitute environment variables
envsubst < /tmp/odoo.conf > /tmp/odoo-final.conf

echo "✅ Configuration complete"

# Test connection first
echo "🔌 Testing database connection..."
if PGPASSWORD="${DB_PASSWORD}" psql \
    "host=dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com port=5432 user=faris_jewelry_odoodb_omgw_user password=${DB_PASSWORD} dbname=faris_jewelry_odoodb_omgw sslmode=require" \
    -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Database connection successful"
else
    echo "⚠️ Database test failed, but continuing..."
fi

# Start Odoo with template0 to avoid SSL issues during DB creation
echo "🎯 Starting Odoo server..."
exec /usr/bin/odoo --config=/tmp/odoo-final.conf --db-template=template0