from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserViewSet, NotificationTokenViewSet

# Create router and register viewsets
router = DefaultRouter()
router.register(r'users', UserViewSet, basename='user')
router.register(r'notification-tokens', NotificationTokenViewSet, basename='notification-token')

urlpatterns = [
    path('', include(router.urls)),
]