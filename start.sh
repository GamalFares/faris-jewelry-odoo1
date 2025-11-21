#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Starting Faris Jewelry Odoo"
echo "=========================================="

# Create Odoo configuration
cat > /tmp/odoo.conf << 'EOF'
[options]
addons_path = /usr/lib/python3/dist-packages/odoo/addons
data_dir = /var/lib/odoo
admin_passwd = admin
DB_HOST = dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com
DB_PORT = 5432
DB_USER = faris_jewelry_odoodb_omgw_user
DB_PASSWORD = ${DB_PASSWORD}
DB_NAME = faris_jewelry_odoodb_omgw
without_demo = all
http_port = 10000
proxy_mode = True
workers = 1
max_cron_threads = 1
list_db = False
EOF

echo "✅ Configuration created"

# Start Odoo
echo "🎯 Starting Odoo server on port 10000..."
exec /usr/bin/odoo --config=/tmp/odoo.conf --db-template=template0