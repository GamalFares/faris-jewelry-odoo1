FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    wget \
    unzip \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Download Odoo 17
RUN wget -q https://github.com/odoo/odoo/archive/refs/heads/17.0.zip -O odoo.zip && \
    unzip -q odoo.zip && \
    mv odoo-17.0/* . && \
    rm -rf odoo-17.0 odoo.zip

# Copy configuration and custom addons
COPY odoo.conf .
COPY custom-addons/ ./custom-addons/

# Create necessary directories
RUN mkdir -p /var/lib/odoo

# Expose Odoo port
EXPOSE 8069

# Start Odoo
CMD ["python", "odoo-bin", "-c", "odoo.conf", "--workers=2", "--without-demo=all"]