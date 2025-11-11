#!/bin/bash
set -e

echo "Starting Odoo on Free Tier"
echo "Database: ${PGDATABASE}"

# Minimal wait for free tier
sleep 5

# Start Odoo with minimal settings for faster startup
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --without-demo=all \
    --workers=1 \
    --max-cron-threads=1