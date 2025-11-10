#!/bin/bash
set -o errexit

echo "=== Setting up Odoo 18 ==="

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Download Odoo directly to root
if [ ! -f "odoo-bin" ]; then
    echo "Downloading Odoo 18 source code..."
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo-18.0.zip
    unzip -q odoo-18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo-18.0.zip
fi

# Create custom addons directory
mkdir -p custom-addons

# Create data directory
mkdir -p /tmp/odoo-data

echo "=== Odoo 18 setup completed ==="
echo "=== Current file structure ==="
ls -la
echo "=== Looking for odoo-bin ==="
find . -name "odoo-bin" -type f
echo "=== Looking for odoo directory ==="
find . -name "odoo" -type d