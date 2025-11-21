#!/bin/bash
set -e

echo "=========================================="
echo "🚀 Starting Faris Jewelry Odoo"
echo "=========================================="

# Validate environment variables
if [ -z "${DB_PASSWORD}" ]; then
    echo "❌ ERROR: DB_PASSWORD environment variable is not set"
    echo "Please set DB_PASSWORD in your Render environment variables"
    exit 1
fi

echo "✅ Environment validation passed"

# Test database connection with SSL first
echo "🔌 Testing database connection with SSL..."
if PGPASSWORD="${DB_PASSWORD}" psql \
    "postgresql://faris_jewelry_odoodb_omgw_user:${DB_PASSWORD}@dpg-cnufmnt109ks73bdjj80-a.oregon-postgres.render.com:5432/faris_jewelry_odoodb_omgw?sslmode=require" \
    -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Database connection successful with SSL"
else
    echo "❌ Database connection failed - SSL issue persists"
    echo "Trying without SSL for initial setup..."
fi

# Substitute environment variables in configuration
echo "🔧 Configuring Odoo..."
envsubst < /etc/odoo/odoo.conf > /tmp/odoo.conf

# Verify configuration was created
if [ ! -f /tmp/odoo.conf ]; then
    echo "❌ ERROR: Failed to create Odoo configuration"
    exit 1
fi

echo "✅ Configuration complete"

# Start Odoo server
echo "🎯 Starting Odoo server on port 10000..."
echo "📱 Your jewelry store will be available at your Render URL"
echo "=========================================="

exec /usr/bin/odoo --config=/tmp/odoo.conf --db-template=template0