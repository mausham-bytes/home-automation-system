#!/bin/bash

# MQTT Broker Setup Script for Home Automation System
# This script installs and configures Mosquitto MQTT broker

echo "=== Home Automation MQTT Broker Setup ==="
echo "This script will install and configure Mosquitto MQTT broker"
echo

# Update package list
echo "Updating package list..."
sudo apt update

# Install Mosquitto MQTT broker and clients
echo "Installing Mosquitto MQTT broker..."
sudo apt install -y mosquitto mosquitto-clients

# Create mosquitto configuration
echo "Creating Mosquitto configuration..."
sudo tee /etc/mosquitto/conf.d/home_automation.conf > /dev/null << EOF
# Home Automation MQTT Configuration
listener 1883
allow_anonymous true
persistence true
persistence_location /var/lib/mosquitto/

# Logging
log_dest file /var/log/mosquitto/mosquitto.log
log_type error
log_type warning
log_type notice
log_type information

# Connection logging
connection_messages true
log_timestamp true
EOF

# Enable and start Mosquitto service
echo "Enabling and starting Mosquitto service..."
sudo systemctl enable mosquitto
sudo systemctl restart mosquitto

# Check service status
echo "Checking Mosquitto service status..."
sudo systemctl status mosquitto --no-pager

# Test MQTT broker
echo
echo "Testing MQTT broker..."
echo "Publishing test message..."
mosquitto_pub -h localhost -t test/topic -m "Hello from Home Automation System"

echo "Subscribing to test topic (will timeout after 5 seconds)..."
timeout 5s mosquitto_sub -h localhost -t test/topic || true

echo
echo "=== MQTT Broker Setup Complete ==="
echo "Mosquitto MQTT broker is now running on localhost:1883"
echo "You can test it using:"
echo "  mosquitto_pub -h localhost -t test/topic -m 'test message'"
echo "  mosquitto_sub -h localhost -t test/topic"
echo

