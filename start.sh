#!/bin/bash
set -e

echo "Starting Odoo with environment variables:"
echo "Database: ${PGDATABASE}"
echo "Host: ${PGHOST}"
echo "Port: ${PGPORT}"
echo "User: ${PGUSER}"

sleep 5

exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --workers=1 \
    --without-demo=all
