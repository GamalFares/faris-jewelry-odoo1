#!/bin/bash
set -o errexit

echo "=== Installing Odoo 18 from Source ==="

# Install system dependencies (for PostgreSQL and other required libraries)
apt-get update
apt-get install -y python3-dev build-essential

# Install Python dependencies directly
pip install --upgrade pip
pip install psycopg2-binary==2.9.7
pip install Pillow==10.0.1
pip install Jinja2==3.1.2
pip install lxml==4.9.3
pip install reportlab==4.0.4
pip install python-dateutil==2.8.2
pip install pytz==2023.3
pip install Babel==2.12.1
pip install Werkzeug==2.3.7
pip install passlib==1.7.4
pip install requests==2.31.0
pip install XlsxWriter==3.1.2
pip install num2words==0.5.12
pip install vobject==0.9.6.1
pip install pyparsing==3.1.1

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

# Install Odoo dependencies from requirements.txt in Odoo source
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Create custom addons directory
mkdir -p addons

# Create data directory
mkdir -p /tmp/odoo-data
chmod -R 755 /tmp/odoo-data

echo "=== Odoo 18 installation completed successfully ==="