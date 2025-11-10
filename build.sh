#!/bin/bash
set -e
echo "=== INSTALLING ODOO 18 ==="
pip install --upgrade pip
pip install -r requirements.txt

# Create fake zeep module to avoid import errors
mkdir -p /opt/render/project/src/.venv/lib/python3.13/site-packages/zeep/xsd
cat > /opt/render/project/src/.venv/lib/python3.13/site-packages/zeep/__init__.py << 'FAKEZEEP'
class Client: pass
class AsyncClient: pass  
class CachingClient: pass
FAKEZEEP

cat > /opt/render/project/src/.venv/lib/python3.13/site-packages/zeep/xsd/__init__.py << 'FAKEXSD'
class visitor: pass
FAKEXSD

cat > /opt/render/project/src/.venv/lib/python3.13/site-packages/zeep/xsd/visitor.py << 'FAKEVISITOR'
pass
FAKEVISITOR

wget -q https://github.com/odoo/odoo/archive/refs/heads/18.0.zip -O odoo.zip
unzip -q odoo.zip
mv odoo-18.0/* .
rm -rf odoo-18.0 odoo.zip
chmod +x odoo-bin
mkdir -p custom-addons
mkdir -p /tmp/odoo-data
echo "✓ Done"
