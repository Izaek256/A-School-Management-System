from django.contrib import admin
from .models import Subject, Class, Enrollment, Exam, ExamResult, Attendance, AcademicYear

# Register your models here
@admin.register(Subject)
class SubjectAdmin(admin.ModelAdmin):
    list_display = ('name', 'code', 'school', 'teacher', 'created_at')
    list_filter = ('school', 'created_at')
    search_fields = ('name', 'code', 'teacher__user__first_name', 'teacher__user__last_name')
    ordering = ('name',)

@admin.register(Class)
class ClassAdmin(admin.ModelAdmin):
    list_display = ('name', 'school', 'academic_year', 'class_teacher', 'created_at')
    list_filter = ('school', 'academic_year', 'created_at')
    search_fields = ('name', 'class_teacher__user__first_name', 'class_teacher__user__last_name')
    ordering = ('name',)

@admin.register(Enrollment)
class EnrollmentAdmin(admin.ModelAdmin):
    list_display = ('student', 'class_enrolled', 'academic_year', 'school', 'created_at')
    list_filter = ('school', 'academic_year', 'created_at')
    search_fields = ('student__user__first_name', 'student__user__last_name', 'class_enrolled__name')
    ordering = ('-created_at',)

@admin.register(Exam)
class ExamAdmin(admin.ModelAdmin):
    list_display = ('name', 'subject', 'class_assigned', 'date', 'school', 'created_at')
    list_filter = ('school', 'date', 'created_at')
    search_fields = ('name', 'subject__name', 'class_assigned__name')
    ordering = ('-date',)

@admin.register(ExamResult)
class ExamResultAdmin(admin.ModelAdmin):
    list_display = ('exam', 'student', 'marks_obtained', 'school', 'created_at')
    list_filter = ('school', 'created_at')
    search_fields = ('exam__name', 'student__user__first_name', 'student__user__last_name')
    ordering = ('-created_at',)

@admin.register(Attendance)
class AttendanceAdmin(admin.ModelAdmin):
    list_display = ('student', 'class_attended', 'subject', 'date', 'status', 'school')
    list_filter = ('school', 'date', 'status')
    search_fields = ('student__user__first_name', 'student__user__last_name', 'class_attended__name')
    ordering = ('-date',)

@admin.register(AcademicYear)
class AcademicYearAdmin(admin.ModelAdmin):
    list_display = ('name', 'school', 'start_date', 'end_date', 'is_current')
    list_filter = ('school', 'is_current')
    search_fields = ('name',)
    ordering = ('-start_date',)