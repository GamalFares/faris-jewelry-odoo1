#!/bin/bash
set -e

echo "Starting Odoo with environment variables:"
echo "Database: ${PGDATABASE}"
echo "Host: ${PGHOST}"
echo "Port: ${PGPORT}"
echo "User: ${PGUSER}"

sleep 5

# Check if database exists and initialize if needed
echo "Checking database status..."

# Try to initialize the database with base modules
python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --init=base,web \
    --without-demo=all \
    --stop-after-init

echo "Database initialization completed. Starting Odoo server..."

# Start Odoo normally
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --workers=1 \
    --without-demo=all