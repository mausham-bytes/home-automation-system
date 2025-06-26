# Smart Home Automation System

A comprehensive IoT-based home automation system that enables control of multiple devices (lights, fans) through MQTT communication, featuring a modern web interface and mobile-responsive design.

## 🏠 Overview

This project provides a complete home automation solution with:
- **Web-based Control Panel**: Modern React frontend for device management
- **RESTful API Backend**: Flask-based server with MQTT integration
- **IoT Device Support**: ESP32/ESP8266 compatible device controllers
- **Real-time Communication**: MQTT protocol for instant device control
- **Scheduling System**: Automated device control based on time schedules
- **Mobile Responsive**: Works seamlessly on smartphones and tablets

## 🚀 Features

### Device Management
- ✅ Add, edit, and delete smart devices
- ✅ Support for lights (with brightness control)
- ✅ Support for fans (with speed control)
- ✅ Real-time device status monitoring
- ✅ Room-based organization

### Scheduling
- ✅ Create time-based automation schedules
- ✅ Day-of-week selection for recurring tasks
- ✅ Multiple actions per device (on/off, brightness, speed)
- ✅ Schedule management and deletion

### User Interface
- ✅ Modern, responsive web design
- ✅ Intuitive device cards with visual controls
- ✅ Real-time status updates
- ✅ Error handling and user notifications
- ✅ Mobile-friendly interface

### Technical Features
- ✅ MQTT communication protocol
- ✅ RESTful API architecture
- ✅ SQLite database for data persistence
- ✅ CORS-enabled for cross-origin requests
- ✅ Comprehensive error handling

## 🏗️ System Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Web Frontend  │    │  Flask Backend  │    │  MQTT Broker    │
│   (React)       │◄──►│   (Python)      │◄──►│  (Mosquitto)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │                        ▲
                                ▼                        │
                       ┌─────────────────┐               │
                       │   SQLite DB     │               │
                       │   (Devices &    │               │
                       │   Schedules)    │               │
                       └─────────────────┘               │
                                                         │
                       ┌─────────────────┐               │
                       │  IoT Devices    │◄──────────────┘
                       │  (ESP32/ESP8266)│
                       │  - Lights       │
                       │  - Fans         │
                       └─────────────────┘
```

## 📋 Prerequisites

### Software Requirements
- Python 3.8+
- Node.js 16+
- npm or pnpm
- Git

### Hardware Requirements (Optional)
- ESP32 or ESP8266 development boards
- LED strips or smart bulbs
- Relay modules for fan control
- Breadboard and jumper wires

## 🛠️ Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd home-automation-system
```

### 2. Backend Setup
```bash
cd home_automation_backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Frontend Setup
```bash
cd home_automation_frontend
npm install
```

### 4. MQTT Broker Setup
```bash
# Install Mosquitto MQTT broker
sudo apt update
sudo apt install mosquitto mosquitto-clients

# Start the broker
sudo systemctl start mosquitto
sudo systemctl enable mosquitto
```

### 5. Start the System
```bash
# Terminal 1: Start MQTT Broker (if not running as service)
mosquitto -v

# Terminal 2: Start Backend Server
cd home_automation_backend
source venv/bin/activate
python src/main.py

# Terminal 3: Start Frontend Development Server
cd home_automation_frontend
npm run dev

# Terminal 4: Start Device Simulator (for testing)
cd iot_devices
python device_simulator.py
```

## 🎮 Usage

### Web Interface
1. Open your browser and navigate to `http://localhost:5173`
2. Click "Add Device" to register new smart devices
3. Fill in device details (name, type, room)
4. Control devices using the toggle switches and sliders
5. Create schedules in the "Schedules" tab

### API Endpoints
- `GET /api/devices` - List all devices
- `POST /api/devices` - Create new device
- `PUT /api/devices/{id}` - Update device
- `DELETE /api/devices/{id}` - Delete device
- `POST /api/devices/{id}/control` - Control device
- `GET /api/schedules` - List all schedules
- `POST /api/schedules` - Create new schedule
- `DELETE /api/schedules/{id}` - Delete schedule

### MQTT Topics
- Command: `home/{room}/{device_name}/command`
- Status: `home/{room}/{device_name}/status`

## 🔧 Hardware Setup

### ESP32 Light Controller
```cpp
// Connect LED to GPIO pin 2
// Upload esp32_light_controller.ino to your ESP32
// Update WiFi credentials and MQTT broker IP
```

### ESP32 Fan Controller
```cpp
// Connect relay/motor driver to GPIO pin 4
// Upload esp32_fan_controller.ino to your ESP32
// Update WiFi credentials and MQTT broker IP
```

## 📱 Mobile Usage

The web interface is fully responsive and works on mobile devices:
- Touch-friendly controls
- Optimized layout for small screens
- Swipe gestures supported
- Fast loading and smooth animations

## 🔒 Security Considerations

- **Network Security**: Use WPA2/WPA3 for WiFi networks
- **MQTT Security**: Configure authentication for production use
- **API Security**: Implement authentication for public deployments
- **Device Security**: Use secure firmware and regular updates

## 🐛 Troubleshooting

### Common Issues

**Backend not starting:**
```bash
# Check if port 5000 is available
sudo lsof -i :5000
# Kill any conflicting processes
sudo kill -9 <PID>
```

**MQTT connection failed:**
```bash
# Test MQTT broker
mosquitto_pub -h localhost -t test/topic -m "test"
mosquitto_sub -h localhost -t test/topic
```

**Frontend build errors:**
```bash
# Clear npm cache and reinstall
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

**Device not responding:**
- Check WiFi connection on ESP32
- Verify MQTT broker IP address
- Check device power supply
- Monitor serial output for errors

## 📚 API Documentation

### Device Control Commands
```json
{
  "action": "turn_on|turn_off|set_brightness|set_speed",
  "value": 0-100  // For brightness/speed control
}
```

### Device Status Response
```json
{
  "status": "on|off",
  "brightness": 0-100,  // For lights
  "speed": 0-5,         // For fans
  "device_type": "light|fan",
  "timestamp": 1234567890
}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **MQTT Protocol**: For reliable IoT communication
- **React**: For the modern frontend framework
- **Flask**: For the lightweight backend framework
- **Mosquitto**: For the MQTT broker implementation
- **ESP32/ESP8266**: For affordable IoT hardware platforms

## 📞 Support

For support and questions:
- Create an issue in the GitHub repository
- Check the troubleshooting section
- Review the API documentation

---

**Built with ❤️ for the IoT community**

