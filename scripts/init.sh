#!/bin/bash
set -o errexit

echo "Initializing Odoo database..."

# Wait for PostgreSQL to be ready
sleep 10

# Initialize Odoo database
python src/odoo-bin -c odoo.conf --init base --without-demo=all --stop-after-init

echo "Database initialization completed!"