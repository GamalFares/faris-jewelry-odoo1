#!/bin/bash
set -e
echo "=== INSTALLING ODOO 18 ==="
pip install --upgrade pip
pip install decorator psycopg2-binary Pillow lxml Jinja2 reportlab python-dateutil pytz Babel Werkzeug passlib requests XlsxWriter pypdf lxml-html-clean
wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo.zip
unzip -q odoo.zip
mv odoo-18.0/* .
rm -rf odoo-18.0 odoo.zip
chmod +x odoo-bin
mkdir -p custom-addons
mkdir -p /tmp/odoo-data
echo "✓ Done"
