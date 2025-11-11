#!/bin/bash
set -e

echo "Starting Odoo with custom database settings..."
sleep 5

# Force ALL database settings via command line - no defaults
exec /entrypoint.sh odoo \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --db_name="${PGDATABASE}" \
    --without-demo=all \
    --proxy-mode \
    --no-database-list