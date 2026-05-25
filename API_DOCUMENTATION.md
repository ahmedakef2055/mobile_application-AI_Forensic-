# 🛡️ AI Digital Forensics — API Documentation

> **Version:** 1.0.0  
> **Base URL:** `http://localhost:8000/api`  
> **Authentication:** Bearer Token (Laravel Sanctum)  
> **Interactive Docs (Swagger UI):** [`http://localhost:8000/docs/api`](http://localhost:8000/docs/api)

---

## Table of Contents

1. [Authentication](#1-authentication)
2. [Dashboard](#2-dashboard)
3. [Network Flows](#3-network-flows)
4. [Sessions](#4-sessions)
5. [Web Requests](#5-web-requests)
6. [Web Security Events](#6-web-security-events)
7. [Mobile Devices](#7-mobile-devices)
8. [Mobile Events](#8-mobile-events)
9. [Predictions](#9-predictions)
10. [Incidents](#10-incidents)
11. [Alerts](#11-alerts)
12. [AI Models (Admin)](#12-ai-models-admin)
13. [Block List (Admin)](#13-block-list-admin)
14. [Response Policies (Admin)](#14-response-policies-admin)
15. [Sensitivity Rules (Admin)](#15-sensitivity-rules-admin)
16. [AI Integration Endpoints](#16-ai-integration-endpoints)
17. [Error Handling](#17-error-handling)
18. [Rate Limiting](#18-rate-limiting)

---

## Authentication Overview

All requests (except `POST /auth/login` and `POST /auth/register`) require an `Authorization` header:

```
Authorization: Bearer {token}
```

### Role-Based Access Control (RBAC)

| Role      | Access Level                                                |
|-----------|-------------------------------------------------------------|
| `admin`   | Full CRUD on all resources                                  |
| `analyst` | Read-only access to admin resources + full operational access |
| `user`    | Access to standard operational resources only               |

---

## 1. Authentication

Public endpoints — no token required.

### `POST /auth/register`

Create a new user account.

**Request Body:**

| Field      | Type   | Rules                          |
|------------|--------|--------------------------------|
| `username` | string | required, max:255              |
| `email`    | string | required, email, unique:users  |
| `password` | string | required, min:8                |

**Response:** `201 Created`

```json
{
  "success": true,
  "message": "Registration successful",
  "data": {
    "user": { "user_id": 1, "username": "john", "email": "john@example.com" },
    "token": "1|abc123..."
  }
}
```

---

### `POST /auth/login`

Authenticate an existing user.

**Request Body:**

| Field      | Type   | Rules                |
|------------|--------|----------------------|
| `username` | string | required, max:50     |
| `password` | string | required, min:6      |

**Response:** `200 OK`

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": { "user_id": 1, "username": "john", "email": "john@example.com" },
    "token": "2|xyz789..."
  }
}
```

**Error:** `401 Unauthorized` — Invalid credentials.

---

### `GET /auth/user` 🔒

Get the currently authenticated user.

**Response:** `200 OK`

```json
{
  "success": true,
  "data": { "user_id": 1, "username": "john", "email": "john@example.com" }
}
```

---

### `POST /auth/logout` 🔒

Revoke the current access token.

**Response:** `200 OK`

```json
{ "success": true, "message": "Logout successful" }
```

---

## 2. Dashboard 🔒

Aggregated statistics and chart data for the monitoring dashboard. All authenticated users have access.

### `GET /dashboard/stats`

Returns total counts across all modules.

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "network": { "total_flows": 1500, "recent_flows_24h": 120 },
    "incidents": { "total": 45, "open": 12, "closed": 33, "critical": 3 },
    "predictions": { "total": 890, "recent_24h": 50 },
    "web": { "total_requests": 5200, "security_events": 18 },
    "mobile": { "total_events": 320 }
  }
}
```

---

### `GET /dashboard/recent-activity`

Returns the 10 most recent network flows, incidents, and predictions.

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "recent_flows": [ ... ],
    "recent_incidents": [ ... ],
    "recent_predictions": [ ... ]
  }
}
```

---

### `GET /dashboard/charts`

Returns aggregated chart data (last 7 days).

**Response fields:**
- `incidents_per_day` — Incidents grouped by date and severity
- `flows_per_day` — Network flows per day
- `predictions_by_source` — Predictions grouped by source type
- `top_protocols` — Top 10 network protocols

---

## 3. Network Flows 🔒

Full CRUD for network traffic data. Supports sub-tables: `fwd_packet`, `bwd_packet`, `flags`, `packet_stats`, `active_idle`.

### `GET /network-flows`

List network flows (paginated).

**Query Parameters:**

| Param      | Type    | Description               |
|------------|---------|---------------------------|
| `protocol` | string  | Filter by protocol name   |
| `src_ip`   | string  | Filter by source IP       |
| `dst_ip`   | string  | Filter by destination IP  |
| `dst_port` | integer | Filter by destination port|
| `per_page` | integer | Items per page (default: 15)|

**Response:** `200 OK` — Paginated list with `data` and `meta`.

---

### `POST /network-flows`

Store a new network flow with optional sub-metrics.

**Request Body:**

| Field           | Type    | Rules                  |
|-----------------|---------|------------------------|
| `src_ip`        | string  | nullable, max:45       |
| `dst_ip`        | string  | nullable, max:45       |
| `src_port`      | integer | nullable, min:0        |
| `dst_port`      | integer | nullable, min:0        |
| `protocol`      | string  | nullable, max:20       |
| `start_ts`      | date    | nullable               |
| `duration`      | numeric | nullable               |
| `bytes_total`   | integer | nullable               |
| `packets_total` | integer | nullable               |
| `fwd_packet`    | object  | nullable               |
| `bwd_packet`    | object  | nullable               |
| `flags`         | object  | nullable               |
| `packet_stats`  | object  | nullable               |
| `active_idle`   | object  | nullable               |

**Response:** `201 Created`

---

### `GET /network-flows/{id}`

Get details of a specific flow, including all sub-tables and linked AI predictions.

**Response:** `200 OK` / `404 Not Found`

---

### `PUT /network-flows/{id}`

Update a network flow.

**Response:** `200 OK` / `404 Not Found`

---

### `DELETE /network-flows/{id}`

Delete a network flow.

**Response:** `200 OK` / `404 Not Found`

---

### `GET /network-flows-stats`

Get network flow statistics: total count, 24h count, top protocols, and top destination ports.

**Response:** `200 OK`

```json
{
  "success": true,
  "data": {
    "total_flows": 1500,
    "recent_flows_24h": 120,
    "top_protocols": [{ "protocol": "TCP", "count": 800 }],
    "top_dst_ports": [{ "dst_port": 443, "count": 500 }]
  }
}
```

---

## 4. Sessions 🔒

Manage user sessions (web & mobile).

### `GET /sessions`

List sessions (paginated).

**Query Parameters:**

| Param     | Type    | Description               |
|-----------|---------|---------------------------|
| `channel` | string  | Filter: `web` or `mobile` |
| `user_id` | integer | Filter by user ID         |
| `per_page`| integer | Items per page (default: 15)|

---

### `POST /sessions`

Create a new user session.

**Request Body:**

| Field        | Type   | Rules                         |
|--------------|--------|-------------------------------|
| `user_id`    | integer| required, exists:users        |
| `channel`    | string | required, in:web,mobile       |
| `ip_address` | string | nullable, max:45              |
| `expires_at` | date   | nullable                      |

**Response:** `201 Created`

---

### `GET /sessions/{id}`

Get session details with associated user and web requests.

**Response:** `200 OK` / `404 Not Found`

---

## 5. Web Requests 🔒

Log and query HTTP requests made during web sessions.

### `GET /web-requests`

List web requests (paginated).

**Query Parameters:**

| Param        | Type    | Description               |
|--------------|---------|---------------------------|
| `session_id` | integer | Filter by session          |
| `method`     | string  | Filter by HTTP method      |
| `status_code`| integer | Filter by status code      |
| `per_page`   | integer | Items per page (default: 15)|

---

### `POST /web-requests`

Log a new HTTP request.

**Request Body:**

| Field             | Type    | Rules                          |
|-------------------|---------|--------------------------------|
| `session_id`      | integer | required, exists:user_sessions |
| `method`          | string  | required, max:10               |
| `endpoint`        | string  | required                       |
| `status_code`     | integer | nullable                       |
| `response_time_ms`| integer | nullable                       |
| `ip_address`      | string  | nullable, max:45               |

**Response:** `201 Created`

---

### `GET /web-requests/{id}`

Get details of a web request with session and linked security events.

**Response:** `200 OK` / `404 Not Found`

---

## 6. Web Security Events 🔒

Track security-related events detected during web requests.

### `GET /web-security-events`

List security events (paginated).

**Query Parameters:**

| Param        | Type   | Description                |
|--------------|--------|----------------------------|
| `request_id` | integer| Filter by web request      |
| `event_type` | string | Filter by event type       |
| `per_page`   | integer| Items per page (default: 15)|

---

### `POST /web-security-events`

Log a new security event.

**Request Body:**

| Field        | Type   | Rules                         |
|--------------|--------|-------------------------------|
| `request_id` | integer| required, exists:web_requests |
| `event_type` | string | required                      |
| `details`    | string | nullable                      |

**Response:** `201 Created`

---

### `GET /web-security-events/{id}`

Get security event details with the associated web request.

**Response:** `200 OK` / `404 Not Found`

---

## 7. Mobile Devices 🔒

Full CRUD for mobile device registration and management.

### `GET /mobile-devices`

List registered devices (paginated).

**Query Parameters:**

| Param      | Type   | Description                   |
|------------|--------|-------------------------------|
| `platform` | string | Filter: `Android` or `iOS`    |
| `per_page` | integer| Items per page (default: 15)  |

---

### `POST /mobile-devices`

Register a new mobile device.

**Request Body:**

| Field        | Type   | Rules                       |
|--------------|--------|-----------------------------|
| `user_id`    | integer| required, exists:users      |
| `platform`   | string | required, in:Android,iOS    |
| `push_token` | string | nullable                    |

**Response:** `201 Created`

---

### `GET /mobile-devices/{id}`

Get device details with user and mobile events.

**Response:** `200 OK` / `404 Not Found`

---

### `PUT /mobile-devices/{id}`

Update device info (push_token, last_seen).

**Request Body:**

| Field        | Type   | Rules    |
|--------------|--------|----------|
| `push_token` | string | nullable |
| `last_seen`  | date   | nullable |

**Response:** `200 OK` / `404 Not Found`

---

### `DELETE /mobile-devices/{id}`

Remove a mobile device.

**Response:** `200 OK` / `404 Not Found`

---

## 8. Mobile Events 🔒

Log and query events from mobile devices.

### `GET /mobile-events`

List mobile events (paginated).

**Query Parameters:**

| Param        | Type   | Description            |
|--------------|--------|------------------------|
| `device_id`  | integer| Filter by device       |
| `event_type` | string | Filter by event type   |
| `per_page`   | integer| Items per page (default: 15)|

---

### `POST /mobile-events`

Log a mobile event.

**Request Body:**

| Field        | Type   | Rules                            |
|--------------|--------|----------------------------------|
| `device_id`  | integer| required, exists:mobile_devices  |
| `event_type` | string | required                         |
| `meta_json`  | object | nullable                         |

**Response:** `201 Created`

---

### `GET /mobile-events/{id}`

Get mobile event details with device info.

**Response:** `200 OK` / `404 Not Found`

---

## 9. Predictions 🔒

Store and retrieve AI-generated predictions linked to network, web, or mobile sources.

### `GET /predictions`

List predictions (paginated).

**Query Parameters:**

| Param         | Type    | Description                        |
|---------------|---------|-------------------------------------|
| `source_type` | string  | Filter: `network`, `web`, `mobile` |
| `model_id`    | integer | Filter by AI model                 |
| `class`       | string  | Filter by prediction class         |
| `per_page`    | integer | Items per page (default: 15)       |

---

### `POST /predictions`

Store a new AI prediction.

**Request Body:**

| Field         | Type    | Rules                              |
|---------------|---------|-------------------------------------|
| `model_id`    | integer | required, exists:ai_models         |
| `source_type` | string  | required, in:network,web,mobile    |
| `source_id`   | integer | required                           |
| `class`       | string  | required (e.g., 'DDoS', 'Normal') |
| `confidence`  | float   | required, min:0, max:1             |
| `predicted_at`| date    | nullable (defaults to now)         |

**Response:** `201 Created`

---

### `GET /predictions/{id}`

Get prediction details with linked AI model.

**Response:** `200 OK` / `404 Not Found`

---

## 10. Incidents 🔒

Security incident lifecycle management with evidence and forensic reports.

### `GET /incidents`

List incidents (paginated).

**Query Parameters:**

| Param           | Type   | Description                           |
|-----------------|--------|---------------------------------------|
| `status`        | string | Filter: `open` or `closed`            |
| `severity_level`| string | Filter: `Low`, `Medium`, `High`, `Critical` |
| `per_page`      | integer| Items per page (default: 15)          |

---

### `POST /incidents`

Open a new security incident.

**Request Body:**

| Field            | Type    | Rules                                |
|------------------|---------|--------------------------------------|
| `type`           | string  | required                             |
| `severity_score` | integer | required, min:0, max:100             |
| `severity_level` | string  | required, in:Low,Medium,High,Critical|

**Response:** `201 Created` — Status is automatically set to `open`.

---

### `GET /incidents/{id}`

Get incident details with evidence, forensic reports, alerts, and block list entries.

**Response:** `200 OK` / `404 Not Found`

---

### `PUT /incidents/{id}`

Update incident fields.

**Request Body:**

| Field            | Type    | Rules                                  |
|------------------|---------|----------------------------------------|
| `type`           | string  | optional                               |
| `severity_score` | integer | optional, min:0, max:100               |
| `severity_level` | string  | optional, in:Low,Medium,High,Critical  |

**Response:** `200 OK` / `404 Not Found`

---

### `POST /incidents/{id}/close`

Close an open incident.

**Response:** `200 OK` / `404 Not Found` / `422` if already closed.

---

### `GET /incidents/{id}/evidence`

List all evidence linked to an incident.

**Response:** `200 OK`

---

### `POST /incidents/{id}/evidence`

Link a source record (network flow, web request, or mobile event) to an incident as evidence.

**Request Body:**

| Field              | Type    | Rules                            |
|--------------------|---------|----------------------------------|
| `source_type`      | string  | required                         |
| `flow_id`          | integer | nullable, exists:network_flows   |
| `request_id`       | integer | nullable, exists:web_requests    |
| `mobile_event_id`  | integer | nullable, exists:mobile_events   |

**Response:** `201 Created`

---

### `GET /incidents/{id}/reports`

List forensic reports for an incident.

**Response:** `200 OK`

---

### `POST /incidents/{id}/reports`

Create a forensic report for an incident.

**Request Body:**

| Field    | Type   | Rules              |
|----------|--------|--------------------|
| `format` | string | required, in:PDF,CSV|
| `path`   | string | required           |

**Response:** `201 Created`

---

## 11. Alerts 🔒

Send and track security alerts across notification channels.

### `GET /alerts`

List alerts (paginated).

**Query Parameters:**

| Param         | Type    | Description                |
|---------------|---------|----------------------------|
| `incident_id` | integer | Filter by incident         |
| `channel`     | string  | Filter: `web` or `mobile`  |
| `per_page`    | integer | Items per page (default: 15)|

---

### `POST /alerts`

Send a new alert.

**Request Body:**

| Field         | Type    | Rules                     |
|---------------|---------|---------------------------|
| `incident_id` | integer | required, exists:incidents|
| `channel`     | string  | required, in:web,mobile   |
| `message`     | string  | required                  |

**Response:** `201 Created`

---

### `GET /alerts/{id}`

Get alert details with linked incident.

**Response:** `200 OK` / `404 Not Found`

---

### `PATCH /alerts/{id}/delivered`

Mark an alert as delivered (sets `delivered_at` timestamp).

**Response:** `200 OK` / `404 Not Found`

---

## 12. AI Models (Admin) 🔐

Full CRUD for AI model management. **Admin only** for write operations. Analysts have read-only access.

### `GET /ai-models` 🔒

List all registered AI models with prediction counts.

**Response:** `200 OK`

---

### `POST /ai-models` 🔐

Register a new AI model. **Admin only.**

**Request Body:**

| Field         | Type   | Rules          |
|---------------|--------|----------------|
| `name`        | string | required       |
| `version`     | string | required       |
| `trained_at`  | date   | nullable       |
| `metrics_json`| object | nullable       |

**Response:** `201 Created`

---

### `GET /ai-models/{id}` 🔒

Get AI model details with prediction count.

**Response:** `200 OK` / `404 Not Found`

---

### `PUT /ai-models/{id}` 🔐

Update AI model. **Admin only.**

**Response:** `200 OK` / `404 Not Found`

---

### `DELETE /ai-models/{id}` 🔐

Delete an AI model. **Admin only.**

**Response:** `200 OK` / `404 Not Found`

---

## 13. Block List (Admin) 🔐

Manage banned IPs and accounts. Full CRUD for admins, read-only for analysts.

### `GET /block-list` 🔒

List block list entries (paginated).

**Query Parameters:**

| Param         | Type   | Description                    |
|---------------|--------|--------------------------------|
| `target_type` | string | Filter: `ip` or `account`      |
| `mode`        | string | Filter: `temp` or `permanent`  |
| `per_page`    | integer| Items per page (default: 15)   |

---

### `POST /block-list` 🔐

Add an entry to the block list. **Admin only.**

**Request Body:**

| Field          | Type   | Rules                         |
|----------------|--------|-------------------------------|
| `incident_id`  | integer| required, exists:incidents    |
| `target_type`  | string | required, in:ip,account       |
| `target_value` | string | required                      |
| `mode`         | string | required, in:temp,permanent   |
| `expires_at`   | date   | nullable, must be future date |

**Response:** `201 Created`

---

### `GET /block-list/{id}` 🔐

Get block list entry details with linked incident. **Admin only.**

---

### `PUT /block-list/{id}` 🔐

Update a block list entry. **Admin only.**

---

### `DELETE /block-list/{id}` 🔐

Remove a block list entry. **Admin only.**

---

## 14. Response Policies (Admin) 🔐

Automated response rules. Full CRUD for admins, read-only for analysts.

### `GET /response-policies` 🔒

List all response policies.

---

### `POST /response-policies` 🔐

Create a new response policy. **Admin only.**

**Request Body:**

| Field       | Type    | Rules                     |
|-------------|---------|---------------------------|
| `name`      | string  | required                  |
| `condition` | string  | required                  |
| `action`    | string  | required, in:block,notify |
| `enabled`   | boolean | optional (default: true)  |

**Response:** `201 Created`

---

### `GET /response-policies/{id}` 🔐

Get policy details. **Admin only.**

---

### `PUT /response-policies/{id}` 🔐

Update a policy. **Admin only.**

---

### `DELETE /response-policies/{id}` 🔐

Delete a policy. **Admin only.**

---

## 15. Sensitivity Rules (Admin) 🔐

Data sensitivity classification rules. Full CRUD for admins, read-only for analysts.

### `GET /sensitivity-rules` 🔒

List all sensitivity rules.

**Query Parameters:**

| Param         | Type   | Description                                       |
|---------------|--------|---------------------------------------------------|
| `scope`       | string | Filter: `endpoint`, `table`, `role`               |
| `sensitivity` | string | Filter: `Public`, `Internal`, `Confidential`, `HighlyConfidential` |

---

### `POST /sensitivity-rules` 🔐

Create a new sensitivity rule. **Admin only.**

**Request Body:**

| Field          | Type   | Rules                                                  |
|----------------|--------|--------------------------------------------------------|
| `scope`        | string | required, in:endpoint,table,role                       |
| `scope_value`  | string | required                                               |
| `sensitivity`  | string | required, in:Public,Internal,Confidential,HighlyConfidential |

**Response:** `201 Created`

---

### `GET /sensitivity-rules/{id}` 🔐

Get rule details. **Admin only.**

---

### `PUT /sensitivity-rules/{id}` 🔐

Update a rule. **Admin only.**

---

### `DELETE /sensitivity-rules/{id}` 🔐

Delete a rule. **Admin only.**

---

## 16. AI Integration Endpoints

Special endpoints for AI system integration with a dedicated rate limit (60 requests/minute).

### `POST /ai/predictions`

Store a prediction from an external AI model. Same body as `POST /predictions`.

### `POST /ai/network-flows`

Ingest network flow data from an AI pipeline. Same body as `POST /network-flows`.

---

## 17. Error Handling

The API returns consistent JSON error responses:

```json
{
  "success": false,
  "message": "Human-readable error description"
}
```

| Status Code | Meaning                                          |
|-------------|--------------------------------------------------|
| `200`       | OK — Request succeeded                           |
| `201`       | Created — Resource created successfully          |
| `400`       | Bad Request — Malformed request                  |
| `401`       | Unauthorized — Missing or invalid token          |
| `403`       | Forbidden — Insufficient role permissions        |
| `404`       | Not Found — Resource does not exist              |
| `422`       | Unprocessable Entity — Validation errors         |
| `429`       | Too Many Requests — Rate limit exceeded          |
| `500`       | Server Error — Internal server error             |

### Validation Error Example (`422`)

```json
{
  "message": "The given data was invalid.",
  "errors": {
    "email": ["The email field is required."],
    "password": ["The password must be at least 8 characters."]
  }
}
```

---

## 18. Rate Limiting

| Limiter     | Limit              | Applied To                     |
|-------------|--------------------|--------------------------------|
| `api`       | 60 requests/minute | All authenticated API routes   |
| `login`     | 5 requests/minute  | `POST /auth/login`             |
| `register`  | 3 requests/minute  | `POST /auth/register`          |
| AI endpoints| 60 requests/minute | `POST /ai/predictions`, `POST /ai/network-flows` |

When rate limited, the API returns `429 Too Many Requests` with `Retry-After` header.

---

## 📝 Legend

| Icon | Meaning                              |
|------|--------------------------------------|
| 🔒   | Requires authentication (any role)   |
| 🔐   | Requires admin role                  |

---

## 🚀 Quick Start

```bash
# 1. Register a new user
curl -X POST http://localhost:8000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"analyst1","email":"analyst@example.com","password":"securepass123"}'

# 2. Login to get a token
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"analyst1","password":"securepass123"}'

# 3. Use the token for authenticated requests
curl http://localhost:8000/api/dashboard/stats \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# 4. Browse Interactive Docs
# Open http://localhost:8000/docs/api in your browser
```
