from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import StudentViewSet, GuardianViewSet

# Create router and register viewsets
router = DefaultRouter()
router.register(r'students', StudentViewSet, basename='student')
router.register(r'guardians', GuardianViewSet, basename='guardian')

urlpatterns = [
    path('', include(router.urls)),
]