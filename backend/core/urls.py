from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/accounts/', include('accounts.urls')),
    path('api/schools/', include('schools.urls')),
    path('api/students/', include('students.urls')),
    path('api/teachers/', include('teachers.urls')),
    path('api/academics/', include('academics.urls')),
    path('api/finance/', include('finance.urls')),
    path('api/assignments/', include('assignments.urls')),
    path('api/timetable/', include('timetable.urls')),
    path('api/communication/', include('communication.urls')),
    path('api/notifications/', include('notifications.urls')),
]