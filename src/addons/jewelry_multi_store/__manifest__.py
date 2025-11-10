{
    'name': 'Jewelry Multi-Store Management',
    'version': '17.0.1.0',
    'category': 'Sales/Point of Sale',
    'summary': 'Manage multiple jewelry stores',
    'description': """
        This module allows you to manage multiple jewelry stores from a single Odoo instance.
    """,
    'author': 'Your Jewelry Store',
    'website': 'https://www.yourjewelrystore.com',
    'depends': ['point_of_sale', 'stock', 'sale'],
    'data': [
        'security/ir.model.access.csv',
        'views/store_views.xml',
        'views/menu.xml',
    ],
    'demo': [],
    'installable': True,
    'application': True,
    'auto_install': False,
    'license': 'LGPL-3',
}