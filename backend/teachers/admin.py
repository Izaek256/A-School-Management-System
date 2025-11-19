from django.contrib import admin
from .models import Teacher

# Register your models here
@admin.register(Teacher)
class TeacherAdmin(admin.ModelAdmin):
    list_display = ('employee_id', 'first_name', 'last_name', 'school', 'department', 'joining_date', 'is_active')
    list_filter = ('school', 'department', 'is_active', 'joining_date')
    search_fields = ('employee_id', 'first_name', 'last_name', 'user__username')
    ordering = ('-joining_date',)