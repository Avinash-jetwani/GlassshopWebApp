# Deferred Dependencies Documentation

This document tracks dependencies that were mentioned in requirements but deferred for later phases.

## 📦 Dependencies Deferred

### 1. Celery & Django-Celery-Beat
- **Package**: celery==5.3.4, django-celery-beat==2.5.0
- **Purpose**: Asynchronous task processing and scheduled jobs
- **Deferred Reason**: Not needed until we have background tasks (email sending, reports, etc.)
- **Install When**: Phase 5 or when implementing features requiring background processing

### 2. Django-Storages & Boto3
- **Package**: django-storages==1.14.2, boto3==1.34.25
- **Purpose**: AWS S3 integration for file storage
- **Deferred Reason**: Currently using local media storage, S3 needed for production
- **Install When**: Phase 7 (Deployment Preparation) or when implementing file uploads

### 3. Gunicorn
- **Package**: gunicorn==21.2.0
- **Purpose**: Production WSGI server
- **Deferred Reason**: Using Django development server, Gunicorn only needed for production
- **Install When**: Phase 7 (Deployment Preparation)
- **Note**: Already in production.txt

### 4. Whitenoise
- **Package**: whitenoise==6.6.0
- **Purpose**: Serve static files in production
- **Deferred Reason**: Development server handles static files, needed for production
- **Install When**: Phase 7 (Deployment Preparation)
- **Note**: Already in production.txt

### 5. Sentry-SDK
- **Package**: sentry-sdk==1.40.0
- **Purpose**: Error tracking and monitoring
- **Deferred Reason**: Not needed until production deployment
- **Install When**: Phase 7 (Deployment Preparation)
- **Note**: Already in production.txt

## 📝 Version Differences Noted

### psycopg2 vs psycopg2-binary
- **Used**: psycopg2==2.9.10
- **Documented**: psycopg2-binary==2.9.9
- **Reason**: psycopg2 (without -binary) is recommended for production, and Windows installation worked better
- **Action**: Update documentation to reflect psycopg2

### Pillow Version
- **Used**: pillow==10.4.0
- **Documented**: pillow==10.2.0
- **Reason**: Newer version resolved Windows installation issues
- **Action**: Update documentation to reflect 10.4.0

---

Last Updated: December 2024