#!/bin/bash

# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Setup local PostgreSQL (if you have Docker)
docker run -d \
  --name odoo-postgres \
  -e POSTGRES_DB=jewelry_odoo \
  -e POSTGRES_USER=odoo \
  -e POSTGRES_PASSWORD=odoo \
  -p 5432:5432 \
  postgres:13

echo "Local setup complete!"
echo "Start Odoo with: python src/odoo-bin -c odoo.conf --dev=reload"