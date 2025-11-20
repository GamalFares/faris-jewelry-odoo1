#!/bin/bash
set -e

echo "=========================================="
echo "Starting Faris Jewelry Odoo - SECURE MODE"
echo "=========================================="

# Validate required environment variables
if [ -z "${DB_PASSWORD}" ]; then
    echo "❌ ERROR: DB_PASSWORD environment variable is not set"
    echo "Please set DB_PASSWORD in your Render environment variables"
    exit 1
fi

echo "✅ Environment variables validated"
echo "📦 Odoo Version: 17.0"
echo "🌐 HTTP Port: 10000"

# Replace the password placeholder in your existing odoo.conf
echo "🔧 Updating Odoo configuration with environment variables..."
sed -i "s/YOUR_DB_PASSWORD_PLACEHOLDER/${DB_PASSWORD}/g" /app/odoo.conf

# Copy the updated config to Odoo's expected location
cp /app/odoo.conf /tmp/odoo.conf

echo "✅ Configuration updated successfully"

# Test database connection
echo "🔌 Testing database connection..."
if PGPASSWORD="${DB_PASSWORD}" psql \
    -h "dpg-d496riili9vc739mmk40-a" \
    -p "5432" \
    -U "faris_jewelry_odoodb_omgw_user" \
    -d "faris_jewelry_odoodb_omgw" \
    -c "SELECT 1;" > /dev/null 2>&1; then
    
    echo "✅ Database connection successful"
else
    echo "⚠️ Database connection failed - Odoo will attempt to create database"
fi

# Security check: Ensure password is not in any log files
echo "🔒 Performing security checks..."
if grep -r "${DB_PASSWORD}" /tmp/ 2>/dev/null; then
    echo "❌ SECURITY WARNING: Password found in temporary files!"
    exit 1
fi
echo "✅ Security checks passed"

# Start Odoo server
echo "🎯 Starting Odoo server on port 10000..."
echo "📱 Your Odoo instance will be available soon!"
echo "=========================================="

# Start Odoo with the configuration
exec /usr/bin/odoo --config=/tmp/odoo.conf