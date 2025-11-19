from django.contrib import admin
from .models import School

# Register your models here
@admin.register(School)
class SchoolAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'email', 'phone', 'city', 'is_verified')
    list_filter = ('is_verified', 'city', 'state', 'country')
    search_fields = ('name', 'slug', 'email', 'phone')
    ordering = ('name',)