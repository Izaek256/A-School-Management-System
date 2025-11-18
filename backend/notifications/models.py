from django.db import models
from core.models import BaseModel


class Notification(BaseModel):
    """
    Model representing system notifications.
    """
    NOTIFICATION_TYPE_CHOICES = [
        ('announcement', 'Announcement'),
        ('assignment', 'Assignment'),
        ('exam', 'Exam'),
        ('fee', 'Fee'),
        ('attendance', 'Attendance'),
        ('message', 'Message'),
        ('system', 'System'),
    ]
    
    title = models.CharField(max_length=200)
    message = models.TextField()
    notification_type = models.CharField(max_length=20, choices=NOTIFICATION_TYPE_CHOICES)
    recipient = models.ForeignKey('accounts.User', on_delete=models.CASCADE, related_name='notifications')
    related_object_id = models.PositiveIntegerField(null=True, blank=True)
    related_content_type = models.CharField(max_length=100, blank=True)
    is_read = models.BooleanField(default=False)
    read_at = models.DateTimeField(null=True, blank=True)
    
    def __str__(self):
        return f"{self.title} - {self.recipient}"

    class Meta(BaseModel.Meta):
        db_table = 'notifications_notification'
        ordering = ['-created_at']


class NotificationPreference(models.Model):
    """
    Model representing notification preferences for users.
    """
    user = models.OneToOneField('accounts.User', on_delete=models.CASCADE, related_name='notification_preferences')
    email_notifications = models.BooleanField(default=True)
    push_notifications = models.BooleanField(default=True)
    sms_notifications = models.BooleanField(default=True)
    announcement_emails = models.BooleanField(default=True)
    assignment_emails = models.BooleanField(default=True)
    exam_emails = models.BooleanField(default=True)
    fee_emails = models.BooleanField(default=True)
    attendance_emails = models.BooleanField(default=True)
    message_emails = models.BooleanField(default=True)
    
    def __str__(self):
        return f"Notification preferences for {self.user}"

    class Meta:
        db_table = 'notifications_notification_preference'