# GlassShop - Full Stack Web Application

## 🏗️ Project Overview

A modern full-stack web application built with Django REST Framework and React.js, featuring JWT authentication, PostgreSQL database, and deployed on AWS EC2.

### Technology Stack
- **Backend**: Django 5.0+, Django REST Framework
- **Frontend**: React 18+, Vite, Tailwind CSS
- **Database**: PostgreSQL 16+
- **Authentication**: JWT (JSON Web Tokens)
- **Deployment**: AWS EC2 (Ubuntu), Nginx, Gunicorn
- **Development**: Docker, Docker Compose

### Environments
- **Development**: Windows EC2 (local development)
- **Test**: test.glassshop.com (Ubuntu EC2)
- **Production**: glassshop.com (Ubuntu EC2)

## 📋 Project Status

Current Phase: **Phase 1 - Initial Setup**

For detailed progress tracking, see [PROGRESS.md](./docs/PROGRESS.md)

## 🚀 Quick Start

1. **Prerequisites**
   - Python 3.11+
   - Node.js 18+
   - PostgreSQL 16+
   - Git
   - Docker (optional but recommended)

2. **Clone Repository**
   ```bash
   git clone https://github.com/yourusername/glassshop.git
   cd glassshop
   ```

3. **Follow Setup Guide**
   - See [docs/SETUP_GUIDE.md](./docs/SETUP_GUIDE.md) for detailed instructions

## 📂 Project Structure

```
glassshop/
├── backend/           # Django REST API
├── frontend/          # React.js application
├── docs/              # Documentation
│   ├── SETUP_GUIDE.md
│   ├── PROGRESS.md
│   ├── REQUIREMENTS.md
│   └── phases/        # Detailed phase documentation
├── scripts/           # Utility scripts
└── docker/            # Docker configurations
```

## 📚 Documentation

- [Setup Guide](./docs/SETUP_GUIDE.md) - Step-by-step setup instructions
- [Requirements](./docs/REQUIREMENTS.md) - Complete technical requirements
- [Progress Tracking](./docs/PROGRESS.md) - Current development status
- [Architecture](./docs/ARCHITECTURE.md) - System design and architecture

## 🔐 Security

This project implements industry-standard security practices:
- JWT authentication with refresh tokens
- HTTPS everywhere
- CORS properly configured
- Input validation and sanitization
- SQL injection protection
- XSS prevention

## 👥 Contributing

See [CONTRIBUTING.md](./docs/CONTRIBUTING.md) for guidelines.

## 📄 License

[MIT License](LICENSE)

---

Last Updated: December 2024 