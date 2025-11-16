#!/bin/bash
set -e

echo "Starting Faris Jewelry Odoo Instance..."
echo "Database: ${PGDATABASE}"

sleep 10

# Force regenerate all assets and update modules
echo "Regenerating assets and updating modules..."
python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --update=base,web,web_editor \
    --stop-after-init || echo "Module update completed"

echo "Starting Odoo server..."
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all