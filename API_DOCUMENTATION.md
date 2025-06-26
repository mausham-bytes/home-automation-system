# API Documentation

## Base URL
```
http://localhost:5000/api
```

## Authentication
Currently, the API does not require authentication. For production use, implement proper authentication mechanisms.

## Content Type
All requests and responses use `application/json` content type.

## Error Handling
All endpoints return a consistent error format:
```json
{
  "success": false,
  "error": "Error message description"
}
```

## Device Management

### Get All Devices
**GET** `/devices`

Returns a list of all registered devices.

**Response:**
```json
{
  "success": true,
  "devices": [
    {
      "id": 1,
      "name": "Living Room Light",
      "device_type": "light",
      "room": "living_room",
      "status": "off",
      "brightness": 100,
      "speed": 0,
      "mqtt_topic": "home/living_room/living_room_light",
      "created_at": "2024-01-01T12:00:00",
      "updated_at": "2024-01-01T12:00:00"
    }
  ]
}
```

### Create Device
**POST** `/devices`

Creates a new device.

**Request Body:**
```json
{
  "name": "Living Room Light",
  "device_type": "light",
  "room": "living_room",
  "mqtt_topic": "home/living_room/living_room_light"
}
```

**Response:**
```json
{
  "success": true,
  "device": {
    "id": 1,
    "name": "Living Room Light",
    "device_type": "light",
    "room": "living_room",
    "status": "off",
    "brightness": 100,
    "speed": 0,
    "mqtt_topic": "home/living_room/living_room_light",
    "created_at": "2024-01-01T12:00:00",
    "updated_at": "2024-01-01T12:00:00"
  }
}
```

### Get Device
**GET** `/devices/{id}`

Returns details of a specific device.

**Response:**
```json
{
  "success": true,
  "device": {
    "id": 1,
    "name": "Living Room Light",
    "device_type": "light",
    "room": "living_room",
    "status": "off",
    "brightness": 100,
    "speed": 0,
    "mqtt_topic": "home/living_room/living_room_light",
    "created_at": "2024-01-01T12:00:00",
    "updated_at": "2024-01-01T12:00:00"
  }
}
```

### Update Device
**PUT** `/devices/{id}`

Updates an existing device.

**Request Body:**
```json
{
  "name": "Updated Light Name",
  "room": "bedroom",
  "brightness": 75
}
```

**Response:**
```json
{
  "success": true,
  "device": {
    "id": 1,
    "name": "Updated Light Name",
    "device_type": "light",
    "room": "bedroom",
    "status": "off",
    "brightness": 75,
    "speed": 0,
    "mqtt_topic": "home/living_room/living_room_light",
    "created_at": "2024-01-01T12:00:00",
    "updated_at": "2024-01-01T12:30:00"
  }
}
```

### Delete Device
**DELETE** `/devices/{id}`

Deletes a device.

**Response:**
```json
{
  "success": true,
  "message": "Device deleted successfully"
}
```

### Control Device
**POST** `/devices/{id}/control`

Sends a control command to a device via MQTT.

**Request Body:**
```json
{
  "action": "turn_on",
  "value": 80
}
```

**Available Actions:**
- `turn_on` - Turn device on
- `turn_off` - Turn device off
- `set_brightness` - Set brightness (lights only, value: 0-100)
- `set_speed` - Set speed (fans only, value: 0-5)

**Response:**
```json
{
  "success": true,
  "message": "Command turn_on sent to device Living Room Light",
  "device": {
    "id": 1,
    "name": "Living Room Light",
    "device_type": "light",
    "room": "living_room",
    "status": "on",
    "brightness": 80,
    "speed": 0,
    "mqtt_topic": "home/living_room/living_room_light",
    "created_at": "2024-01-01T12:00:00",
    "updated_at": "2024-01-01T12:45:00"
  }
}
```

## Schedule Management

### Get All Schedules
**GET** `/schedules`

Returns a list of all schedules.

**Response:**
```json
{
  "success": true,
  "schedules": [
    {
      "id": 1,
      "device_id": 1,
      "device_name": "Living Room Light",
      "name": "Morning Light",
      "action": "turn_on",
      "value": "80",
      "schedule_time": "07:00",
      "days": "1,2,3,4,5",
      "is_active": true,
      "created_at": "2024-01-01T12:00:00"
    }
  ]
}
```

### Create Schedule
**POST** `/schedules`

Creates a new schedule.

**Request Body:**
```json
{
  "device_id": 1,
  "name": "Morning Light",
  "action": "turn_on",
  "value": "80",
  "schedule_time": "07:00",
  "days": "1,2,3,4,5",
  "is_active": true
}
```

**Days Format:**
- 0 = Sunday
- 1 = Monday
- 2 = Tuesday
- 3 = Wednesday
- 4 = Thursday
- 5 = Friday
- 6 = Saturday

**Response:**
```json
{
  "success": true,
  "schedule": {
    "id": 1,
    "device_id": 1,
    "device_name": "Living Room Light",
    "name": "Morning Light",
    "action": "turn_on",
    "value": "80",
    "schedule_time": "07:00",
    "days": "1,2,3,4,5",
    "is_active": true,
    "created_at": "2024-01-01T12:00:00"
  }
}
```

### Delete Schedule
**DELETE** `/schedules/{id}`

Deletes a schedule.

**Response:**
```json
{
  "success": true,
  "message": "Schedule deleted successfully"
}
```

## MQTT Communication

### Command Topic Format
```
home/{room}/{device_name}/command
```

### Status Topic Format
```
home/{room}/{device_name}/status
```

### Command Message Format
```json
{
  "action": "turn_on",
  "value": 80,
  "timestamp": 1640995200
}
```

### Status Message Format
```json
{
  "status": "on",
  "brightness": 80,
  "speed": 0,
  "device_type": "light",
  "timestamp": 1640995200
}
```

## Error Codes

| HTTP Status | Description |
|-------------|-------------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request - Invalid input |
| 404 | Not Found - Resource doesn't exist |
| 500 | Internal Server Error |

## Rate Limiting

Currently, no rate limiting is implemented. For production use, consider implementing rate limiting to prevent abuse.

## Examples

### Using curl

**Create a device:**
```bash
curl -X POST http://localhost:5000/api/devices \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Bedroom Fan",
    "device_type": "fan",
    "room": "bedroom",
    "mqtt_topic": "home/bedroom/bedroom_fan"
  }'
```

**Control a device:**
```bash
curl -X POST http://localhost:5000/api/devices/1/control \
  -H "Content-Type: application/json" \
  -d '{
    "action": "set_speed",
    "value": 3
  }'
```

**Create a schedule:**
```bash
curl -X POST http://localhost:5000/api/schedules \
  -H "Content-Type: application/json" \
  -d '{
    "device_id": 1,
    "name": "Evening Fan",
    "action": "turn_on",
    "schedule_time": "18:00",
    "days": "1,2,3,4,5"
  }'
```

### Using JavaScript (Fetch API)

```javascript
// Create a device
const createDevice = async () => {
  const response = await fetch('http://localhost:5000/api/devices', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      name: 'Kitchen Light',
      device_type: 'light',
      room: 'kitchen',
      mqtt_topic: 'home/kitchen/kitchen_light'
    })
  });
  
  const data = await response.json();
  console.log(data);
};

// Control a device
const controlDevice = async (deviceId, action, value) => {
  const response = await fetch(`http://localhost:5000/api/devices/${deviceId}/control`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      action: action,
      value: value
    })
  });
  
  const data = await response.json();
  console.log(data);
};
```

## WebSocket Support

Currently, the API uses HTTP requests. For real-time updates, consider implementing WebSocket connections for live device status updates.

