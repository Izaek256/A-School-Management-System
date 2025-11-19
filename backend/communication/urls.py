from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AnnouncementViewSet, MessageViewSet, MessageAttachmentViewSet

# Create router and register viewsets
router = DefaultRouter()
router.register(r'announcements', AnnouncementViewSet, basename='announcement')
router.register(r'messages', MessageViewSet, basename='message')
router.register(r'attachments', MessageAttachmentViewSet, basename='attachment')

urlpatterns = [
    path('', include(router.urls)),
]