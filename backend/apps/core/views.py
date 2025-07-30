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