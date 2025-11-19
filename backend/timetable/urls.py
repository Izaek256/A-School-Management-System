from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import TimetableViewSet, TimetablePeriodViewSet

# Create router and register viewsets
router = DefaultRouter()
router.register(r'timetables', TimetableViewSet, basename='timetable')
router.register(r'periods', TimetablePeriodViewSet, basename='period')

urlpatterns = [
    path('', include(router.urls)),
]