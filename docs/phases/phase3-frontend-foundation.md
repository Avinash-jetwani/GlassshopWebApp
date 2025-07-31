# Phase 3: Frontend Foundation

## 📋 Overview

**Phase 3** focuses on setting up a robust React frontend infrastructure using modern tools and best practices. This phase establishes the foundation for all future frontend development without implementing any business features.

**Duration**: 3-4 days  
**Complexity**: Medium  
**Dependencies**: Phase 1 & 2 (Backend Foundation) must be completed

---

## 🎯 Objectives

### Primary Goals:
1. **React Application Setup**: Initialize React 18+ with Vite build tool
2. **Styling Framework**: Configure Tailwind CSS for responsive design
3. **Routing Infrastructure**: Set up React Router for navigation
4. **API Integration**: Configure Axios for backend communication
5. **State Management**: Set up Zustand for application state
6. **Development Tools**: Configure TypeScript, ESLint, Prettier
7. **Project Structure**: Create organized folder architecture
8. **Error Handling**: Implement error boundaries and loading states

### Success Criteria:
- ✅ React development server running on `http://localhost:3000`
- ✅ Tailwind CSS working with responsive design
- ✅ API calls successfully connecting to Django backend
- ✅ Routing system functional
- ✅ State management operational
- ✅ TypeScript compilation working
- ✅ Code quality tools (ESLint/Prettier) active
- ✅ Error boundaries catching and displaying errors
- ✅ Loading states implemented for async operations

---

## ✅ **What's INCLUDED (Infrastructure Only):**
- React 18+ application with Vite build tool
- Tailwind CSS styling framework with responsive design
- React Router DOM for client-side routing
- Axios HTTP client for API communication
- Zustand for lightweight state management
- TanStack React Query for server state management
- React Hook Form + Zod for form handling and validation
- TypeScript for type safety
- ESLint + Prettier for code quality
- Error boundaries for error handling
- Loading states and UI feedback
- Environment variables configuration
- Base layout components structure
- Folder organization and architecture
- Development and build configurations

## ❌ **What's EXCLUDED (No Features Yet):**
- Authentication pages (login/register/profile)
- Business-specific components
- User dashboard or admin interfaces
- Data visualization components
- File upload functionality
- Real-time features (WebSocket integration)
- Payment processing components
- User management interfaces
- Business logic implementation
- Database-connected components
- Protected routes implementation
- User role-based content

---

## 📦 Technology Stack

### **Core Frontend Technologies:**
- **React**: 18.2.0+ (Component library)
- **Vite**: 5.0.11+ (Build tool and dev server)
- **TypeScript**: 5.3.3+ (Type safety)
- **Tailwind CSS**: 3.4.0+ (Utility-first CSS framework)

### **Navigation & Routing:**
- **React Router DOM**: 6.21.1+ (Client-side routing)

### **HTTP & State Management:**
- **Axios**: 1.6.5+ (HTTP client)
- **Zustand**: 4.4.7+ (Application state management)
- **TanStack React Query**: 5.17.9+ (Server state management)

### **Forms & Validation:**
- **React Hook Form**: 7.48.2+ (Form handling)
- **Zod**: 3.22.4+ (Schema validation)

### **Development Tools:**
- **ESLint**: 8.56.0+ (Code linting)
- **Prettier**: 3.2.2+ (Code formatting)
- **TypeScript ESLint**: 6.18.1+ (TypeScript linting)

### **Utilities:**
- **date-fns**: 3.2.0+ (Date utilities)

---

## 🗂️ Frontend Project Structure

### **Target Directory Structure:**
```
frontend/
├── public/                     # Static assets
│   ├── favicon.ico
│   └── vite.svg
├── src/                        # Source code
│   ├── components/             # Reusable UI components
│   │   ├── ui/                 # Base UI components (Button, Input, etc.)
│   │   ├── layout/             # Layout components (Header, Footer, Sidebar)
│   │   └── common/             # Common components (Loading, ErrorBoundary)
│   ├── pages/                  # Page components
│   │   ├── Home.tsx
│   │   ├── About.tsx
│   │   └── NotFound.tsx
│   ├── services/               # API service functions
│   │   ├── api.ts              # Axios configuration
│   │   ├── auth.ts             # Authentication services (infrastructure)
│   │   └── endpoints.ts        # API endpoint constants
│   ├── hooks/                  # Custom React hooks
│   │   ├── useApi.ts           # API interaction hooks
│   │   └── useLocalStorage.ts  # Local storage hook
│   ├── store/                  # State management
│   │   ├── index.ts            # Store configuration
│   │   └── slices/             # State slices
│   ├── utils/                  # Utility functions
│   │   ├── constants.ts        # Application constants
│   │   ├── helpers.ts          # Helper functions
│   │   └── types.ts            # TypeScript type definitions
│   ├── styles/                 # Global styles
│   │   ├── globals.css         # Global CSS with Tailwind
│   │   └── components.css      # Component-specific styles
│   ├── App.tsx                 # Main App component
│   ├── main.tsx                # Application entry point
│   └── vite-env.d.ts           # Vite type definitions
├── index.html                  # HTML template
├── package.json                # Node.js dependencies
├── tsconfig.json               # TypeScript configuration
├── tsconfig.node.json          # TypeScript configuration for Node.js
├── vite.config.ts              # Vite configuration
├── tailwind.config.js          # Tailwind CSS configuration
├── postcss.config.js           # PostCSS configuration
├── .eslintrc.cjs               # ESLint configuration
├── .prettierrc                 # Prettier configuration
├── .gitignore                  # Git ignore patterns
└── .env                        # Environment variables
```

---

## 🔧 Environment Variables

### **Frontend Environment Variables (.env):**
```bash
# API Configuration
VITE_API_URL=http://127.0.0.1:8000/api/v1
VITE_API_TIMEOUT=10000

# Application Configuration
VITE_APP_NAME=GlassShop
VITE_APP_VERSION=1.0.0
VITE_APP_ENVIRONMENT=development

# Development Configuration
VITE_DEBUG=true
VITE_LOG_LEVEL=debug

# Future Configuration (placeholders)
VITE_SENTRY_DSN=
VITE_GOOGLE_ANALYTICS_ID=
```

---

## 📋 Detailed Implementation Steps

### **Step 1: Initialize React Application with Vite**
**Batch 1: Project Initialization**

#### **1.1 Create Vite React Project**
```bash
# Navigate to frontend directory
cd frontend

# Create Vite React project with TypeScript
npm create vite@latest . -- --template react-ts

# Install initial dependencies
npm install
```

#### **1.2 Clean Up Initial Files**
- Remove default Vite assets and styles
- Clean up `App.tsx` to basic structure
- Update `index.html` title and meta tags
- Remove unnecessary CSS files

#### **1.3 Test Initial Setup**
```bash
# Start development server
npm run dev

# Verify server runs on http://localhost:3000
# Confirm hot reload functionality
```

**Expected Output**: Clean React app running on localhost:3000 with Vite dev server

---

### **Step 2: Install and Configure Dependencies**
**Batch 2: Dependencies Setup**

#### **2.1 Install Core Dependencies**
```bash
# HTTP client and routing
npm install axios@^1.6.5 react-router-dom@^6.21.1

# State management
npm install zustand@^4.4.7 @tanstack/react-query@^5.17.9

# Forms and validation
npm install react-hook-form@^7.48.2 zod@^3.22.4

# Utilities
npm install date-fns@^3.2.0
```

#### **2.2 Install Development Dependencies**
```bash
# Styling
npm install -D tailwindcss@^3.4.0 postcss@^8.4.33 autoprefixer@^10.4.16

# Code quality
npm install -D eslint@^8.56.0 prettier@^3.2.2
npm install -D @typescript-eslint/eslint-plugin@^6.18.1
npm install -D @typescript-eslint/parser@^6.18.1
```

#### **2.3 Verify Dependencies**
- Check `package.json` for correct versions
- Ensure no dependency conflicts
- Test `npm run dev` still works

**Expected Output**: All dependencies installed without conflicts

---

### **Step 3: Configure Tailwind CSS**
**Batch 3: Styling Framework**

#### **3.1 Initialize Tailwind CSS**
```bash
# Initialize Tailwind configuration
npx tailwindcss init -p
```

#### **3.2 Configure Tailwind**
**Update `tailwind.config.js`:**
```javascript
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
        }
      }
    },
  },
  plugins: [],
}
```

#### **3.3 Setup Global Styles**
**Create `src/styles/globals.css`:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  html {
    @apply scroll-smooth;
  }
  body {
    @apply bg-gray-50 text-gray-900;
  }
}

@layer components {
  .btn {
    @apply px-4 py-2 rounded-lg font-medium transition-colors;
  }
  .btn-primary {
    @apply bg-primary-600 text-white hover:bg-primary-700;
  }
}
```

#### **3.4 Import Styles**
- Import `globals.css` in `main.tsx`
- Remove default CSS files
- Test Tailwind classes work

**Expected Output**: Tailwind CSS working with custom classes

---

### **Step 4: Configure Development Tools**
**Batch 4: Code Quality Setup**

#### **4.1 Configure ESLint**
**Create `.eslintrc.cjs`:**
```javascript
module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    'prettier'
  ],
  ignorePatterns: ['dist', '.eslintrc.cjs'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module'
  },
  plugins: ['@typescript-eslint'],
  rules: {
    'no-console': 'warn',
    '@typescript-eslint/no-unused-vars': 'error'
  }
}
```

#### **4.2 Configure Prettier**
**Create `.prettierrc`:**
```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
```

#### **4.3 Add NPM Scripts**
**Update `package.json` scripts:**
```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "lint:fix": "eslint . --ext ts,tsx --fix",
    "format": "prettier --write src/**/*.{ts,tsx,css,md}"
  }
}
```

**Expected Output**: Linting and formatting tools working

---

### **Step 5: Setup Project Structure and Base Components**
**Batch 5: Architecture Setup**

#### **5.1 Create Folder Structure**
```bash
# Create directory structure
mkdir -p src/{components/{ui,layout,common},pages,services,hooks,store/slices,utils,styles}
```

#### **5.2 Create Base Components**

**`src/components/layout/Layout.tsx`:**
```typescript
import React from 'react';

interface LayoutProps {
  children: React.ReactNode;
}

export const Layout: React.FC<LayoutProps> = ({ children }) => {
  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="h-16 flex items-center justify-between">
            <h1 className="text-xl font-semibold text-gray-900">
              GlassShop
            </h1>
          </div>
        </div>
      </header>
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {children}
      </main>
    </div>
  );
};
```

**`src/components/common/LoadingSpinner.tsx`:**
```typescript
import React from 'react';

interface LoadingSpinnerProps {
  size?: 'sm' | 'md' | 'lg';
  className?: string;
}

export const LoadingSpinner: React.FC<LoadingSpinnerProps> = ({ 
  size = 'md', 
  className = '' 
}) => {
  const sizeClasses = {
    sm: 'w-4 h-4',
    md: 'w-8 h-8',
    lg: 'w-12 h-12'
  };

  return (
    <div className={`animate-spin rounded-full border-2 border-gray-300 border-t-primary-600 ${sizeClasses[size]} ${className}`} />
  );
};
```

**`src/components/common/ErrorBoundary.tsx`:**
```typescript
import React, { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="min-h-screen flex items-center justify-center bg-gray-50">
          <div className="text-center">
            <h1 className="text-2xl font-bold text-gray-900 mb-4">
              Oops! Something went wrong
            </h1>
            <p className="text-gray-600 mb-4">
              We're sorry for the inconvenience. Please try refreshing the page.
            </p>
            <button
              onClick={() => window.location.reload()}
              className="btn btn-primary"
            >
              Refresh Page
            </button>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}
```

#### **5.3 Create Basic Pages**

**`src/pages/Home.tsx`:**
```typescript
import React from 'react';

export const HomePage: React.FC = () => {
  return (
    <div className="text-center">
      <h1 className="text-4xl font-bold text-gray-900 mb-4">
        Welcome to GlassShop
      </h1>
      <p className="text-lg text-gray-600 mb-8">
        Your modern web application is ready!
      </p>
      <div className="bg-white rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold mb-4">System Status</h2>
        <p className="text-green-600">✅ Frontend: Ready</p>
        <p className="text-green-600">✅ Backend: Connected</p>
        <p className="text-green-600">✅ Database: Connected</p>
      </div>
    </div>
  );
};
```

**`src/pages/NotFound.tsx`:**
```typescript
import React from 'react';
import { Link } from 'react-router-dom';

export const NotFoundPage: React.FC = () => {
  return (
    <div className="text-center">
      <h1 className="text-6xl font-bold text-gray-900 mb-4">404</h1>
      <h2 className="text-2xl font-semibold text-gray-700 mb-4">
        Page Not Found
      </h2>
      <p className="text-gray-600 mb-8">
        The page you're looking for doesn't exist.
      </p>
      <Link
        to="/"
        className="btn btn-primary"
      >
        Go Home
      </Link>
    </div>
  );
};
```

**Expected Output**: Organized project structure with base components

---

### **Step 6: Configure Routing**
**Batch 6: Navigation Setup**

#### **6.1 Setup React Router**

**`src/App.tsx`:**
```typescript
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ErrorBoundary } from './components/common/ErrorBoundary';
import { Layout } from './components/layout/Layout';
import { HomePage } from './pages/Home';
import { NotFoundPage } from './pages/NotFound';
import './styles/globals.css';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5, // 5 minutes
      cacheTime: 1000 * 60 * 30, // 30 minutes
    },
  },
});

function App() {
  return (
    <ErrorBoundary>
      <QueryClientProvider client={queryClient}>
        <Router>
          <Layout>
            <Routes>
              <Route path="/" element={<HomePage />} />
              <Route path="*" element={<NotFoundPage />} />
            </Routes>
          </Layout>
        </Router>
      </QueryClientProvider>
    </ErrorBoundary>
  );
}

export default App;
```

#### **6.2 Test Routing**
- Test home page loads
- Test 404 page for invalid routes
- Verify browser navigation works

**Expected Output**: Working client-side routing

---

### **Step 7: Configure API Integration**
**Batch 7: Backend Communication**

#### **7.1 Setup Environment Variables**

**Create `.env`:**
```bash
VITE_API_URL=http://127.0.0.1:8000/api/v1
VITE_API_TIMEOUT=10000
VITE_APP_NAME=GlassShop
VITE_APP_VERSION=1.0.0
VITE_APP_ENVIRONMENT=development
VITE_DEBUG=true
VITE_LOG_LEVEL=debug
```

#### **7.2 Configure Axios**

**`src/services/api.ts`:**
```typescript
import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000/api/v1';
const API_TIMEOUT = parseInt(import.meta.env.VITE_API_TIMEOUT || '10000');

export const api = axios.create({
  baseURL: API_URL,
  timeout: API_TIMEOUT,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor
api.interceptors.request.use(
  (config) => {
    // Add auth token when available
    const token = localStorage.getItem('access_token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor
api.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    // Handle common errors
    if (error.response?.status === 401) {
      // Handle unauthorized
      localStorage.removeItem('access_token');
    }
    return Promise.reject(error);
  }
);

export default api;
```

**`src/services/endpoints.ts`:**
```typescript
export const API_ENDPOINTS = {
  // Health check
  HEALTH: '/health/',
  
  // Authentication (infrastructure only)
  AUTH: {
    TOKEN: '/auth/token/',
    REFRESH: '/auth/token/refresh/',
    VERIFY: '/auth/token/verify/',
  },
} as const;
```

#### **7.3 Create API Hooks**

**`src/hooks/useApi.ts`:**
```typescript
import { useState, useEffect } from 'react';
import { api } from '../services/api';
import { AxiosError } from 'axios';

interface ApiState<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
}

export function useApi<T>(url: string, immediate = true) {
  const [state, setState] = useState<ApiState<T>>({
    data: null,
    loading: false,
    error: null,
  });

  const execute = async () => {
    setState(prev => ({ ...prev, loading: true, error: null }));
    
    try {
      const response = await api.get<T>(url);
      setState({
        data: response.data,
        loading: false,
        error: null,
      });
      return response.data;
    } catch (error) {
      const errorMessage = error instanceof AxiosError 
        ? error.response?.data?.message || error.message
        : 'An unknown error occurred';
      
      setState({
        data: null,
        loading: false,
        error: errorMessage,
      });
      throw error;
    }
  };

  useEffect(() => {
    if (immediate) {
      execute();
    }
  }, [url, immediate]);

  return { ...state, execute };
}
```

#### **7.4 Test API Connection**

**Update `src/pages/Home.tsx` to include API test:**
```typescript
import React from 'react';
import { useApi } from '../hooks/useApi';
import { LoadingSpinner } from '../components/common/LoadingSpinner';
import { API_ENDPOINTS } from '../services/endpoints';

interface HealthResponse {
  status: string;
  message: string;
  database: string;
  version: string;
}

export const HomePage: React.FC = () => {
  const { data: health, loading, error } = useApi<HealthResponse>(
    API_ENDPOINTS.HEALTH
  );

  return (
    <div className="text-center">
      <h1 className="text-4xl font-bold text-gray-900 mb-4">
        Welcome to GlassShop
      </h1>
      <p className="text-lg text-gray-600 mb-8">
        Your modern web application is ready!
      </p>
      
      <div className="bg-white rounded-lg shadow p-6">
        <h2 className="text-xl font-semibold mb-4">System Status</h2>
        
        {loading && (
          <div className="flex justify-center mb-4">
            <LoadingSpinner />
          </div>
        )}
        
        {error && (
          <p className="text-red-600 mb-4">❌ Backend: {error}</p>
        )}
        
        {health && (
          <>
            <p className="text-green-600">✅ Frontend: Ready</p>
            <p className="text-green-600">
              ✅ Backend: {health.message} (v{health.version})
            </p>
            <p className="text-green-600">
              ✅ Database: {health.database}
            </p>
          </>
        )}
      </div>
    </div>
  );
};
```

**Expected Output**: Frontend successfully communicating with Django backend

---

### **Step 8: Setup State Management**
**Batch 8: Application State**

#### **8.1 Configure Zustand Store**

**`src/store/index.ts`:**
```typescript
import { create } from 'zustand';
import { devtools } from 'zustand/middleware';

interface AppState {
  // Global app state
  isLoading: boolean;
  error: string | null;
  
  // UI state
  sidebarOpen: boolean;
  theme: 'light' | 'dark';
  
  // Actions
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  toggleSidebar: () => void;
  setTheme: (theme: 'light' | 'dark') => void;
  clearError: () => void;
}

export const useAppStore = create<AppState>()(
  devtools(
    (set) => ({
      // Initial state
      isLoading: false,
      error: null,
      sidebarOpen: false,
      theme: 'light',
      
      // Actions
      setLoading: (loading) => set({ isLoading: loading }),
      setError: (error) => set({ error }),
      toggleSidebar: () => set((state) => ({ sidebarOpen: !state.sidebarOpen })),
      setTheme: (theme) => set({ theme }),
      clearError: () => set({ error: null }),
    }),
    {
      name: 'app-store',
    }
  )
);
```

#### **8.2 Create Utility Types**

**`src/utils/types.ts`:**
```typescript
// Common types
export interface ApiResponse<T> {
  data: T;
  message?: string;
  status: string;
}

export interface PaginatedResponse<T> {
  results: T[];
  count: number;
  next: string | null;
  previous: string | null;
}

// Error types
export interface ApiError {
  message: string;
  code?: string;
  details?: Record<string, any>;
}

// Common UI types
export interface SelectOption {
  value: string | number;
  label: string;
}
```

#### **8.3 Create Constants**

**`src/utils/constants.ts`:**
```typescript
export const APP_CONFIG = {
  NAME: import.meta.env.VITE_APP_NAME || 'GlassShop',
  VERSION: import.meta.env.VITE_APP_VERSION || '1.0.0',
  ENVIRONMENT: import.meta.env.VITE_APP_ENVIRONMENT || 'development',
  API_URL: import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000/api/v1',
} as const;

export const HTTP_STATUS = {
  OK: 200,
  CREATED: 201,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  INTERNAL_SERVER_ERROR: 500,
} as const;

export const LOCAL_STORAGE_KEYS = {
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token',
  USER_PREFERENCES: 'user_preferences',
} as const;
```

**Expected Output**: Functional state management system

---

### **Step 9: Final Configuration and Testing**
**Batch 9: Integration Testing**

#### **9.1 Update Vite Configuration**

**`vite.config.ts`:**
```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
    open: true,
    cors: true,
  },
  preview: {
    port: 3000,
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
  },
});
```

#### **9.2 Update TypeScript Configuration**

**`tsconfig.json`:**
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

#### **9.3 Comprehensive Testing**

**Create test script `test_frontend.js`:**
```javascript
const axios = require('axios');

const BASE_URL = 'http://localhost:3000';

async function testFrontend() {
  console.log('🧪 Testing Frontend Application...\n');
  
  try {
    // Test home page
    console.log('1. Testing home page...');
    const homeResponse = await axios.get(BASE_URL);
    console.log('✅ Home page loads successfully');
    
    // Test 404 page
    console.log('2. Testing 404 page...');
    try {
      await axios.get(`${BASE_URL}/nonexistent-page`);
    } catch (error) {
      if (error.response?.status === 404) {
        console.log('✅ 404 handling works correctly');
      }
    }
    
    console.log('\n🎉 All frontend tests passed!');
    
  } catch (error) {
    console.error('❌ Frontend test failed:', error.message);
  }
}

testFrontend();
```

#### **9.4 Final Verification Checklist**

**Manual Testing:**
- [ ] Development server starts without errors
- [ ] Home page loads and displays system status
- [ ] API call to backend health endpoint works
- [ ] 404 page displays for invalid routes
- [ ] Tailwind CSS styles are applied
- [ ] Hot reload works during development
- [ ] TypeScript compilation passes
- [ ] ESLint shows no errors
- [ ] Build process completes successfully

**Technical Verification:**
- [ ] All dependencies are correctly installed
- [ ] Environment variables are loaded
- [ ] Axios interceptors are working
- [ ] Zustand store is functional
- [ ] Error boundary catches errors
- [ ] Loading states display correctly

**Expected Output**: Fully functional React frontend infrastructure

---

## 🎯 Batch Implementation Plan

### **Batch 1: Project Initialization (Day 1)**
- Initialize Vite React project
- Clean up default files
- Verify basic setup

### **Batch 2: Dependencies and Styling (Day 1)**
- Install all required dependencies
- Configure Tailwind CSS
- Set up global styles

### **Batch 3: Development Tools (Day 2)**
- Configure ESLint and Prettier
- Set up TypeScript configuration
- Add NPM scripts

### **Batch 4: Project Structure (Day 2)**
- Create folder architecture
- Build base components
- Implement error boundaries

### **Batch 5: Routing and Pages (Day 3)**
- Configure React Router
- Create basic pages
- Test navigation

### **Batch 6: API Integration (Day 3)**
- Set up Axios configuration
- Create API hooks
- Test backend communication

### **Batch 7: State Management (Day 4)**
- Configure Zustand store
- Create utility types and constants
- Test state functionality

### **Batch 8: Final Testing (Day 4)**
- Comprehensive testing
- Performance verification
- Documentation updates

---

## 📊 Success Metrics

### **Performance Targets:**
- Development server start time: < 3 seconds
- Hot reload response time: < 1 second
- Build time: < 30 seconds
- Bundle size: < 1MB (initial)

### **Quality Targets:**
- TypeScript compilation: 0 errors
- ESLint issues: 0 errors, < 5 warnings
- API response time: < 500ms to backend
- Test coverage: 100% for infrastructure code

### **Functionality Targets:**
- All routes working correctly
- Error boundaries catching all errors
- Loading states on all async operations
- Responsive design on mobile/desktop
- Cross-browser compatibility (Chrome, Firefox, Safari)

---

## 🔧 Environment Configuration

### **Development Environment:**
- Node.js version: 22.17.1+
- Package manager: npm
- Development port: 3000
- API proxy: http://127.0.0.1:8000

### **Build Configuration:**
- Build tool: Vite
- TypeScript: Strict mode enabled
- Source maps: Enabled for debugging
- Code splitting: Automatic by Vite

---

## 🚀 Next Steps After Phase 3

### **Immediate Readiness:**
- ✅ Ready for Phase 4: Authentication System
- ✅ Frontend-backend communication established
- ✅ State management in place
- ✅ Routing infrastructure ready
- ✅ Error handling implemented

### **Future Phases Setup:**
- Authentication forms ready for implementation
- API services ready for feature endpoints
- State slices ready for business data
- Components ready for feature development
- Styling system ready for custom designs

---

**Phase 3 establishes a robust, scalable frontend foundation that follows React best practices and integrates seamlessly with the Django backend from Phase 2.**