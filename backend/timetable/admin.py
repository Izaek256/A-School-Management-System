from django.contrib import admin
from .models import Timetable, TimetablePeriod

# Register your models here
@admin.register(Timetable)
class TimetableAdmin(admin.ModelAdmin):
    list_display = ('name', 'class_assigned', 'school', 'academic_year', 'is_active')
    list_filter = ('school', 'academic_year', 'is_active')
    search_fields = ('name', 'class_assigned__name')
    ordering = ('name',)

@admin.register(TimetablePeriod)
class TimetablePeriodAdmin(admin.ModelAdmin):
    list_display = ('timetable', 'day_of_week', 'period_number', 'start_time', 'end_time', 'subject', 'teacher')
    list_filter = ('day_of_week', 'timetable__school')
    search_fields = ('timetable__name', 'subject__name', 'teacher__user__first_name', 'teacher__user__last_name')
    ordering = ('day_of_week', 'period_number')