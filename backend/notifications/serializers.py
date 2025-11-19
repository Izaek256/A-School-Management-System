from rest_framework import serializers
from .models import Notification, NotificationPreference
from accounts.models import User


class NotificationSerializer(serializers.ModelSerializer):
    """
    Serializer for the Notification model.
    """
    recipient_name = serializers.CharField(source='recipient.username', read_only=True)
    
    class Meta:
        model = Notification
        fields = [
            'id', 'title', 'message', 'notification_type', 'recipient', 
            'recipient_name', 'related_object_id', 'related_content_type',
            'is_read', 'read_at', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class NotificationPreferenceSerializer(serializers.ModelSerializer):
    """
    Serializer for the NotificationPreference model.
    """
    user_name = serializers.CharField(source='user.username', read_only=True)
    
    class Meta:
        model = NotificationPreference
        fields = [
            'id', 'user', 'user_name', 'email_notifications', 'push_notifications',
            'sms_notifications', 'announcement_emails', 'assignment_emails',
            'exam_emails', 'fee_emails', 'attendance_emails', 'message_emails'
        ]
        read_only_fields = ['id']


class NotificationPreferenceUpdateSerializer(serializers.ModelSerializer):
    """
    Serializer for updating NotificationPreference.
    """
    class Meta:
        model = NotificationPreference
        fields = [
            'email_notifications', 'push_notifications', 'sms_notifications',
            'announcement_emails', 'assignment_emails', 'exam_emails',
            'fee_emails', 'attendance_emails', 'message_emails'
        ]