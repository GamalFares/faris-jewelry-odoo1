#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo - COMPLETE RESET"
echo "Database: ${PGDATABASE}"

sleep 10

# Drop and recreate the database for clean start
echo "Resetting database..."
PGPASSWORD="${PGPASSWORD}" dropdb -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" "${PGDATABASE}" || echo "Database might not exist yet"

PGPASSWORD="${PGPASSWORD}" createdb -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" "${PGDATABASE}"

echo "Initializing Odoo with base modules..."
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