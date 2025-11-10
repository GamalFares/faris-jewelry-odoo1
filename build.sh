#!/bin/bash
set -e
echo "Installing Odoo 17 dependencies..."
pip install --upgrade pip
pip install -r requirements.txt
wget -q https://github.com/odoo/odoo/archive/refs/heads/17.0.zip -O odoo.zip
unzip -q odoo.zip
mv odoo-17.0/* .
rm -rf odoo-17.0 odoo.zip
mkdir -p /tmp/odoo-data
echo "Build completed"
