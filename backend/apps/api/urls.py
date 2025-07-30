from django.urls import path, include

app_name = 'api'

urlpatterns = [
    # Health check endpoint
    path('health/', include('apps.core.urls')),
    
    # Authentication endpoints (basic structure only)
    path('auth/', include('apps.authentication.urls')),
]