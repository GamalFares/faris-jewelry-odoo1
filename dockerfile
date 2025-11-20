FROM odoo:17.0

# Switch to root to set permissions
USER root

# Copy configuration and script
COPY odoo.conf /app/
COPY start.sh /app/

# Make script executable as root
RUN chmod +x /app/start.sh

# Switch back to odoo user for security
USER odoo

WORKDIR /app
CMD ["/app/start.sh"]