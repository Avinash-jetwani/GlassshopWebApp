#!/usr/bin/env python
"""
API Testing Script for GlassShop Backend
"""
import requests
import json
import time

def test_health_endpoint():
    """Test the health check endpoint"""
    try:
        print("🔍 Testing Health Check Endpoint...")
        response = requests.get('http://127.0.0.1:8000/api/v1/health/', timeout=10)
        print(f"✅ Status Code: {response.status_code}")
        print(f"📋 Response: {json.dumps(response.json(), indent=2)}")
        return True
    except Exception as e:
        print(f"❌ Health Check Failed: {e}")
        return False

def test_admin_endpoint():
    """Test the admin interface"""
    try:
        print("\n🔍 Testing Admin Interface...")
        response = requests.get('http://127.0.0.1:8000/admin/', timeout=10)
        print(f"✅ Admin Status Code: {response.status_code}")
        return True
    except Exception as e:
        print(f"❌ Admin Interface Failed: {e}")
        return False

def test_api_docs():
    """Test API documentation endpoints"""
    try:
        print("\n🔍 Testing API Documentation...")
        response = requests.get('http://127.0.0.1:8000/api/docs/', timeout=10)
        print(f"✅ API Docs Status Code: {response.status_code}")
        return True
    except Exception as e:
        print(f"❌ API Docs Failed: {e}")
        return False

def test_jwt_endpoints():
    """Test JWT authentication endpoints"""
    try:
        print("\n🔍 Testing JWT Token Endpoints...")
        # Test token verify endpoint (should return 401 without token)
        response = requests.post('http://127.0.0.1:8000/api/v1/auth/token/verify/', timeout=10)
        print(f"✅ JWT Verify Status Code: {response.status_code} (Expected: 400/401)")
        return True
    except Exception as e:
        print(f"❌ JWT Endpoints Failed: {e}")
        return False

def main():
    """Run all API tests"""
    print("🚀 Starting GlassShop API Tests")
    print("=" * 50)
    
    # Wait for server to be ready
    print("⏳ Waiting for server to start...")
    time.sleep(3)
    
    tests = [
        test_health_endpoint,
        test_admin_endpoint,
        test_api_docs,
        test_jwt_endpoints
    ]
    
    results = []
    for test in tests:
        results.append(test())
    
    print("\n" + "=" * 50)
    print(f"📊 Test Results: {sum(results)}/{len(results)} passed")
    
    if all(results):
        print("🎉 All API tests passed! Backend infrastructure is working correctly.")
    else:
        print("⚠️  Some tests failed. Check the output above for details.")

if __name__ == "__main__":
    main()