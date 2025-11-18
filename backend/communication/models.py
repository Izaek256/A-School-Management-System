from django.db import models
from core.models import TenantModel


class Announcement(TenantModel):
    """
    Model representing announcements in the school.
    """
    AUDIENCE_CHOICES = [
        ('all', 'All'),
        ('students', 'Students Only'),
        ('teachers', 'Teachers Only'),
        ('parents', 'Parents Only'),
        ('staff', 'Staff Only'),
    ]
    
    title = models.CharField(max_length=200)
    content = models.TextField()
    author = models.ForeignKey('accounts.User', on_delete=models.SET_NULL, null=True, blank=True)
    audience = models.CharField(max_length=20, choices=AUDIENCE_CHOICES, default='all')
    priority = models.CharField(max_length=20, choices=[('low', 'Low'), ('medium', 'Medium'), ('high', 'High')], default='medium')
    is_published = models.BooleanField(default=False)
    publish_date = models.DateTimeField(null=True, blank=True)
    expiry_date = models.DateTimeField(null=True, blank=True)
    
    def __str__(self):
        return self.title

    class Meta(TenantModel.Meta):
        db_table = 'communication_announcement'
        ordering = ['-publish_date']


class Message(TenantModel):
    """
    Model representing private messages between users.
    """
    sender = models.ForeignKey('accounts.User', on_delete=models.CASCADE, related_name='sent_messages')
    recipient = models.ForeignKey('accounts.User', on_delete=models.CASCADE, related_name='received_messages')
    subject = models.CharField(max_length=200)
    content = models.TextField()
    is_read = models.BooleanField(default=False)
    sent_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"From {self.sender} to {self.recipient}: {self.subject}"

    class Meta(TenantModel.Meta):
        db_table = 'communication_message'
        ordering = ['-sent_at']


class MessageAttachment(models.Model):
    """
    Model representing attachments in messages.
    """
    message = models.ForeignKey(Message, on_delete=models.CASCADE, related_name='attachments')
    file = models.URLField()
    file_name = models.CharField(max_length=255)
    file_size = models.PositiveIntegerField()
    uploaded_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.file_name

    class Meta:
        db_table = 'communication_message_attachment'