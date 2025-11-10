#!/bin/bash
set -o errexit

echo "=== Setting up Odoo 18 with Python $(python --version) ==="

# Install Python dependencies using pip only (no apt-get)
echo "Installing Python dependencies..."
pip install --upgrade pip setuptools wheel

# Install requirements without system dependencies
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "requirements.txt not found, installing basic dependencies..."
    pip install psycopg2-binary Pillow lxml Jinja2 reportlab python-dateutil pytz
fi

# Install lxml-html-clean to fix the import issue
pip install lxml-html-clean

# Download Odoo 18 source code
echo "Downloading Odoo 18 source code..."
if [ ! -f "odoo-bin" ]; then
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo-18.0.zip
    unzip -q odoo-18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo-18.0.zip
fi

# Verify odoo-bin exists
echo "Verifying installation..."
if [ -f "odoo-bin" ]; then
    echo "✓ SUCCESS: odoo-bin found in root directory"
    chmod +x odoo-bin
else
    echo "✗ ERROR: odoo-bin not found!"
    echo "Current directory:"
    ls -la
    exit 1
fi

# Create necessary directories
mkdir -p custom-addons
mkdir -p /tmp/odoo-data

echo "=== Odoo 18 setup completed successfully ==="