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

#### 2.4 Install PostgreSQL Client Tools
```bash
# Download from: https://www.postgresql.org/download/windows/
# We only need CLIENT TOOLS since we're using AWS RDS
# During installation, select ONLY:
# - Command Line Tools (psql, createdb, etc.)
# - pgAdmin 4 (database management tool)
# - Do NOT install PostgreSQL Server (we're using AWS RDS)

# Verify client tools installation:
psql --version
```

**Note**: Since we're using AWS RDS, we don't need to install the PostgreSQL server locally. We only need the client tools to connect to our RDS instances.

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

### Step 4: AWS RDS PostgreSQL Database Setup

#### 4.1 Create AWS RDS PostgreSQL Instances

**Prerequisites:**
- AWS Account with appropriate permissions
- AWS CLI installed (optional but recommended)

#### 4.2 Create Development Database (RDS Instance)

1. **Login to AWS Console** → Navigate to **RDS**

2. **Create Database**:
   - Click "Create database"
   - **Engine**: PostgreSQL
   - **Template**: Dev/Test (for development)
   - **Engine Version**: 16.x (latest stable)

3. **Settings**:
   - **DB Instance Identifier**: `glassshop-dev-db`
   - **Master Username**: `postgres`
   - **Master Password**: Choose a strong password (save it!)

4. **Instance Configuration**:
   - **DB Instance Class**: `db.t3.micro` (free tier eligible)
   - **Storage Type**: General Purpose (SSD)
   - **Allocated Storage**: 20 GB

5. **Connectivity**:
   - **Public Access**: Yes (for development)
   - **VPC Security Group**: Create new or use existing
   - **Database Port**: 5432

6. **Additional Configuration**:
   - **Initial Database Name**: `glassshop_dev`
   - **Backup Retention**: 7 days
   - **Monitoring**: Enable Enhanced Monitoring

#### 4.3 Create Live/Production Database (RDS Instance)

1. **Repeat the process** for production database:
   - **DB Instance Identifier**: `glassshop-live-db`
   - **Template**: Production
   - **Instance Class**: `db.t3.small` or higher
   - **Multi-AZ**: Yes (for high availability)
   - **Initial Database Name**: `glassshop_live`
   - **Public Access**: No (access via VPC only)

#### 4.4 Configure Security Groups

1. **Create Security Group** for database access:
   - **Name**: `glassshop-db-sg`
   - **Inbound Rules**:
     - Type: PostgreSQL
     - Port: 5432
     - Source: Your IP / VPC CIDR

#### 4.5 Connect and Setup Database Users

1. **Get RDS Endpoints** from AWS Console:
   - Development: `glassshop-dev-db.xxxxx.region.rds.amazonaws.com`
   - Live: `glassshop-live-db.xxxxx.region.rds.amazonaws.com`

2. **Connect using psql or pgAdmin**:
```bash
psql -h glassshop-dev-db.xxxxx.region.rds.amazonaws.com -U postgres -d glassshop_dev
```

3. **Create application users**:
```sql
-- Create application user for development
CREATE USER glassshop_dev_user WITH PASSWORD 'SecureDevPassword123!';
GRANT ALL PRIVILEGES ON DATABASE glassshop_dev TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO glassshop_dev_user;

-- Create application user for live
-- (Connect to live database)
CREATE USER glassshop_live_user WITH PASSWORD 'SecureLivePassword123!';
GRANT ALL PRIVILEGES ON DATABASE glassshop_live TO glassshop_live_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO glassshop_live_user;

-- Verify connection
\l
\du
```

#### 4.6 Test Connections

**Development Database Test**:
```bash
psql -h your-dev-endpoint -U glassshop_dev_user -d glassshop_dev
```

**Live Database Test**:
```bash
psql -h your-live-endpoint -U glassshop_live_user -d glassshop_live
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

# AWS RDS Development Database Configuration
DB_ENGINE=django.db.backends.postgresql
DB_NAME=glassshop_dev
DB_USER=glassshop_dev_user
DB_PASSWORD=SecureDevPassword123!
DB_HOST=glassshop-dev-db.xxxxx.region.rds.amazonaws.com
DB_PORT=5432

# AWS RDS Live Database Configuration
LIVE_DB_NAME=glassshop_live
LIVE_DB_USER=glassshop_live_user
LIVE_DB_PASSWORD=SecureLivePassword123!
LIVE_DB_HOST=glassshop-live-db.xxxxx.region.rds.amazonaws.com
LIVE_DB_PORT=5432

# AWS Configuration
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_DEFAULT_REGION=us-east-1
AWS_S3_REGION_NAME=us-east-1

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