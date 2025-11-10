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
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo-18.0.zip
    unzip -q odoo-18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo-18.0.zip
fi

# Create custom addons directory
mkdir -p addons

# Create data directory with proper permissions
mkdir -p /tmp/odoo-data
chmod -R 755 /tmp/odoo-data

# Verify Odoo installation
if [ -f "odoo-bin" ]; then
    echo "Odoo installed successfully"
    echo "Odoo version:"
    python odoo-bin --version || true
else
    echo "ERROR: Odoo installation failed"
    exit 1
fi

echo "=== Build completed successfully ==="