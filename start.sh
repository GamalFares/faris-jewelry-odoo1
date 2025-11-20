#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo - PERSISTENT MODE"
echo "Database: ${PGDATABASE}"

# Debug: Check official addons path
echo "Checking official Odoo addons path..."
ls -la /usr/lib/python3/dist-packages/odoo/addons/ | grep web | head -5

sleep 5

# Check if database exists, create if it doesn't
echo "Checking database..."
if ! PGPASSWORD="${PGPASSWORD}" psql -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" -d "${PGDATABASE}" -c "SELECT 1;" > /dev/null 2>&1; then
    echo "Creating new database..."
    PGPASSWORD="${PGPASSWORD}" createdb -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" "${PGDATABASE}"
    
    echo "Initializing Odoo with base modules..."
    python /usr/bin/odoo -c /etc/odoo/odoo.conf \
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
exec python /usr/bin/odoo -c /etc/odoo/odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all