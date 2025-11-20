FROM odoo:17.0

# Switch to root for file operations
USER root

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Copy your existing odoo.conf and new startup script
COPY odoo.conf /app/
COPY start.sh /app/

# Install envsubst for environment variable substitution
RUN apt-get update && apt-get install -y gettext-base && \
    chmod +x /app/start.sh

# Switch back to odoo user for security
USER odoo

# Start using our custom script
CMD ["/app/start.sh"]