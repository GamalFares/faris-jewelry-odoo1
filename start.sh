#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo - PERSISTENT MODE"
echo "Database: ${PGDATABASE}"

# Debug: Check if addons directories exist
echo "Checking addons paths..."
ls -la /app/odoo/ | head -10
ls -la /app/odoo/addons/ | head -5 2>/dev/null || echo "No /app/odoo/addons directory"
ls -la /app/odoo/odoo/addons/ | head -5 2>/dev/null || echo "No /app/odoo/odoo/addons directory"

sleep 5

# Check if database exists, create if it doesn't
echo "Checking database..."
if ! PGPASSWORD="${PGPASSWORD}" psql -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" -d "${PGDATABASE}" -c "SELECT 1;" > /dev/null 2>&1; then
    echo "Creating new database..."
    PGPASSWORD="${PGPASSWORD}" createdb -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" "${PGDATABASE}"
    
    echo "Initializing Odoo with base modules..."
    python odoo-bin -c odoo.conf \
        --database="${PGDATABASE}" \
        --db_host="${PGHOST}" \
        --db_port="${PGPORT}" \
        --db_user="${PGUSER}" \
        --db_password="${PGPASSWORD}" \
        --init=base \
        --without-demo=all \
        --stop-after-init
else
    echo "Database exists - starting Odoo normally..."
fi

echo "Starting Odoo server..."
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all