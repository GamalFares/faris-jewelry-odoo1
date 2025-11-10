#!/usr/bin/env python3

import xmlrpc.client
import ssl

# Odoo connection details
url = 'YOUR_RENDER_URL'
db = 'YOUR_DATABASE_NAME'
username = 'admin'
password = 'admin'

# Create stores data
stores = [
    {
        'name': 'Downtown Jewelry',
        'code': 'DT01',
        'city': 'New York',
        'phone': '+1-555-0101'
    },
    {
        'name': 'Uptown Jewelry', 
        'code': 'UT02',
        'city': 'New York',
        'phone': '+1-555-0102'
    },
    {
        'name': 'Metro Jewelry',
        'code': 'MT03', 
        'city': 'New York',
        'phone': '+1-555-0103'
    }
]

def setup_stores():
    common = xmlrpc.client.ServerProxy('{}/xmlrpc/2/common'.format(url))
    uid = common.authenticate(db, username, password, {})
    
    models = xmlrpc.client.ServerProxy('{}/xmlrpc/2/object'.format(url))
    
    for store_data in stores:
        store_id = models.execute_kw(db, uid, password,
            'jewelry.store', 'create', [store_data])
        print(f"Created store: {store_data['name']} (ID: {store_id})")

if __name__ == '__main__':
    setup_stores()