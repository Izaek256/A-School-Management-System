from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import SchoolViewSet

# Create router and register viewsets
router = DefaultRouter()
router.register(r'schools', SchoolViewSet, basename='school')

urlpatterns = [
    path('', include(router.urls)),
]