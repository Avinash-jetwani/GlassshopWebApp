# Phase 1: Initial Setup - Detailed Guide

## 🎯 Phase Goal

Set up the complete development environment and project foundation on your Windows EC2 instance.

## 📋 Prerequisites Checklist

Before starting, confirm you have:
- [ ] Windows EC2 instance running
- [ ] Administrator access
- [ ] Stable internet connection
- [ ] At least 50GB free disk space
- [ ] Basic familiarity with command line

## 🚀 Step-by-Step Instructions

### Step 1: Initialize Git Repository

1. **Open PowerShell or Command Prompt as Administrator**

2. **Navigate to your project folder**:
```bash
cd C:\path\to\GlassshopDev
```

3. **Initialize Git**:
```bash
git init
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify configuration
git config --list
```

4. **Create initial commit**:
```bash
git add .
git commit -m "Initial commit: Project structure and documentation"
```

### Step 2: Install Development Tools

#### 2.1 Install Git for Windows
```bash
# Download from: https://git-scm.com/download/win
# During installation:
# - Choose "Git from the command line and also from 3rd-party software"
# - Choose "Use Visual Studio Code as Git's default editor" (if using VS Code)
# - Choose "Override the default branch name" and type "main"
```

#### 2.2 Install Python 3.11+
```bash
# Download from: https://www.python.org/downloads/
# IMPORTANT: Check "Add Python to PATH" during installation

# Verify installation:
python --version
pip --version
```

#### 2.3 Install Node.js LTS
```bash
# Download from: https://nodejs.org/
# Choose LTS version
# Install with default settings

# Verify installation:
node --version
npm --version
```

#### 2.4 Install PostgreSQL 16
```bash
# Download from: https://www.postgresql.org/download/windows/
# During installation:
# - Set password for postgres user (remember this!)
# - Default port: 5432
# - Default locale

# Verify by opening pgAdmin 4
```

### Step 3: Create GitHub Repository

1. **Create account on GitHub** (if you don't have one)

2. **Create new repository**:
   - Repository name: `glassshop`
   - Description: "Full-stack web application with Django and React"
   - Public or Private (your choice)
   - DON'T initialize with README

3. **Connect local repo to GitHub**:
```bash
git remote add origin https://github.com/YOUR_USERNAME/glassshop.git
git branch -M main
git push -u origin main
```

### Step 4: Database Setup

1. **Open pgAdmin 4**

2. **Connect to PostgreSQL server**:
   - Right-click "Servers" → Create → Server
   - Name: "Local PostgreSQL"
   - Connection tab:
     - Host: localhost
     - Port: 5432
     - Username: postgres
     - Password: (your password)

3. **Create databases using SQL**:
```sql
-- Create development database
CREATE DATABASE glassshop_dev;

-- Create live/production database
CREATE DATABASE glassshop_live;

-- Create application user
CREATE USER glassshop_user WITH PASSWORD 'SecurePassword123!';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE glassshop_dev TO glassshop_user;
GRANT ALL PRIVILEGES ON DATABASE glassshop_live TO glassshop_user;

-- Create super admin user
CREATE USER glassshop_admin WITH PASSWORD 'AdminPassword123!' SUPERUSER;

-- Verify databases
\l
```

### Step 5: Environment Variables Setup

1. **Create `.env` file in project root**:
```bash
# Create file
type nul > .env
```

2. **Add environment variables**:
```env
# Django Settings
SECRET_KEY=django-insecure-generate-a-new-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Database Configuration
DB_ENGINE=django.db.backends.postgresql
DB_NAME=glassshop_dev
DB_USER=glassshop_user
DB_PASSWORD=SecurePassword123!
DB_HOST=localhost
DB_PORT=5432

# Live Database
LIVE_DB_NAME=glassshop_live

# Redis Configuration (if using Redis)
REDIS_URL=redis://localhost:6379/0

# CORS Settings
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# JWT Settings
JWT_SECRET_KEY=generate-another-secret-key-for-jwt

# Frontend URL
FRONTEND_URL=http://localhost:3000

# Email Settings (for later)
EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend
```

### Step 6: VS Code Setup

1. **Install VS Code extensions**:
   - Python (ms-python.python)
   - Pylance (ms-python.vscode-pylance)
   - Django (batisteo.vscode-django)
   - ES7+ React snippets
   - Tailwind CSS IntelliSense
   - Prettier
   - GitLens
   - Docker (if using Docker)

2. **Configure VS Code settings**:
Create `.vscode/settings.json`:
```json
{
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.formatting.provider": "black",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  },
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true
  }
}
```

### Step 7: Verify Installation

Run this verification script:
```bash
# Create verify.py
python -c "
import sys
print(f'Python: {sys.version}')

try:
    import pip
    print(f'Pip: {pip.__version__}')
except:
    print('Pip: Not installed')

try:
    import psycopg2
    print('PostgreSQL driver: Available')
except:
    print('PostgreSQL driver: Not installed (install later)')
"

# Check Node/npm
node -e "console.log('Node:', process.version)"
npm -v

# Check Git
git --version

# Check PostgreSQL
psql --version 2>nul || echo "psql not in PATH (this is OK)"
```

### Step 8: Optional - Docker Setup

If you want to use Docker:

1. **Install Docker Desktop for Windows**:
   - Download from [docker.com](https://www.docker.com/products/docker-desktop/)
   - Requires WSL 2
   - Restart computer after installation

2. **Verify Docker**:
```bash
docker --version
docker-compose --version
docker run hello-world
```

## ✅ Phase 1 Completion Checklist

Before moving to Phase 2, ensure:

- [ ] Git repository initialized and connected to GitHub
- [ ] Python 3.11+ installed and working
- [ ] Node.js installed and working
- [ ] PostgreSQL installed with databases created
- [ ] VS Code installed with extensions
- [ ] Environment variables file created
- [ ] All tools verified and working

## 🚨 Common Issues & Solutions

### Issue: "python is not recognized"
**Solution**: Add Python to PATH:
1. Search "Environment Variables" in Windows
2. Edit PATH variable
3. Add Python installation directory

### Issue: PostgreSQL connection failed
**Solution**: 
1. Check if PostgreSQL service is running
2. Verify password is correct
3. Check Windows Firewall settings

### Issue: Git commands not working
**Solution**: 
1. Restart terminal after Git installation
2. Ensure Git is added to PATH

### Issue: npm command not found
**Solution**:
1. Reinstall Node.js
2. Restart terminal
3. Check PATH variable

## 📊 Time Estimate

- Total time: 2-4 hours
- Git setup: 30 minutes
- Tool installation: 1-2 hours
- Database setup: 30 minutes
- Configuration: 30 minutes

## 🎯 Next Steps

Once Phase 1 is complete:

1. Update progress in `docs/PROGRESS.md`
2. Commit all changes to Git
3. Push to GitHub
4. Proceed to [Phase 2: Backend Foundation](./phase2-backend.md)

---

**Need help?** Check the main [Setup Guide](../SETUP_GUIDE.md) or create an issue on GitHub.

Last Updated: December 2024 