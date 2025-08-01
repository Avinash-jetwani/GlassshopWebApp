# System Architecture

## 🏗️ Overview

GlassShop follows a modern microservices-inspired architecture with clear separation between frontend and backend, enabling independent scaling and development.

## 📐 Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        Users (Browsers)                      │
└─────────────────┬───────────────────────┬───────────────────┘
                  │ HTTPS                 │ HTTPS
                  ▼                       ▼
┌─────────────────────────┐    ┌─────────────────────────────┐
│   Production Domain     │    │      Test Domain            │
│   glassshop.com        │    │   test.glassshop.com        │
└─────────────┬───────────┘    └──────────┬──────────────────┘
              │                            │
              ▼                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    Cloudflare (CDN/DDoS Protection)         │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                    AWS EC2 Load Balancer                     │
└─────────────┬───────────────────────┬───────────────────────┘
              │                       │
              ▼                       ▼
┌──────────────────────┐    ┌────────────────────────────────┐
│   Production Server  │    │      Test Server               │
│   (Ubuntu EC2)       │    │      (Ubuntu EC2)              │
├──────────────────────┤    ├────────────────────────────────┤
│   Nginx (Port 80/443)│    │   Nginx (Port 80/443)          │
├──────────────────────┤    ├────────────────────────────────┤
│   React App (Static) │    │   React App (Static)           │
├──────────────────────┤    ├────────────────────────────────┤
│   Django API         │    │   Django API                   │
│   (Gunicorn :8000)   │    │   (Gunicorn :8000)             │
├──────────────────────┤    ├────────────────────────────────┤
│   Redis (Port 6379)  │    │   Redis (Port 6379)            │
└──────────┬───────────┘    └────────────┬─────────────────┘
           │                              │
           ▼                              ▼
┌──────────────────────┐    ┌────────────────────────────────┐
│  PostgreSQL Prod DB  │    │    PostgreSQL Test DB          │
│   (RDS/EC2)          │    │    (RDS/EC2)                   │
└──────────────────────┘    └────────────────────────────────┘
```

## 🔧 Component Details

### Frontend Architecture

#### Technology Stack
- **React 18**: UI library
- **Vite**: Build tool and dev server
- **React Router v6**: Client-side routing
- **Redux Toolkit**: State management
- **RTK Query**: Server state management & caching
- **Tailwind CSS**: Styling

#### Folder Structure
```
frontend/
├── src/
│   ├── components/        # Reusable UI components
│   │   ├── common/       # Button, Input, Modal, etc.
│   │   ├── layout/       # Header, Footer, Sidebar
│   │   └── features/     # Feature-specific components
│   ├── pages/            # Route components
│   ├── hooks/           # Custom React hooks
│   ├── utils/           # Helper functions
│   ├── store/           # Redux store
│   │   ├── index.ts     # Store configuration
│   │   └── slices/      # Redux slices & RTK Query APIs
│   └── styles/          # Global styles
```

### Backend Architecture

#### Technology Stack
- **Django 5.0**: Web framework
- **Django REST Framework**: API framework
- **PostgreSQL**: Primary database
- **Redis**: Caching & sessions
- **Celery**: Async task processing
- **Gunicorn**: WSGI server

#### Django Apps Structure
```
backend/
├── config/              # Project configuration
│   ├── settings/       # Environment-specific settings
│   │   ├── base.py
│   │   ├── development.py
│   │   ├── testing.py
│   │   └── production.py
│   └── urls.py
├── apps/
│   ├── authentication/ # JWT auth, user management
│   ├── users/         # User profiles, preferences
│   ├── core/          # Shared models, utilities
│   └── api/           # API versioning, throttling
```

## 🔐 Security Architecture

### Authentication Flow
```
1. User Login Request
   POST /api/v1/auth/login
   { "email": "user@example.com", "password": "password" }
   
2. Server Validates Credentials
   - Check user exists
   - Verify password hash
   - Check account status
   
3. Generate JWT Tokens
   - Access Token (15 minutes)
   - Refresh Token (7 days)
   
4. Return Tokens
   {
     "access": "eyJ0eXAiOiJKV1Q...",
     "refresh": "eyJ0eXAiOiJKV1Q...",
     "user": { "id": 1, "email": "..." }
   }
   
5. Client Storage
   - Access token: In-memory (React state)
   - Refresh token: httpOnly cookie
   
6. API Requests
   Authorization: Bearer <access_token>
   
7. Token Refresh
   POST /api/v1/auth/refresh
   Cookie: refresh_token=...
```

### Security Layers
1. **Network Security**
   - HTTPS everywhere
   - Cloudflare DDoS protection
   - AWS Security Groups

2. **Application Security**
   - JWT authentication
   - CORS configuration
   - Rate limiting
   - Input validation
   - SQL injection prevention

3. **Data Security**
   - Encrypted passwords (bcrypt)
   - Encrypted database connections
   - Secure environment variables

## 🚀 Deployment Architecture

### CI/CD Pipeline
```
1. Developer pushes to GitHub
2. GitHub Actions triggered
3. Run tests (pytest, jest)
4. Build Docker images
5. Push to registry
6. Deploy to test server
7. Run integration tests
8. Manual approval for production
9. Deploy to production
```

### Environment Configuration

#### Development
- Local machine
- SQLite/PostgreSQL
- Django Debug Toolbar
- Hot reloading

#### Testing
- test.glassshop.com
- Separate PostgreSQL database
- Full production stack
- Test data seeding

#### Production
- glassshop.com
- PostgreSQL RDS
- Redis ElastiCache
- S3 for media files
- CloudWatch monitoring

## 📊 Database Architecture

### Schema Design Principles
- Normalized to 3NF
- Soft deletes for audit trail
- UUID primary keys
- Timestamps on all tables

### Core Models
```python
# User Model (Extended Django User)
User
├── id (UUID)
├── email (unique)
├── username
├── first_name
├── last_name
├── is_active
├── is_staff
├── date_joined
└── last_login

# User Profile
UserProfile
├── id (UUID)
├── user (OneToOne)
├── avatar
├── phone
├── address
├── preferences (JSON)
└── metadata (JSON)

# Audit Log
AuditLog
├── id (UUID)
├── user
├── action
├── model_name
├── object_id
├── changes (JSON)
├── ip_address
└── created_at
```

## 🔄 API Architecture

### RESTful Design
```
/api/v1/
├── auth/
│   ├── login/
│   ├── logout/
│   ├── refresh/
│   └── register/
├── users/
│   ├── profile/
│   └── {id}/
└── docs/        # Swagger/OpenAPI
```

### API Standards
- JSON request/response
- Consistent error format
- Pagination for lists
- Filtering and sorting
- API versioning

### Response Format
```json
// Success Response
{
  "status": "success",
  "data": { ... },
  "meta": {
    "timestamp": "2024-01-01T00:00:00Z",
    "version": "1.0"
  }
}

// Error Response
{
  "status": "error",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": { ... }
  },
  "meta": { ... }
}
```

## 🎯 Performance Architecture

### Caching Strategy
1. **Redis Cache**
   - Session storage
   - API response caching
   - Rate limiting counters

2. **Frontend Cache**
   - React Query caching
   - Browser caching
   - Service Worker (PWA)

3. **CDN Cache**
   - Static assets
   - API responses (where applicable)

### Optimization Techniques
- Database query optimization
- Lazy loading for images
- Code splitting for JS bundles
- Compression (gzip/brotli)
- HTTP/2 multiplexing

## 📈 Scalability Considerations

### Horizontal Scaling
- Stateless application design
- Load balancer ready
- Shared session storage (Redis)
- Database read replicas

### Vertical Scaling
- Resource monitoring
- Auto-scaling policies
- Performance baselines

## 🔍 Monitoring Architecture

### Application Monitoring
- **Sentry**: Error tracking
- **New Relic**: Performance monitoring
- **Custom metrics**: Business KPIs

### Infrastructure Monitoring
- **CloudWatch**: AWS resources
- **Nginx logs**: Access patterns
- **Database monitoring**: Query performance

### Alerting
- Error rate thresholds
- Response time alerts
- Resource utilization alerts
- Business metric alerts

---

Last Updated: December 2024 