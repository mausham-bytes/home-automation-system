# Project Structure

This document outlines the organization and structure of the Home Automation System project.

## Root Directory Structure

```
home-automation-system/
├── home_automation_backend/     # Flask backend server
├── home_automation_frontend/    # React frontend application
├── iot_devices/                 # IoT device code and simulator
├── README.md                    # Main project documentation
├── SETUP.md                     # Setup instructions
├── API_DOCUMENTATION.md         # API reference
├── system_architecture.md       # System architecture document
├── system_architecture.pdf     # Architecture document (PDF)
├── system_architecture_diagram.png  # Architecture diagram
├── testing_results.md           # Testing and validation results
├── setup_mqtt.sh               # MQTT broker setup script
└── todo.md                     # Project progress tracker
```

## Backend Structure (`home_automation_backend/`)

```
home_automation_backend/
├── venv/                       # Python virtual environment
├── src/                        # Source code
│   ├── models/                 # Database models
│   │   ├── user.py            # User model (template)
│   │   └── device.py          # Device and Schedule models
│   ├── routes/                 # API route handlers
│   │   ├── user.py            # User routes (template)
│   │   └── device.py          # Device and schedule routes
│   ├── services/               # Business logic services
│   │   └── mqtt_service.py    # MQTT communication service
│   ├── static/                 # Static files (for frontend serving)
│   ├── database/               # Database files
│   │   └── app.db             # SQLite database
│   └── main.py                # Main Flask application
├── requirements.txt            # Python dependencies
└── README.md                  # Backend-specific documentation
```

### Key Backend Files

- **`src/main.py`**: Main Flask application entry point
- **`src/models/device.py`**: Database models for devices and schedules
- **`src/routes/device.py`**: API endpoints for device management
- **`src/services/mqtt_service.py`**: MQTT communication handler
- **`requirements.txt`**: Python package dependencies

## Frontend Structure (`home_automation_frontend/`)

```
home_automation_frontend/
├── public/                     # Public assets
├── src/                        # Source code
│   ├── components/             # React components
│   │   ├── ui/                # UI components (shadcn/ui)
│   │   ├── DeviceCard.jsx     # Device control card component
│   │   ├── DeviceForm.jsx     # Device creation/editing form
│   │   └── ScheduleForm.jsx   # Schedule creation form
│   ├── services/               # API services
│   │   └── api.js             # Backend API communication
│   ├── assets/                 # Static assets
│   ├── App.jsx                 # Main application component
│   ├── App.css                 # Application styles
│   ├── index.css               # Global styles
│   └── main.jsx                # Application entry point
├── index.html                  # HTML template
├── package.json                # Node.js dependencies and scripts
├── vite.config.js             # Vite build configuration
├── tailwind.config.js         # Tailwind CSS configuration
├── components.json            # shadcn/ui configuration
└── README.md                  # Frontend-specific documentation
```

### Key Frontend Files

- **`src/App.jsx`**: Main React application component
- **`src/components/DeviceCard.jsx`**: Individual device control interface
- **`src/components/DeviceForm.jsx`**: Device creation and editing form
- **`src/components/ScheduleForm.jsx`**: Schedule creation form
- **`src/services/api.js`**: API communication service
- **`package.json`**: Node.js dependencies and build scripts

## IoT Devices Structure (`iot_devices/`)

```
iot_devices/
├── esp32_light_controller.ino  # Arduino code for ESP32 light control
├── esp32_fan_controller.ino    # Arduino code for ESP32 fan control
├── device_simulator.py         # Python device simulator for testing
└── README.md                   # IoT device documentation
```

### Key IoT Files

- **`esp32_light_controller.ino`**: ESP32 Arduino code for controlling lights
- **`esp32_fan_controller.ino`**: ESP32 Arduino code for controlling fans
- **`device_simulator.py`**: Python script to simulate IoT devices for testing

## Configuration Files

### Backend Configuration
- **`requirements.txt`**: Python package dependencies
- **`src/main.py`**: Flask app configuration and CORS settings

### Frontend Configuration
- **`package.json`**: Node.js dependencies and build scripts
- **`vite.config.js`**: Vite bundler configuration
- **`tailwind.config.js`**: Tailwind CSS styling configuration
- **`components.json`**: shadcn/ui component library configuration

### MQTT Configuration
- **`setup_mqtt.sh`**: Automated MQTT broker installation script
- **`src/services/mqtt_service.py`**: MQTT client configuration

## Database Schema

### Device Table
```sql
CREATE TABLE device (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    device_type VARCHAR(50) NOT NULL,
    room VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'off',
    brightness INTEGER DEFAULT 100,
    speed INTEGER DEFAULT 0,
    mqtt_topic VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Schedule Table
```sql
CREATE TABLE schedule (
    id INTEGER PRIMARY KEY,
    device_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    action VARCHAR(50) NOT NULL,
    value VARCHAR(50),
    schedule_time VARCHAR(20) NOT NULL,
    days VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (device_id) REFERENCES device (id)
);
```

## API Endpoints Structure

### Device Management
- `GET /api/devices` - List all devices
- `POST /api/devices` - Create new device
- `GET /api/devices/{id}` - Get specific device
- `PUT /api/devices/{id}` - Update device
- `DELETE /api/devices/{id}` - Delete device
- `POST /api/devices/{id}/control` - Control device

### Schedule Management
- `GET /api/schedules` - List all schedules
- `POST /api/schedules` - Create new schedule
- `DELETE /api/schedules/{id}` - Delete schedule

## MQTT Topic Structure

### Command Topics
```
home/{room}/{device_name}/command
```

### Status Topics
```
home/{room}/{device_name}/status
```

### Example Topics
- `home/living_room/main_light/command`
- `home/living_room/main_light/status`
- `home/bedroom/ceiling_fan/command`
- `home/bedroom/ceiling_fan/status`

## Development Workflow

### 1. Backend Development
```bash
cd home_automation_backend
source venv/bin/activate
python src/main.py
```

### 2. Frontend Development
```bash
cd home_automation_frontend
npm run dev
```

### 3. Testing with Simulator
```bash
cd iot_devices
python device_simulator.py
```

## Build and Deployment

### Backend Production Build
```bash
cd home_automation_backend
pip freeze > requirements.txt
# Deploy using Gunicorn or similar WSGI server
```

### Frontend Production Build
```bash
cd home_automation_frontend
npm run build
# Serve dist/ folder with nginx or similar
```

## Dependencies

### Backend Dependencies
- Flask: Web framework
- Flask-CORS: Cross-origin resource sharing
- Flask-SQLAlchemy: Database ORM
- paho-mqtt: MQTT client library

### Frontend Dependencies
- React: UI framework
- Vite: Build tool
- Tailwind CSS: Styling framework
- shadcn/ui: UI component library
- Lucide React: Icon library

### Development Tools
- ESLint: JavaScript linting
- Prettier: Code formatting
- Git: Version control

## Security Considerations

### File Permissions
- Ensure proper file permissions for production deployment
- Protect sensitive configuration files
- Use environment variables for secrets

### Network Security
- Configure firewall rules for MQTT broker
- Use HTTPS in production
- Implement proper authentication

This structure provides a clear separation of concerns and makes the project easy to understand, maintain, and extend.

