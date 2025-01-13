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
{}
```

### Example Request with Name Filter

To filter devices by the name `Camera 1`:

```bash
GET http://localhost:4000/devices?name=Camera%201
```

### Expected Response

```json
{}
```

### Example Request with Brand Filter

To filter devices by the brand `Hikvision`:

```bash
GET http://localhost:4000/devices?brand=Hikvision
```

### Expected Response

```json
{}
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
    "status": 200,
    "message": "Users notified"
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
