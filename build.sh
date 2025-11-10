#!/bin/bash
set -o errexit

echo "=== Setting up Odoo 18 ==="

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Create directory structure
mkdir -p odoo-source
cd odoo-source

# Download Odoo 18 source code
if [ ! -f "odoo-bin" ]; then
    echo "Downloading Odoo 18 source code..."
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo-18.0.zip
    unzip -q odoo-18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo-18.0.zip
fi

# Create custom addons directory in the root
cd ..
mkdir -p custom-addons

# Create data directory
mkdir -p /tmp/odoo-data
chmod -R 755 /tmp/odoo-data

echo "=== Odoo 18 setup completed ==="
echo "Current directory structure:"
ls -la
echo "Odoo source contents:"
ls -la odoo-source/