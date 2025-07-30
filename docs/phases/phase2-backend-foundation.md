# Phase 2: Backend Foundation - Detailed Guide

## 🎯 Phase Goal

Set up the Django backend foundation infrastructure with proper configuration, database connection, basic API structure, and security settings. This phase focuses purely on infrastructure setup - NO business features or functionality will be implemented.

## 📋 Prerequisites Checklist

Before starting Phase 2, confirm Phase 1 is complete:
- [x] Python 3.11+ installed and working (3.13.5 verified)
- [x] Node.js installed and working (v22.17.1 verified)  
- [x] Git repository connected to GitHub
- [x] AWS RDS PostgreSQL databases created and tested
- [x] Cursor IDE configured with Claude 3.5 Sonnet
- [x] Environment variables file (.env) created with all credentials
- [x] All Phase 1 tools verified and working

## 🎯 Phase 2 Overview

**Duration**: 3-4 days  
**Focus**: Django backend infrastructure setup  
**No Features**: This phase is purely infrastructure - no business logic or features

### What We'll Build:
- Django project structure with proper configuration
- Database connection and basic models
- Django REST Framework setup
- JWT authentication infrastructure (no login/register features yet)
- CORS configuration  
- Basic API structure and endpoints
- Admin interface setup
- Security configurations
- Development/production settings separation

### What We WON'T Build:
- ❌ User registration/login features
- ❌ Password reset functionality  
- ❌ File upload features
- ❌ Business logic or models
- ❌ Frontend integration
- ❌ Any actual functionality

---

## 🚀 Step-by-Step Instructions

### Step 1: Create Django Project Structure

#### 1.1 Navigate to Backend Directory
```bash
cd /c/GlassshopDev
cd backend
```

#### 1.2 Create Python Virtual Environment
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment (Windows)
venv\Scripts\activate

# Verify activation - you should see (venv) in your prompt
```

#### 1.3 Create Requirements Files Structure
```bash
# Create requirements directory
mkdir requirements
```

Create `backend/requirements/base.txt`:
```txt
django==5.0.1
djangorestframework==3.14.0
django-cors-headers==4.3.1
django-environ==0.11.2
djangorestframework-simplejwt==5.3.1
psycopg2-binary==2.9.9
redis==5.0.1
django-redis==5.4.0
django-filter==23.5
drf-spectacular==0.27.1
pillow==10.2.0
```

Create `backend/requirements/development.txt`:
```txt
-r base.txt
django-debug-toolbar==4.2.0
ipython==8.19.0
django-extensions==3.2.3
```

Create `backend/requirements/production.txt`:
```txt
-r base.txt
gunicorn==21.2.0
whitenoise==6.6.0
sentry-sdk==1.40.0
```

#### 1.4 Install Django Dependencies
```bash
# Install development requirements
pip install -r requirements/development.txt

# Verify installation
pip list
```

### Step 2: Create Django Project

#### 2.1 Initialize Django Project
```bash
# Create Django project (we'll call the config folder 'config')
django-admin startproject config .

# Your backend structure should now look like:
# backend/
#   ├── config/
#   │   ├── __init__.py
#   │   ├── settings.py
#   │   ├── urls.py
#   │   ├── asgi.py
#   │   └── wsgi.py
#   ├── manage.py
#   ├── requirements/
#   └── venv/
```

#### 2.2 Create Apps Directory Structure
```bash
# Create apps directory
mkdir apps

# Create core app for shared utilities
python manage.py startapp core apps/core

# Create authentication app for JWT setup
python manage.py startapp authentication apps/authentication

# Create api app for API configuration
python manage.py startapp api apps/api

# Your apps structure should look like:
# backend/apps/
#   ├── core/
#   ├── authentication/  
#   └── api/
```

### Step 3: Configure Django Settings

#### 3.1 Create Settings Module Structure
```bash
# Create settings directory
mkdir config/settings

# Move current settings to base
mv config/settings.py config/settings/base.py
```

Create `config/settings/__init__.py`:
```python
# Empty file to make it a Python package
```

Create `config/settings/base.py` (modify the moved file):
```python
import os
import environ
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent.parent

# Environment variables
env = environ.Env(
    DEBUG=(bool, False)
)

# Take environment variables from .env file
environ.Env.read_env(BASE_DIR.parent / '.env')

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = env('SECRET_KEY')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = env('DEBUG')

ALLOWED_HOSTS = env.list('ALLOWED_HOSTS', default=[])

# Application definition
DJANGO_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]

THIRD_PARTY_APPS = [
    'rest_framework',
    'rest_framework_simplejwt',
    'corsheaders',
    'django_filters',
    'drf_spectacular',
]

LOCAL_APPS = [
    'apps.core',
    'apps.authentication',
    'apps.api',
]

INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'config.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'config.wsgi.application'

# Database
DATABASES = {
    'default': {
        'ENGINE': env('DB_ENGINE'),
        'NAME': env('DB_NAME'),
        'USER': env('DB_USER'),
        'PASSWORD': env('DB_PASSWORD'),
        'HOST': env('DB_HOST'),
        'PORT': env('DB_PORT'),
        'OPTIONS': {
            'sslmode': 'require',
        },
    }
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Static files (CSS, JavaScript, Images)
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

# Media files
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# Default primary key field type
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Django REST Framework
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
    'DEFAULT_RENDERER_CLASSES': [
        'rest_framework.renderers.JSONRenderer',
    ],
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 20,
    'DEFAULT_FILTER_BACKENDS': [
        'django_filters.rest_framework.DjangoFilterBackend',
        'rest_framework.filters.OrderingFilter',
        'rest_framework.filters.SearchFilter',
    ],
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

# JWT Settings
from datetime import timedelta

SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(minutes=60),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=7),
    'ROTATE_REFRESH_TOKENS': True,
    'BLACKLIST_AFTER_ROTATION': True,
    'UPDATE_LAST_LOGIN': False,
    
    'ALGORITHM': 'HS256',
    'SIGNING_KEY': env('JWT_SECRET_KEY', default=SECRET_KEY),
    'VERIFYING_KEY': None,
    'AUDIENCE': None,
    'ISSUER': None,
    'JWK_URL': None,
    'LEEWAY': 0,
    
    'AUTH_HEADER_TYPES': ('Bearer',),
    'AUTH_HEADER_NAME': 'HTTP_AUTHORIZATION',
    'USER_ID_FIELD': 'id',
    'USER_ID_CLAIM': 'user_id',
    'USER_AUTHENTICATION_RULE': 'rest_framework_simplejwt.authentication.default_user_authentication_rule',
    
    'AUTH_TOKEN_CLASSES': ('rest_framework_simplejwt.tokens.AccessToken',),
    'TOKEN_TYPE_CLAIM': 'token_type',
    'TOKEN_USER_CLASS': 'rest_framework_simplejwt.models.TokenUser',
    
    'JTI_CLAIM': 'jti',
    
    'SLIDING_TOKEN_REFRESH_EXP_CLAIM': 'refresh_exp',
    'SLIDING_TOKEN_LIFETIME': timedelta(minutes=5),
    'SLIDING_TOKEN_REFRESH_LIFETIME': timedelta(days=1),
}

# CORS Settings
CORS_ALLOWED_ORIGINS = env.list('CORS_ALLOWED_ORIGINS', default=[])
CORS_ALLOW_CREDENTIALS = True

# Cache (Redis)
CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': env('REDIS_URL', default='redis://127.0.0.1:6379/1'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    }
}

# Session configuration
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
SESSION_CACHE_ALIAS = 'default'

# Spectacular settings (API documentation)
SPECTACULAR_SETTINGS = {
    'TITLE': 'GlassShop API',
    'DESCRIPTION': 'API documentation for GlassShop application',
    'VERSION': '1.0.0',
    'SERVE_INCLUDE_SCHEMA': False,
}

# Security Settings
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
X_FRAME_OPTIONS = 'DENY'
```

Create `config/settings/development.py`:
```python
from .base import *

# Development specific settings
DEBUG = True

# Add debug toolbar for development
INSTALLED_APPS += [
    'debug_toolbar',
    'django_extensions',
]

MIDDLEWARE += [
    'debug_toolbar.middleware.DebugToolbarMiddleware',
]

# Internal IPs for debug toolbar
INTERNAL_IPS = [
    '127.0.0.1',
    'localhost',
]

# Debug toolbar configuration
DEBUG_TOOLBAR_CONFIG = {
    'SHOW_TOOLBAR_CALLBACK': lambda request: DEBUG,
}

# Allow all hosts in development
ALLOWED_HOSTS = ['*']

# Email backend for development (console)
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
```

Create `config/settings/production.py`:
```python
from .base import *

# Production specific settings
DEBUG = False

# Security settings for production
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_HSTS_SECONDS = 31536000
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# Static files handling
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
MIDDLEWARE.insert(1, 'whitenoise.middleware.WhiteNoiseMiddleware')

# Logging
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': BASE_DIR / 'logs' / 'django.log',
        },
    },
    'root': {
        'handlers': ['file'],
    },
}
```

#### 3.2 Update manage.py for Environment-specific Settings
Edit `manage.py`:
```python
#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys


def main():
    """Run administrative tasks."""
    # Default to development settings
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.development')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
```

### Step 4: Update Environment Variables

Update your `.env` file in the project root with all the required variables:
```env
# Django Settings
SECRET_KEY=django-insecure-your-new-secret-key-here-change-this
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# AWS RDS Development Database Configuration
DB_ENGINE=django.db.backends.postgresql
DB_NAME=glassshop_dev
DB_USER=glassshop_dev_user
DB_PASSWORD=SecureDevPassword123!
DB_HOST=glassshop-dev-db.xxxxx.eu-west-2.rds.amazonaws.com
DB_PORT=5432

# AWS RDS Live Database Configuration (for later use)
LIVE_DB_NAME=glassshop_live
LIVE_DB_USER=glassshop_live_user
LIVE_DB_PASSWORD=SecureLivePassword123!
LIVE_DB_HOST=glassshop-live-db.xxxxx.eu-west-2.rds.amazonaws.com
LIVE_DB_PORT=5432

# Redis Configuration
REDIS_URL=redis://127.0.0.1:6379/1

# CORS Settings
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# JWT Settings
JWT_SECRET_KEY=your-jwt-secret-key-different-from-django-secret

# Frontend URL
FRONTEND_URL=http://localhost:3000

# AWS Configuration (for later use)
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_DEFAULT_REGION=eu-west-2
AWS_S3_REGION_NAME=eu-west-2

# Email Settings (development)
EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend
```

### Step 5: Configure URL Structure

#### 5.1 Update Main URLs
Edit `config/urls.py`:
```python
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('apps.api.urls')),
    
    # API Documentation
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    
    # Add debug toolbar URLs in development
    if 'debug_toolbar' in settings.INSTALLED_APPS:
        import debug_toolbar
        urlpatterns = [
            path('__debug__/', include(debug_toolbar.urls)),
        ] + urlpatterns
```

#### 5.2 Create API URLs
Create `apps/api/urls.py`:
```python
from django.urls import path, include

app_name = 'api'

urlpatterns = [
    # Health check endpoint
    path('health/', include('apps.core.urls')),
    
    # Authentication endpoints (basic structure only)
    path('auth/', include('apps.authentication.urls')),
]
```

#### 5.3 Create Core URLs
Create `apps/core/urls.py`:
```python
from django.urls import path
from . import views

app_name = 'core'

urlpatterns = [
    path('', views.HealthCheckView.as_view(), name='health-check'),
]
```

#### 5.4 Create Authentication URLs (basic structure)
Create `apps/authentication/urls.py`:
```python
from django.urls import path
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

app_name = 'authentication'

urlpatterns = [
    # JWT token endpoints (infrastructure only)
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]
```

### Step 6: Create Basic Models and Views

#### 6.1 Create Core Models
Edit `apps/core/models.py`:
```python
from django.db import models
import uuid

class BaseModel(models.Model):
    """
    Base model with common fields for all models
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)
    
    class Meta:
        abstract = True
        ordering = ['-created_at']
```

#### 6.2 Create Core Views
Edit `apps/core/views.py`:
```python
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import AllowAny
from django.db import connection

class HealthCheckView(APIView):
    """
    Health check endpoint for monitoring
    """
    permission_classes = [AllowAny]
    
    def get(self, request):
        try:
            # Test database connection
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                db_status = "healthy"
        except Exception as e:
            db_status = f"unhealthy: {str(e)}"
        
        return Response({
            "status": "ok",
            "message": "GlassShop API is running",
            "database": db_status,
            "version": "1.0.0"
        }, status=status.HTTP_200_OK)
```

#### 6.3 Create Core Apps Configuration
Edit `apps/core/apps.py`:
```python
from django.apps import AppConfig

class CoreConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.core'
    label = 'core'
```

Edit `apps/authentication/apps.py`:
```python
from django.apps import AppConfig

class AuthenticationConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.authentication'
    label = 'authentication'
```

Edit `apps/api/apps.py`:
```python
from django.apps import AppConfig

class ApiConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.api'
    label = 'api'
```

### Step 7: Database Setup and Migration

#### 7.1 Test Database Connection
```bash
# Test the database connection
python manage.py dbshell

# You should connect to your AWS RDS PostgreSQL database
# Type \q to exit
```

#### 7.2 Create and Run Migrations
```bash
# Create initial migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser for admin access
python manage.py createsuperuser
```

### Step 8: Test the Setup

#### 8.1 Run Development Server
```bash
# Start the Django development server
python manage.py runserver

# Server should start at http://127.0.0.1:8000/
```

#### 8.2 Test Endpoints
Open your browser or use curl to test:

```bash
# Health check endpoint
curl http://127.0.0.1:8000/api/v1/health/

# Admin interface
# http://127.0.0.1:8000/admin/

# API documentation
# http://127.0.0.1:8000/api/docs/

# API schema
# http://127.0.0.1:8000/api/schema/
```

### Step 9: Create Basic Admin Configuration

#### 9.1 Configure Core Admin
Edit `apps/core/admin.py`:
```python
from django.contrib import admin

class BaseModelAdmin(admin.ModelAdmin):
    """
    Base admin configuration for models extending BaseModel
    """
    readonly_fields = ('id', 'created_at', 'updated_at')
    list_display = ('id', 'created_at', 'updated_at', 'is_active')
    list_filter = ('is_active', 'created_at', 'updated_at')
    search_fields = ('id',)
    ordering = ('-created_at',)
```

---

## ✅ Phase 2 Completion Checklist

**Batch 1: Environment Setup**
- [ ] Virtual environment created and activated
- [ ] Django dependencies installed from requirements files
- [ ] Environment variables updated with all required settings

**Batch 2: Django Project Structure**
- [ ] Django project created with proper config structure
- [ ] Apps directory created with core, authentication, and api apps
- [ ] Settings split into base, development, and production modules

**Batch 3: Database Configuration**
- [ ] Database settings configured for AWS RDS PostgreSQL
- [ ] Database connection tested successfully
- [ ] Initial migrations created and applied

**Batch 4: API Infrastructure**
- [ ] Django REST Framework configured
- [ ] JWT authentication infrastructure set up
- [ ] CORS configured for frontend communication
- [ ] URL structure created for API endpoints

**Batch 5: Basic Models and Views**
- [ ] BaseModel created with common fields
- [ ] Health check endpoint implemented and working
- [ ] Admin interface configured and accessible

**Batch 6: Testing and Verification**
- [ ] Development server runs without errors
- [ ] Health check endpoint returns proper response
- [ ] Admin interface accessible with superuser
- [ ] API documentation accessible at /api/docs/

---

## 🎯 Expected Outcomes

After completing Phase 2, you should have:

1. **Working Django Backend**: Development server running on port 8000
2. **Database Connection**: Successfully connected to AWS RDS PostgreSQL
3. **API Infrastructure**: Basic REST API structure with documentation
4. **Security Setup**: JWT authentication infrastructure (no features yet)
5. **Admin Interface**: Django admin accessible for backend management
6. **Development Tools**: Debug toolbar and proper development configuration

## 🚨 Common Issues & Solutions

### Issue: Virtual environment not activating
**Solution**: 
```bash
# Windows Command Prompt
venv\Scripts\activate.bat

# Windows PowerShell
venv\Scripts\Activate.ps1

# Git Bash
source venv/Scripts/activate
```

### Issue: Database connection failed
**Solution**: 
1. Check .env file has correct AWS RDS credentials
2. Verify AWS RDS security group allows your IP
3. Test connection with psql command line

### Issue: Import errors for apps
**Solution**: 
1. Ensure all `__init__.py` files exist in app directories
2. Check apps.py configuration matches settings INSTALLED_APPS
3. Restart development server after creating new apps

### Issue: Migration errors
**Solution**: 
```bash
# Reset migrations if needed
python manage.py migrate --fake-initial
python manage.py makemigrations
python manage.py migrate
```

## 📊 Time Estimate

- **Batch 1** (Environment Setup): 30 minutes
- **Batch 2** (Project Structure): 1 hour  
- **Batch 3** (Database Setup): 30 minutes
- **Batch 4** (API Infrastructure): 1.5 hours
- **Batch 5** (Models and Views): 1 hour
- **Batch 6** (Testing): 30 minutes

**Total Estimated Time**: 4.5 hours

## 🎯 Next Steps

Once Phase 2 is complete:

1. Update progress in `docs/PROGRESS.md`
2. Commit all changes to Git with descriptive messages
3. Push to GitHub repository
4. Proceed to **Phase 3: Frontend Foundation**
5. Test integration between backend and frontend

## 📚 Important Notes

- This phase contains NO business features - only infrastructure
- All authentication is set up but no user registration/login features
- Database models are basic - no business logic implemented  
- CORS is configured for frontend communication
- All security settings are development-friendly but production-ready structure

---

**Phase 2 Status**: Ready to Begin  
**Prerequisites**: Phase 1 Complete ✅  
**Next Phase**: Phase 3 - Frontend Foundation

Last Updated: December 2024