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
echo "📦 Odoo Version: 17.0"
echo "🌐 Port: 10000"
echo "🗄️ Database: ${DB_NAME:-faris_jewelry_odoodb_omgw}"

# Substitute environment variables in configuration
echo "🔧 Configuring Odoo..."
envsubst < /etc/odoo/odoo.conf > /tmp/odoo.conf

# Verify configuration was created
if [ ! -f /tmp/odoo.conf ]; then
    echo "❌ ERROR: Failed to create Odoo configuration"
    exit 1
fi

echo "✅ Configuration complete"

# Security check - ensure password isn't leaked
if grep -r "${DB_PASSWORD}" /tmp/ 2>/dev/null; then
    echo "❌ SECURITY ERROR: Password found in temporary files"
    exit 1
fi

echo "🔒 Security checks passed"

# Start Odoo server
echo "🎯 Starting Odoo server on port 10000..."
echo "📱 Your jewelry store will be available at your Render URL"
echo "=========================================="

exec /usr/bin/odoo --config=/tmp/odoo.conf