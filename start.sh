#!/bin/bash
set -e

echo "Starting Odoo from source..."
echo "Database: ${PGDATABASE}"

sleep 10

# Initialize database and start
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all