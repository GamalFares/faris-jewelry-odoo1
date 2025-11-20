#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo - PERSISTENT MODE"
echo "Using official Odoo 17.0 image"

# Debug: Check if web module exists
echo "Checking for web module..."
ls -la /usr/lib/python3/dist-packages/odoo/addons/ | grep web

sleep 5

# Check if database exists, create if it doesn't
echo "Checking database..."
if ! PGPASSWORD="${DB_PASSWORD}" psql -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -d "${DB_NAME}" -c "SELECT 1;" > /dev/null 2>&1; then
    echo "Creating new database..."
    PGPASSWORD="${DB_PASSWORD}" createdb -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" "${DB_NAME}"
    
    echo "Initializing Odoo with base modules..."
    /usr/bin/odoo -c /etc/odoo/odoo.conf \
        --database="${DB_NAME}" \
        --db_host="${DB_HOST}" \
        --db_port="${DB_PORT}" \
        --db_user="${DB_USER}" \
        --db_password="${DB_PASSWORD}" \
        --init=base \
        --without-demo=all \
        --stop-after-init
else
    echo "Database exists - starting Odoo normally..."
fi

echo "Starting Odoo server..."
exec /usr/bin/odoo -c /etc/odoo/odoo.conf \
    --database="${DB_NAME}" \
    --db_host="${DB_HOST}" \
    --db_port="${DB_PORT}" \
    --db_user="${DB_USER}" \
    --db_password="${DB_PASSWORD}" \
    --without-demo=all