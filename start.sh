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
echo "🗄️ Database: ${DB_NAME}"
echo "🔐 Database User: ${DB_USER}"

# Create final configuration file with environment substitution
echo "🔧 Generating Odoo configuration..."
envsubst < /app/odoo.conf.template > /tmp/odoo.conf

# Verify the configuration was created
if [ ! -f /tmp/odoo.conf ]; then
    echo "❌ ERROR: Failed to create Odoo configuration file"
    exit 1
fi

echo "✅ Configuration file generated successfully"

# Test database connection
echo "🔌 Testing database connection..."
if ! PGPASSWORD="${DB_PASSWORD}" psql \
    -h "dpg-d496riili9vc739mmk40-a" \
    -p "5432" \
    -U "faris_jewelry_odoodb_omgw_user" \
    -d "faris_jewelry_odoodb_omgw" \
    -c "SELECT 1;" > /dev/null 2>&1; then
    
    echo "⚠️ Database connection failed or database doesn't exist"
    echo "Attempting to create database..."
    
    # Create database if it doesn't exist
    if PGPASSWORD="${DB_PASSWORD}" createdb \
        -h "dpg-d496riili9vc739mmk40-a" \
        -p "5432" \
        -U "faris_jewelry_odoodb_omgw_user" \
        "faris_jewelry_odoodb_omgw"; then
        
        echo "✅ Database created successfully"
        
        # Initialize Odoo with base modules
        echo "🚀 Initializing Odoo database..."
        /usr/bin/odoo \
            --config=/tmp/odoo.conf \
            --init=base \
            --without-demo=all \
            --stop-after-init
            
        echo "✅ Odoo database initialized"
    else
        echo "❌ ERROR: Failed to create database"
        exit 1
    fi
else
    echo "✅ Database connection successful"
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
echo "📱 Your Odoo instance will be available at:"
echo "   https://your-render-url.onrender.com"
echo "=========================================="

# Start Odoo with the generated configuration
exec /usr/bin/odoo --config=/tmp/odoo.conf