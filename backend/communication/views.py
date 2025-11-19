from rest_framework import viewsets, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import Announcement, Message, MessageAttachment
from .serializers import (
    AnnouncementSerializer, MessageSerializer, 
    MessageCreateSerializer, MessageAttachmentSerializer
)


class AnnouncementViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing announcements.
    """
    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['audience', 'priority', 'is_published']
    
    def get_queryset(self):
        """
        Filter announcements based on user role and school.
        """
        user = self.request.user
        if user.role == 'admin':
            return Announcement.objects.all()
        elif user.school:
            # Filter by school and audience
            queryset = Announcement.objects.filter(school=user.school)
            if user.role == 'student':
                queryset = queryset.filter(audience__in=['all', 'students'])
            elif user.role == 'teacher':
                queryset = queryset.filter(audience__in=['all', 'teachers'])
            return queryset
        return Announcement.objects.none()
    
    def perform_create(self, serializer):
        """
        Set the school and author when creating an announcement.
        """
        user = self.request.user
        serializer.save(school=user.school, author=user)


class MessageViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing messages.
    """
    queryset = Message.objects.all()
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['is_read']
    
    def get_queryset(self):
        """
        Filter messages based on user as sender or recipient.
        """
        user = self.request.user
        if user.role == 'admin':
            return Message.objects.all()
        elif user.school:
            return Message.objects.filter(
                school=user.school
            ).filter(
                sender=user
            ).union(
                Message.objects.filter(
                    school=user.school
                ).filter(
                    recipient=user
                )
            )
        return Message.objects.none()
    
    def get_serializer_class(self):
        """
        Return the appropriate serializer class based on the action.
        """
        if self.action == 'create':
            return MessageCreateSerializer
        return MessageSerializer
    
    def perform_create(self, serializer):
        """
        Set the school and sender when creating a message.
        """
        user = self.request.user
        serializer.save(school=user.school, sender=user)
    
    @action(detail=True, methods=['post'])
    def mark_as_read(self, request, pk=None):
        """
        Mark a message as read.
        """
        message = self.get_object()
        message.is_read = True
        message.save()
        return Response({'status': 'message marked as read'})
    
    @action(detail=False, methods=['get'])
    def inbox(self, request):
        """
        Get messages received by the user.
        """
        user = request.user
        messages = Message.objects.filter(recipient=user).order_by('-sent_at')
        serializer = self.get_serializer(messages, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def sent(self, request):
        """
        Get messages sent by the user.
        """
        user = request.user
        messages = Message.objects.filter(sender=user).order_by('-sent_at')
        serializer = self.get_serializer(messages, many=True)
        return Response(serializer.data)


class MessageAttachmentViewSet(viewsets.ModelViewSet):
    """
    ViewSet for managing message attachments.
    """
    queryset = MessageAttachment.objects.all()
    serializer_class = MessageAttachmentSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        """
        Filter message attachments based on user.
        """
        user = self.request.user
        if user.role == 'admin':
            return MessageAttachment.objects.all()
        elif user.school:
            return MessageAttachment.objects.filter(
                message__school=user.school
            ).filter(
                message__sender=user
            ).union(
                MessageAttachment.objects.filter(
                    message__school=user.school
                ).filter(
                    message__recipient=user
                )
            )
        return MessageAttachment.objects.none()