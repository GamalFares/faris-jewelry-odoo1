#!/bin/bash
set -e

echo "Starting Odoo with environment variables:"
echo "Database: ${PGDATABASE}"
echo "Host: ${PGHOST}"
echo "Port: ${PGPORT}"
echo "User: ${PGUSER}"

# Wait for database to be ready
sleep 10

# Initialize database if needed
echo "Initializing Odoo database..."
python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --init=base \
    --without-demo=all \
    --stop-after-init || echo "Database initialization completed or already exists"

echo "Starting Odoo server..."
exec python odoo-bin -c odoo.conf \
    --database="${PGDATABASE}" \
    --db_host="${PGHOST}" \
    --db_port="${PGPORT}" \
    --db_user="${PGUSER}" \
    --db_password="${PGPASSWORD}" \
    --workers=1 \
    --without-demo=all