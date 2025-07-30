# Quick Start Guide

## 🚀 For Experienced Developers

If you're already familiar with Django and React, here's the current project status and next steps:

**📊 Current Status: Phase 1 Complete ✅**
- Development environment setup complete
- AWS RDS databases configured
- Cursor IDE with Claude 3.5 Sonnet ready
- Ready to start Phase 2 (Django backend)

### 1. Clone and Setup
```bash
git clone https://github.com/Avinash-jetwani/GlassshopWebApp.git
cd GlassshopDev
```

**✅ STATUS**: Already completed - repository is set up and connected.

### 2. Backend Setup
```bash
cd backend
python -m venv venv
venv\Scripts\activate  # Windows
# or
source venv/bin/activate  # Linux/Mac

pip install -r requirements/development.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

### 3. Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

### 4. Database Setup
```sql
CREATE DATABASE glassshop_dev;
CREATE DATABASE glassshop_test;
CREATE USER glassshop_user WITH PASSWORD 'yourpassword';
GRANT ALL PRIVILEGES ON DATABASE glassshop_dev TO glassshop_user;
GRANT ALL PRIVILEGES ON DATABASE glassshop_test TO glassshop_user;
```

### 5. Environment Variables
Create `.env` in project root:
```env
SECRET_KEY=your-secret-key
DEBUG=True
DATABASE_URL=postgresql://glassshop_user:password@localhost:5432/glassshop_dev
REDIS_URL=redis://localhost:6379/0
CORS_ALLOWED_ORIGINS=http://localhost:3000
```

## 📝 Common Commands

### Django Commands
```bash
# Create new app
python manage.py startapp appname

# Make migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run tests
python manage.py test

# Collect static files
python manage.py collectstatic
```

### React/npm Commands
```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Run tests
npm test

# Format code
npm run format
```

### Git Commands
```bash
# Create feature branch
git checkout -b feature/feature-name

# Add and commit
git add .
git commit -m "feat: add new feature"

# Push to remote
git push origin feature/feature-name

# Merge to main
git checkout main
git merge feature/feature-name
```

## 🔗 Useful URLs

### Development
- Backend API: http://localhost:8000/api/v1/
- Frontend: http://localhost:3000
- Django Admin: http://localhost:8000/admin/
- API Documentation: http://localhost:8000/api/docs/

### Tools
- pgAdmin: http://localhost:5050 (if using Docker)
- Redis Commander: http://localhost:8081 (if using)

## 🛠️ VS Code Extensions

Essential extensions for this project:
```json
{
  "recommendations": [
    "ms-python.python",
    "ms-python.vscode-pylance",
    "batisteo.vscode-django",
    "dsznajder.es7-react-js-snippets",
    "bradlc.vscode-tailwindcss",
    "esbenp.prettier-vscode",
    "eamodio.gitlens",
    "ms-azuretools.vscode-docker"
  ]
}
```

## 🐛 Debug Configuration

### Django Debug (launch.json)
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Django",
      "type": "python",
      "request": "launch",
      "program": "${workspaceFolder}/backend/manage.py",
      "args": ["runserver"],
      "django": true
    }
  ]
}
```

### React Debug
```json
{
  "name": "React",
  "type": "chrome",
  "request": "launch",
  "url": "http://localhost:3000",
  "webRoot": "${workspaceFolder}/frontend/src"
}
```

## 📊 Project Structure Reference

```
glassshop/
├── backend/
│   ├── config/         # Django settings
│   ├── apps/           # Django apps
│   ├── requirements/   # Python dependencies
│   └── manage.py
├── frontend/
│   ├── src/           # React source
│   ├── public/        # Static assets
│   └── package.json
├── docs/              # Documentation
├── scripts/           # Utility scripts
└── docker/            # Docker configs
```

## 🚨 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| `ModuleNotFoundError` | Activate virtual environment |
| `npm ERR!` | Delete node_modules and reinstall |
| Database connection error | Check PostgreSQL is running |
| CORS error | Check CORS_ALLOWED_ORIGINS in .env |
| Port already in use | Change port or kill process |

## 📚 Key Documentation Links

- [Full Setup Guide](./SETUP_GUIDE.md)
- [Architecture Overview](./ARCHITECTURE.md)
- [API Documentation](./API.md)
- [Contributing Guidelines](./CONTRIBUTING.md)

---

Last Updated: December 2024 