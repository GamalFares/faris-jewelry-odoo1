#!/bin/bash
set -o errexit

echo "=== FINAL WORKING ODOO 18 SETUP ==="

# Step 1: Remove any pip restrictions
echo "Step 1: Cleaning pip configuration..."
pip config unset global.only-binary 2>/dev/null || true

# Step 2: Upgrade pip
echo "Step 2: Updating pip..."
pip install --upgrade pip

# Step 3: Install requirements WITHOUT binary restrictions
echo "Step 3: Installing dependencies..."
pip install -r requirements.txt

# Step 4: Download Odoo 18
echo "Step 4: Downloading Odoo 18..."
if [ ! -f "odoo-bin" ]; then
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo.zip
    unzip -q odoo.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo.zip
fi

# Step 5: Verify installation
echo "Step 5: Verifying installation..."
if [ -f "odoo-bin" ]; then
    echo "✓ odoo-bin found"
    chmod +x odoo-bin
else
    echo "✗ odoo-bin missing"
    ls -la
    exit 1
fi

# Step 6: Test imports
echo "Step 6: Testing imports..."
python -c "
try:
    import decorator, psycopg2, PIL, lxml, jinja2, reportlab, dateutil, requests
    print('✓ All critical imports successful')
except ImportError as e:
    print(f'✗ Import error: {e}')
    exit(1)
"

mkdir -p custom-addons
mkdir -p /tmp/odoo-data

echo "=== ODOO 18 READY ==="