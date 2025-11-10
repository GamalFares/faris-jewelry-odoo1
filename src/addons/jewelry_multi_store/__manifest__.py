{
    'name': 'Jewelry Multi-Store',
    'version': '18.0.1.0',
    'category': 'Sales',
    'summary': 'Multi-store management for jewelry business',
    'description': """
        Manage multiple jewelry stores in single Odoo instance
    """,
    'author': 'Your Jewelry Store',
    'website': 'https://www.yourjewelrystore.com',
    'depends': ['sale', 'point_of_sale', 'stock'],
    'data': [
        'security/ir.model.access.csv',
        'views/store_views.xml',
        'views/sale_views.xml',
        'views/pos_views.xml',
    ],
    'demo': [],
    'installable': True,
    'application': True,
    'auto_install': False,
}