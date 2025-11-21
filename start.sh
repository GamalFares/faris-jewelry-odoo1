#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Starting Odoo with SSL"
echo "=========================================="

# Create configuration with SSL
cat > /tmp/odoo.conf << 'EOF'
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
db_sslmode = require
workers = 1
list_db = False
EOF

envsubst < /tmp/odoo.conf > /tmp/odoo-final.conf
exec /usr/bin/odoo --config=/tmp/odoo-final.conf