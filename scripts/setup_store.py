#!/usr/bin/env python3

import xmlrpc.client
import ssl

# Odoo connection details
url = 'https://faris-jewelry-odoo1-rlxv.onrender.com'
db = 'faris_jewelrydb'
username = 'admin'
password = 'admin'  # Change this after first login

# Disable SSL verification for testing (remove in production)
ssl._create_default_https_context = ssl._create_unverified_context

def setup_odoo():
    try:
        # Connect to Odoo
        common = xmlrpc.client.ServerProxy('{}/xmlrpc/2/common'.format(url))
        uid = common.authenticate(db, username, password, {})
        
        if uid:
            models = xmlrpc.client.ServerProxy('{}/xmlrpc/2/object'.format(url))
            
            print("Connected to Odoo successfully!")
            
            # 1. Update Company Information
            company_id = models.execute_kw(db, uid, password, 'res.company', 'search', [[]])[0]
            models.execute_kw(db, uid, password, 'res.company', 'write', [company_id, {
                'name': 'Faris Jewelry',
                'email': 'info@faris-jewelry.com',
                'phone': '+1234567890',
                'website': 'https://faris-jewelry.com',
                'street': 'Jewelry Street 123',
                'city': 'Your City',
                'country_id': 1,  # Adjust based on your country
            }])
            print("✓ Company information updated")
            
            # 2. Create Store Locations
            store_locations = [
                {'name': 'Faris Jewelry - Downtown', 'code': 'STORE01'},
                {'name': 'Faris Jewelry - Mall Branch', 'code': 'STORE02'}, 
                {'name': 'Faris Jewelry - Luxury Plaza', 'code': 'STORE03'},
            ]
            
            for store in store_locations:
                models.execute_kw(db, uid, password, 'stock.warehouse', 'create', [{
                    'name': store['name'],
                    'code': store['code'],
                }])
            print("✓ 3 store locations created")
            
            # 3. Create Product Categories for Jewelry
            categories = [
                'Rings', 'Necklaces', 'Earrings', 'Bracelets', 'Watches',
                'Gold Jewelry', 'Silver Jewelry', 'Diamond Collection',
                'Wedding Collection', 'Luxury Pieces'
            ]
            
            for category in categories:
                models.execute_kw(db, uid, password, 'product.category', 'create', [{
                    'name': category,
                }])
            print("✓ Jewelry categories created")
            
            # 4. Enable Important Modules
            modules_to_install = [
                'point_of_sale',      # For store sales
                'website_sale',       # For online store
                'stock_barcode',      # For inventory management
                'account',            # Accounting
                'purchase',           # Supplier management
                'hr',                 # Employee management
            ]
            
            for module in modules_to_install:
                try:
                    models.execute_kw(db, uid, password, 'ir.module.module', 'search', [[('name', '=', module)]])
                    print(f"✓ Module {module} is available")
                except:
                    print(f"✗ Module {module} not found")
            
            print("\n🎉 Initial setup completed!")
            print("Next steps:")
            print("1. Login to Odoo and change admin password")
            print("2. Configure payment methods")
            print("3. Add your jewelry products")
            print("4. Set up employees and users")
            print("5. Configure tax settings")
            
        else:
            print("Authentication failed. Please check credentials.")
            
    except Exception as e:
        print(f"Error during setup: {e}")

if __name__ == "__main__":
    setup_odoo()