# Complete Setup Guide

This guide will walk you through setting up the GlassShop application from scratch.

## 📋 Prerequisites Check

Before starting, ensure you have:
- [ ] Windows EC2 instance (or local Windows machine)
- [ ] Administrator access
- [ ] Internet connection
- [ ] At least 50GB free disk space

---

## Phase 1: Initial Setup

### Step 1: Install Git

1. Download Git for Windows from [git-scm.com](https://git-scm.com/download/win)
2. Run the installer with default settings
3. Verify installation:
```bash
git --version
```

### Step 2: Initialize Git Repository

```bash
# Navigate to your project folder
cd /path/to/GlassshopDev

# Initialize git
git init

# Configure git (replace with your details)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Create .gitignore file
```

Create `.gitignore` file:
```
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
*.egg-info/
.pytest_cache/
.coverage
htmlcov/

# Django
*.log
*.pot
*.pyc
local_settings.py
db.sqlite3
media/
staticfiles/

# React / Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.npm
build/
dist/

# Environment variables
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Docker
*.pid
```

### Step 3: Create GitHub Repository

1. Go to [GitHub](https://github.com)
2. Create new repository named "glassshop"
3. Don't initialize with README (we already have one)
4. Follow GitHub's instructions to push existing repository:

```bash
git add .
git commit -m "Initial commit: Project structure and documentation"
git branch -M main
git remote add origin https://github.com/yourusername/glassshop.git
git push -u origin main
```

### Step 4: Install Python

1. Download Python 3.11+ from [python.org](https://www.python.org/downloads/)
2. During installation, CHECK "Add Python to PATH"
3. Verify installation:
```bash
python --version
pip --version
```

### Step 5: Install Node.js

1. Download Node.js LTS from [nodejs.org](https://nodejs.org/)
2. Run installer with default settings
3. Verify installation:
```bash
node --version
npm --version
```

### Step 6: Install PostgreSQL

1. Download PostgreSQL 16 from [postgresql.org](https://www.postgresql.org/download/windows/)
2. Run installer
   - Remember the password for postgres user
   - Default port: 5432
3. After installation, open pgAdmin 4
4. Create databases:

```sql
-- Connect to PostgreSQL as postgres user
-- Create development database
CREATE DATABASE glassshop_dev;

-- Create test database  
CREATE DATABASE glassshop_test;

-- Create user for the application
CREATE USER glassshop_user WITH PASSWORD 'your_secure_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE glassshop_dev TO glassshop_user;
GRANT ALL PRIVILEGES ON DATABASE glassshop_test TO glassshop_user;
```

### Step 7: Install Redis (Optional but Recommended)

Option A: Using Docker (Easier)
```bash
docker run --name redis -p 6379:6379 -d redis
```

Option B: Windows Native
1. Download Redis for Windows from [GitHub](https://github.com/microsoftarchive/redis/releases)
2. Extract and run redis-server.exe

### Step 8: Set Up VS Code (Recommended)

1. Download VS Code from [code.visualstudio.com](https://code.visualstudio.com/)
2. Install recommended extensions:
   - Python
   - Pylance
   - Django
   - ES7+ React/Redux/React-Native snippets
   - Tailwind CSS IntelliSense
   - Prettier
   - GitLens

### Step 9: Create Environment Variables

Create `.env` file in project root:
```bash
# Django settings
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Database
DATABASE_URL=postgresql://glassshop_user:your_secure_password@localhost:5432/glassshop_dev

# Redis (if installed)
REDIS_URL=redis://localhost:6379/0

# CORS
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# JWT
JWT_SECRET_KEY=your-jwt-secret-key
```

---

## Phase 2: Backend Setup

### Step 1: Create Python Virtual Environment

```bash
# Navigate to project root
cd /path/to/GlassshopDev

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate

# You should see (venv) in your terminal
```

### Step 2: Create Requirements Files

Create `backend/requirements/base.txt`:
```
django==5.0.1
djangorestframework==3.14.0
django-cors-headers==4.3.1
django-environ==0.11.2
djangorestframework-simplejwt==5.3.1
psycopg2-binary==2.9.9
redis==5.0.1
django-redis==5.4.0
pillow==10.2.0
```

Create `backend/requirements/development.txt`:
```
-r base.txt
django-debug-toolbar==4.2.0
ipython==8.19.0
```

Create `backend/requirements/production.txt`:
```
-r base.txt
gunicorn==21.2.0
whitenoise==6.6.0
sentry-sdk==1.40.0
boto3==1.34.25
django-storages==1.14.2
```

### Step 3: Install Backend Dependencies

```bash
# Make sure virtual environment is activated
cd backend
pip install -r requirements/development.txt
```

### Step 4: Create Django Project

```bash
# In backend directory
django-admin startproject config .

# Your structure should look like:
# backend/
#   ├── config/
#   │   ├── __init__.py
#   │   ├── settings.py
#   │   ├── urls.py
#   │   ├── asgi.py
#   │   └── wsgi.py
#   ├── manage.py
#   └── requirements/
```

### Step 5: Configure Django Settings

We'll create environment-specific settings in the next phase.

---

## Phase 3: Frontend Setup

### Step 1: Create React App with Vite

```bash
# From project root
cd frontend
npm create vite@latest . -- --template react

# Install dependencies
npm install
```

### Step 2: Install Additional Dependencies

```bash
# Essential packages
npm install axios react-router-dom zustand
npm install @tanstack/react-query
npm install react-hook-form zod
npm install date-fns

# Development dependencies
npm install -D tailwindcss postcss autoprefixer
npm install -D @types/react @types/react-dom
npm install -D eslint prettier
```

### Step 3: Configure Tailwind CSS

```bash
# Initialize Tailwind
npx tailwindcss init -p
```

Update `tailwind.config.js`:
```javascript
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

### Step 4: Update Frontend Structure

Your frontend should have this structure:
```
frontend/
├── src/
│   ├── components/
│   ├── pages/
│   ├── services/
│   ├── hooks/
│   ├── utils/
│   ├── styles/
│   ├── App.jsx
│   └── main.jsx
├── public/
├── index.html
├── package.json
└── vite.config.js
```

---

## Phase 4: Docker Setup (Optional but Recommended)

### Step 1: Install Docker Desktop

1. Download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop/)
2. Install and restart computer
3. Verify installation:
```bash
docker --version
docker-compose --version
```

### Step 2: Create Docker Configuration

We'll add Docker files in a later phase.

---

## 🎯 Next Steps

You've completed the initial setup! Now you can proceed to:

1. **Phase 2**: Backend Foundation - [Phase 2 Guide](./phases/phase2-backend.md)
2. Start developing your Django models and APIs
3. Build your React components

## 🚨 Troubleshooting

### Common Issues:

1. **Python not found**: Make sure Python is added to PATH
2. **PostgreSQL connection failed**: Check if PostgreSQL service is running
3. **npm command not found**: Reinstall Node.js and restart terminal
4. **Permission denied**: Run terminal as Administrator

### Getting Help:

1. Check error messages carefully
2. Search for specific error on Google/StackOverflow
3. Check project issues on GitHub
4. Ask in development community

---

## 📚 Additional Resources

- [Django Documentation](https://docs.djangoproject.com/)
- [React Documentation](https://react.dev/)
- [Vite Documentation](https://vitejs.dev/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

Last Updated: December 2024 