#!/bin/bash
set -e

echo "Starting Odoo with official image"
echo "Database: ${PGDATABASE}"
echo "Host: ${PGHOST}"
echo "Port: ${PGPORT}"
echo "User: ${PGUSER}"

sleep 5

# Use the actual environment variable values, not the placeholder strings
exec /entrypoint.sh odoo \
    -c /etc/odoo/odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all