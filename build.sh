#!/bin/bash
set -o errexit

echo "=== Setting up Odoo 18 with Python $(python --version) ==="

# Install compatible dependencies
pip install --upgrade pip setuptools wheel

# Install base dependencies first
pip install psycopg2-binary
pip install Pillow
pip install lxml
pip install Jinja2
pip install reportlab
pip install python-dateutil
pip install pytz
pip install Babel
pip install Werkzeug
pip install passlib
pip install requests
pip install XlsxWriter
pip install num2words
pip install vobject
pip install pyparsing
pip install polib
pip install pyserial
pip install ofxparse
pip install qrcode
pip install xlrd
pip install xlwt

# Create directory structure
mkdir -p src
cd src

# Download Odoo 18 source code
if [ ! -f "odoo-bin" ]; then
    echo "Downloading Odoo 18 source code..."
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo-18.0.zip
    unzip -q odoo-18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo-18.0.zip
fi

# Create custom addons directory
mkdir -p addons

# Create data directory
mkdir -p /tmp/odoo-data
chmod -R 755 /tmp/odoo-data

echo "=== Odoo 18 setup completed ==="