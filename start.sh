#!/bin/bash
set -e

echo "=========================================="
echo "Starting Faris Jewelry Odoo"
echo "=========================================="

# Use the password from environment
DB_PASSWORD="${DB_PASSWORD}"

if [ -z "$DB_PASSWORD" ]; then
    echo "❌ ERROR: DB_PASSWORD is not set in environment"
    exit 1
fi

echo "✅ Database password is set"

# Update the configuration with the actual password
echo "🔧 Configuring Odoo..."
sed -i "s/YOUR_DB_PASSWORD_PLACEHOLDER/$DB_PASSWORD/g" /tmp/odoo.conf

# Copy to Odoo's expected location
cp /tmp/odoo.conf /tmp/odoo-final.conf

echo "✅ Configuration complete"
echo "🎯 Starting Odoo server on port 10000..."

# Start Odoo
exec /usr/bin/odoo --config=/tmp/odoo-final.conf