#!/bin/bash
set -o errexit

echo "=== BULLETPROOF Odoo 18 Setup ==="

# Step 1: Upgrade pip and install wheel
echo "Step 1: Updating pip..."
pip install --upgrade pip setuptools wheel

# Step 2: Install ALL dependencies from requirements.txt
echo "Step 2: Installing ALL Odoo 18 dependencies..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    echo "ERROR: requirements.txt not found!"
    exit 1
fi

# Step 3: Install any missing critical packages individually
echo "Step 3: Installing critical packages individually..."
CRITICAL_PACKAGES="decorator psycopg2-binary Pillow lxml Jinja2 reportlab python-dateutil pytz Babel Werkzeug passlib requests"
for package in $CRITICAL_PACKAGES; do
    echo "Ensuring $package is installed..."
    python -c "import ${package%%-*}" 2>/dev/null || pip install $package
done

# Step 4: Download Odoo 18
echo "Step 4: Downloading Odoo 18 source code..."
if [ ! -f "odoo-bin" ]; then
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo-18.0.zip
    unzip -q odoo-18.0.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo-18.0.zip
fi

# Step 5: Verify installation
echo "Step 5: Verifying installation..."
if [ -f "odoo-bin" ]; then
    echo "✓ SUCCESS: odoo-bin found"
    chmod +x odoo-bin
else
    echo "✗ CRITICAL ERROR: odoo-bin not found!"
    echo "Directory contents:"
    ls -la
    exit 1
fi

# Step 6: Verify Python can import Odoo
echo "Step 6: Testing Odoo imports..."
python -c "
try:
    import odoo
    print('✓ SUCCESS: Odoo imports working')
except ImportError as e:
    print(f'✗ IMPORT ERROR: {e}')
    exit(1)
"

# Step 7: Create directories
mkdir -p custom-addons
mkdir -p /tmp/odoo-data

echo "=== ODOO 18 SETUP COMPLETED SUCCESSFULLY ==="
echo "=== ALL DEPENDENCIES INSTALLED ==="