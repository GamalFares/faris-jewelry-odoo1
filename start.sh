#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo Instance..."
echo "Database: ${PGDATABASE}"

sleep 10

# Force complete asset regeneration and module update
echo "Performing complete system reset..."
python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --init=base,web \
    --update=all \
    --load=base,web \
    --stop-after-init

echo "Starting Odoo server..."
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all