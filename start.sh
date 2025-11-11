#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo Instance..."
echo "Database: ${PGDATABASE}"

# Wait for database
sleep 10

# Start backup cron service
service cron start

# Start Odoo
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all