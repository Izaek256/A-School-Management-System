from rest_framework import serializers
from .models import Announcement, Message, MessageAttachment
from accounts.models import User


class AnnouncementSerializer(serializers.ModelSerializer):
    """
    Serializer for the Announcement model.
    """
    author_name = serializers.CharField(source='author.username', read_only=True)
    
    class Meta:
        model = Announcement
        fields = [
            'id', 'title', 'content', 'author', 'author_name', 'audience',
            'priority', 'is_published', 'publish_date', 'expiry_date',
            'created_at', 'updated_at', 'is_active'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']


class MessageAttachmentSerializer(serializers.ModelSerializer):
    """
    Serializer for the MessageAttachment model.
    """
    class Meta:
        model = MessageAttachment
        fields = [
            'id', 'message', 'file', 'file_name', 'file_size', 'uploaded_at'
        ]
        read_only_fields = ['id', 'uploaded_at']


class MessageSerializer(serializers.ModelSerializer):
    """
    Serializer for the Message model.
    """
    sender_name = serializers.CharField(source='sender.username', read_only=True)
    recipient_name = serializers.CharField(source='recipient.username', read_only=True)
    attachments = MessageAttachmentSerializer(many=True, read_only=True)
    
    class Meta:
        model = Message
        fields = [
            'id', 'sender', 'sender_name', 'recipient', 'recipient_name',
            'subject', 'content', 'is_read', 'sent_at', 'attachments',
            'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'sent_at', 'created_at', 'updated_at']


class MessageCreateSerializer(serializers.ModelSerializer):
    """
    Serializer for creating Message with attachments.
    """
    attachments = MessageAttachmentSerializer(many=True, required=False)
    
    class Meta:
        model = Message
        fields = [
            'recipient', 'subject', 'content', 'attachments'
        ]
    
    def create(self, validated_data):
        attachments_data = validated_data.pop('attachments', [])
        sender = self.context['request'].user
        
        # Create message
        message = Message.objects.create(sender=sender, **validated_data)
        
        # Create attachments
        for attachment_data in attachments_data:
            MessageAttachment.objects.create(message=message, **attachment_data)
        
        return message