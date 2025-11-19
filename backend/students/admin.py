from django.contrib import admin
from .models import Student, Guardian

# Register your models here
@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    list_display = ('student_id', 'first_name', 'last_name', 'school', 'date_of_birth', 'admission_date')
    list_filter = ('school', 'gender', 'admission_date')
    search_fields = ('student_id', 'first_name', 'last_name', 'user__username')
    ordering = ('-admission_date',)

@admin.register(Guardian)
class GuardianAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'relationship', 'student', 'phone', 'email')
    list_filter = ('relationship',)
    search_fields = ('first_name', 'last_name', 'student__first_name', 'student__last_name', 'student__student_id')