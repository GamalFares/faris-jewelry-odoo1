from odoo import models, fields, api

class JewelryStore(models.Model):
    _name = 'jewelry.store'
    _description = 'Jewelry Store'
    
    name = fields.Char(string='Store Name', required=True)
    code = fields.Char(string='Store Code', required=True)
    street = fields.Char(string='Street')
    city = fields.Char(string='City')
    country_id = fields.Many2one('res.country', string='Country')
    phone = fields.Char(string='Phone')
    email = fields.Char(string='Email')
    manager_id = fields.Many2one('res.users', string='Store Manager')
    warehouse_id = fields.Many2one('stock.warehouse', string='Warehouse')
    pos_config_id = fields.Many2one('pos.config', string='POS Configuration')
    active = fields.Boolean(string='Active', default=True)