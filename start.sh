#!/bin/bash
set -e

echo "Starting Odoo with official image"
echo "Database: ${PGDATABASE}"
echo "Host: ${PGHOST}" 
echo "Port: ${PGPORT}"
echo "User: ${PGUSER}"

sleep 5

# Use ONLY command line parameters, don't rely on odoo.conf for database settings
exec /entrypoint.sh odoo \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all \
    --proxy-mode