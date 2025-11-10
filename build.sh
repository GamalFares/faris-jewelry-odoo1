#!/bin/bash
set -o errexit

# Install Odoo
pip install -r requirements.txt

# Create Odoo directory structure
mkdir -p src/odoo
cd src

# Clone Odoo source
git clone https://github.com/odoo/odoo.git --depth 1 --branch 18.0 .

# Create custom addons directory
mkdir -p addons

echo "Build completed successfully!"