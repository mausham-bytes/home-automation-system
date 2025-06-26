# Setup Instructions for Home Automation System

## Quick Start Guide

This guide will help you set up the complete home automation system on your local machine.

## Prerequisites

Before starting, ensure you have the following installed:

- **Python 3.8 or higher**
- **Node.js 16 or higher**
- **Git**
- **A terminal/command prompt**

## Step-by-Step Setup

### 1. Download the Project

```bash
# Clone or download the project files
# If using Git:
git clone <your-repository-url>
cd home-automation-system

# If downloaded as ZIP, extract and navigate to the folder
```

### 2. Set Up the Backend Server

```bash
# Navigate to the backend directory
cd home_automation_backend

# Create a Python virtual environment
python -m venv venv

# Activate the virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install required Python packages
pip install -r requirements.txt
```

### 3. Set Up the Frontend Application

```bash
# Open a new terminal and navigate to the frontend directory
cd home_automation_frontend

# Install Node.js dependencies
npm install
```

### 4. Install and Configure MQTT Broker

#### On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install mosquitto mosquitto-clients
sudo systemctl start mosquitto
sudo systemctl enable mosquitto
```

#### On Windows:
1. Download Mosquitto from https://mosquitto.org/download/
2. Install and start the service
3. Or use the provided setup script

#### On macOS:
```bash
brew install mosquitto
brew services start mosquitto
```

### 5. Start the System

You'll need to run multiple components. Open separate terminal windows for each:

#### Terminal 1 - Backend Server:
```bash
cd home_automation_backend
source venv/bin/activate  # On Windows: venv\Scripts\activate
python src/main.py
```

#### Terminal 2 - Frontend Application:
```bash
cd home_automation_frontend
npm run dev
```

#### Terminal 3 - Device Simulator (for testing):
```bash
cd iot_devices
python device_simulator.py
```

### 6. Access the Application

1. Open your web browser
2. Navigate to `http://localhost:5173`
3. You should see the Smart Home Automation interface

## Testing the System

### Add Your First Device

1. Click the "Add Device" button
2. Fill in the form:
   - **Device Name**: "Living Room Light"
   - **Device Type**: Select "Light"
   - **Room**: "living_room"
   - **MQTT Topic**: Leave empty (auto-generated)
3. Click "Add Device"

### Control the Device

1. You should see the device card appear
2. Use the toggle switch to turn the light on/off
3. Adjust the brightness slider
4. The device simulator will show the commands being received

### Create a Schedule

1. Click the "Schedules" tab
2. Click "Add Schedule"
3. Fill in the schedule details:
   - **Schedule Name**: "Morning Light"
   - **Device**: Select your device
   - **Action**: "Turn On"
   - **Time**: "07:00"
   - **Days**: Select weekdays
4. Click "Create Schedule"

## Hardware Setup (Optional)

If you have ESP32/ESP8266 hardware:

### For Light Control:
1. Connect an LED to GPIO pin 2 on your ESP32
2. Upload the `esp32_light_controller.ino` code
3. Update WiFi credentials and MQTT broker IP in the code
4. The device will appear in your system automatically

### For Fan Control:
1. Connect a relay module to GPIO pin 4 on your ESP32
2. Upload the `esp32_fan_controller.ino` code
3. Update WiFi credentials and MQTT broker IP in the code
4. Connect your fan to the relay output

## Troubleshooting

### Backend Won't Start
- Check if port 5000 is already in use
- Ensure Python virtual environment is activated
- Verify all dependencies are installed

### Frontend Won't Load
- Check if port 5173 is available
- Ensure Node.js dependencies are installed
- Try clearing npm cache: `npm cache clean --force`

### MQTT Connection Issues
- Verify Mosquitto is running: `sudo systemctl status mosquitto`
- Test MQTT manually:
  ```bash
  mosquitto_pub -h localhost -t test/topic -m "hello"
  mosquitto_sub -h localhost -t test/topic
  ```

### Device Simulator Not Working
- Ensure MQTT broker is running
- Check Python dependencies are installed
- Verify no firewall is blocking connections

## Production Deployment

For production use:

1. **Security**: Configure MQTT authentication
2. **Database**: Consider using PostgreSQL instead of SQLite
3. **Web Server**: Use a production WSGI server like Gunicorn
4. **Reverse Proxy**: Set up Nginx for the frontend
5. **SSL/TLS**: Enable HTTPS for secure communication

## Getting Help

If you encounter issues:

1. Check the troubleshooting section above
2. Review the console output for error messages
3. Ensure all prerequisites are properly installed
4. Verify network connectivity between components

## Next Steps

Once the system is running:

1. Explore the web interface
2. Add multiple devices
3. Create various schedules
4. Test with real hardware if available
5. Customize the system for your specific needs

---

**Congratulations! Your home automation system is now ready to use.**

