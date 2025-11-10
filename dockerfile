FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

RUN wget -q https://github.com/odoo/odoo/archive/refs/heads/17.0.zip -O odoo.zip && \
    unzip -q odoo.zip && mv odoo-17.0/* . && rm -rf odoo-17.0 odoo.zip

COPY odoo.conf .
COPY start.sh .
RUN chmod +x start.sh

RUN mkdir -p /tmp/odoo-data

EXPOSE 8069

CMD ["./start.sh"]
