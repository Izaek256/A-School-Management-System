from django.contrib import admin
from .models import Assignment, Submission

# Register your models here
@admin.register(Assignment)
class AssignmentAdmin(admin.ModelAdmin):
    list_display = ('title', 'subject', 'class_assigned', 'teacher', 'assignment_type', 'assigned_date', 'due_date', 'school')
    list_filter = ('school', 'assignment_type', 'assigned_date', 'due_date')
    search_fields = ('title', 'subject__name', 'class_assigned__name', 'teacher__user__first_name', 'teacher__user__last_name')
    ordering = ('-assigned_date',)

@admin.register(Submission)
class SubmissionAdmin(admin.ModelAdmin):
    list_display = ('assignment', 'student', 'submission_date', 'marks_obtained', 'status')
    list_filter = ('status', 'submission_date')
    search_fields = ('assignment__title', 'student__first_name', 'student__last_name')
    ordering = ('-submission_date',)