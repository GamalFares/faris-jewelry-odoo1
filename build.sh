#!/bin/bash
set -o errexit

echo "Starting Odoo 18 build process..."

# Install Odoo and dependencies
pip install -r requirements.txt

# Create directory structure
mkdir -p src/odoo
mkdir -p src/addons
cd src

# Clone Odoo source if not exists
if [ ! -f "odoo-bin" ]; then
    echo "Downloading Odoo 18 source code..."
    git clone https://github.com/odoo/odoo.git --depth 1 --branch 18.0 .
fi

# Create necessary directories
mkdir -p /tmp/odoo-data
mkdir -p /tmp/odoo-sessions

echo "Odoo 18 build completed successfully!"