#!/bin/bash
set -e

echo "Starting Odoo with official image"
sleep 5

exec /entrypoint.sh odoo \
    -c /etc/odoo/odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all