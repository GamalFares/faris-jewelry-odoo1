#!/bin/bash
set -e

echo "=========================================="
echo "Starting Faris Jewelry Odoo"
echo "=========================================="

# Use the password directly (Render should pass it)
DB_PASSWORD="${DB_PASSWORD}"
echo "Using DB_PASSWORD from environment"

# Check if we have a password
if [ -z "$DB_PASSWORD" ]; then
    echo "❌ ERROR: DB_PASSWORD is not set in environment"
    echo "Please check your Render environment variables"
    exit 1
fi

echo "✅ Database password is set"
echo "📦 Odoo Version: 17.0"
echo "🌐 HTTP Port: 10000"

# Update the configuration with the actual password
echo "🔧 Configuring Odoo..."
sed -i "s/YOUR_DB_PASSWORD_PLACEHOLDER/$DB_PASSWORD/g" /app/odoo.conf

# Copy to Odoo's expected location
cp /app/odoo.conf /tmp/odoo.conf

echo "✅ Configuration complete"

# Start Odoo server
echo "🎯 Starting Odoo server on port 10000..."
exec /usr/bin/odoo --config=/tmp/odoo.conf