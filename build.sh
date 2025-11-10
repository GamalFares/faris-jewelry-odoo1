#!/bin/bash
set -o errexit

echo "=== FINAL ODOO 18 SETUP (BINARY WHEELS ONLY) ==="

# Step 1: Force pip to use only binary wheels
echo "Step 1: Configuring pip for binary wheels only..."
pip config set global.only-binary :all:

# Step 2: Upgrade pip
echo "Step 2: Updating pip..."
pip install --upgrade pip

# Step 3: Install requirements with NO BUILD
echo "Step 3: Installing dependencies (binary wheels only)..."
pip install --only-binary=:all: -r requirements.txt

# Step 4: If Pillow fails, try specific binary version
echo "Step 4: Ensuring Pillow is installed..."
python -c "import PIL" 2>/dev/null || pip install --only-binary=:all: Pillow==10.2.0

# Step 5: Download Odoo 18
echo "Step 5: Downloading Odoo 18..."
if [ ! -f "odoo-bin" ]; then
    wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo.zip
    unzip -q odoo.zip
    mv odoo-18.0/* .
    rm -rf odoo-18.0 odoo.zip
fi

# Step 6: Verify
echo "Step 6: Verifying installation..."
if [ -f "odoo-bin" ]; then
    echo "✓ odoo-bin found"
    chmod +x odoo-bin
else
    echo "✗ odoo-bin missing"
    ls -la
    exit 1
fi

# Step 7: Test critical imports
echo "Step 7: Testing critical imports..."
python -c "
import sys
critical_imports = ['decorator', 'psycopg2', 'PIL', 'lxml', 'jinja2']
for imp in critical_imports:
    try:
        __import__(imp)
        print(f'✓ {imp}')
    except ImportError as e:
        print(f'✗ {imp}: {e}')
        sys.exit(1)
print('✓ All critical imports successful')
"

mkdir -p custom-addons
mkdir -p /tmp/odoo-data

echo "=== ODOO 18 READY FOR DEPLOYMENT ==="