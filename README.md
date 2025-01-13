# API Documentation


## 1. Route `/devices` - List User Devices

This route allows listing the devices of all users. You can use optional filters, such as `name`, `brand`, and `order_by`, to refine the search.

### Endpoint

```bash
GET /devices
```

### Query Parameters

- `name`: Filters devices by name (optional).
- `brand`: Filters devices by brand (optional).
- `order_by`: Orders the results by `name` or `brand` (optional).

### Example Request without Filters

```bash
GET http://localhost:4000/devices
```

### Expected Response

```json
{
    "users": [
        {
            "user": {
                "id": 1,
                "name": "João Silva",
                "email": "joao@example.com"
            },
            "device": {
                "id": 1,
                "name": "Camera 1",
                "brand": "Hikvision",
                "user_id": 1
            }
        },
        {
            "user": {
                "id": 2,
                "name": "Maria Oliveira",
                "email": "maria@example.com"
            },
            "device": {
                "id": 2,
                "name": "Camera 2",
                "brand": "Hikvision",
                "user_id": 2
            }
        }
    ]
}
```

### Example Request with Name Filter

To filter devices by the name `Camera 1`:

```bash
GET http://localhost:4000/devices?name=Camera%201
```

### Expected Response

```json
{
    "users": [
        {
            "user": {
                "id": 1,
                "name": "João Silva",
                "email": "joao@example.com"
            },
            "device": {
                "id": 1,
                "name": "Camera 1",
                "brand": "Hikvision",
                "user_id": 1
            }
        }
    ]
}
```

### Example Request with Brand Filter

To filter devices by the brand `Hikvision`:

```bash
GET http://localhost:4000/devices?brand=Hikvision
```

### Expected Response

```json
{
    "users": [
        {
            "user": {
                "id": 1,
                "name": "João Silva",
                "email": "joao@example.com"
            },
            "device": {
                "id": 1,
                "name": "Camera 1",
                "brand": "Hikvision",
                "user_id": 1
            }
        },
        {
            "user": {
                "id": 2,
                "name": "Maria Oliveira",
                "email": "maria@example.com"
            },
            "device": {
                "id": 2,
                "name": "Camera 2",
                "brand": "Hikvision",
                "user_id": 2
            }
        }
    ]
}
```

## 2. Route `/notify-users` - Notify Users with Hikvision Devices

This route simulates sending notifications to all users who have Hikvision devices.

### Endpoint

```bash
POST /notify-users
```

### Example Request

```bash
POST http://localhost:4000/notify-users
```

### Expected Response

Since the route simulates sending an email, the response will be a confirmation of the action. The format might be something like:

```json
{
    "status": "success",
    "message": "Emails successfully sent to users with Hikvision devices."
}
```

## 3. Error Examples

### Request with Invalid Filter

If an invalid filter is provided (e.g., a device brand that does not exist), the response might be an error like the following:

```json
{
    "status": "error",
    "message": "Invalid filter parameter 'brand'."
}
```
