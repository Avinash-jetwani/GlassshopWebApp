from django.contrib import admin

class BaseModelAdmin(admin.ModelAdmin):
    """
    Base admin configuration for models extending BaseModel
    """
    readonly_fields = ('id', 'created_at', 'updated_at')
    list_display = ('id', 'created_at', 'updated_at', 'is_active')
    list_filter = ('is_active', 'created_at', 'updated_at')
    search_fields = ('id',)
    ordering = ('-created_at',)