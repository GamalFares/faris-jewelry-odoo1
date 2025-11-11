#!/bin/bash
set -e

echo "Starting Odoo from source..."
echo "Database: ${PGDATABASE}"

sleep 10

# Initialize database first, then start
echo "Initializing database..."
python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --init=base \
    --without-demo=all \
    --stop-after-init

echo "Starting Odoo server..."
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all