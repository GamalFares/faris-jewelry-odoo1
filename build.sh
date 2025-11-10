#!/bin/bash
set -o errexit

echo "=== Installing Odoo 18 on Render ==="

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Create directory structure
mkdir -p src
cd src

# Download Odoo 18
if [ ! -f "odoo-bin" ]; then
    echo "Downloading Odoo 18 source code..."
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip
    unzip -q 18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 18.0.zip
fi

# Create custom addons directory
mkdir -p addons
mkdir -p /tmp/odoo-data

# Wait for database (if environment variables are set)
if [ ! -z "$PGHOST" ]; then
    echo "Waiting for database connection..."
    python ../scripts/wait_for_db.py
fi

echo "=== Odoo 18 installation complete ==="