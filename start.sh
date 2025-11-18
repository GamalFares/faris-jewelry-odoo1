#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo Instance..."
echo "Database: ${PGDATABASE}"

sleep 10

# Nuclear option: Reset and regenerate all assets
echo "Resetting and regenerating all assets..."
python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --update=all \
    --stop-after-init

echo "Starting Odoo server with development mode..."
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all \
    --dev=all