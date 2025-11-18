from django.db import models
from django.contrib.auth.models import AbstractUser
from core.models import BaseModel, TenantModel


class User(AbstractUser):
    """
    Custom user model extending Django's AbstractUser.
    """
    USER_ROLE_CHOICES = [
        ('admin', 'Admin'),
        ('teacher', 'Teacher'),
        ('student', 'Student'),
        ('parent', 'Parent'),
        ('accountant', 'Accountant'),
    ]
    
    role = models.CharField(max_length=20, choices=USER_ROLE_CHOICES)
    school = models.ForeignKey('schools.School', on_delete=models.CASCADE, null=True, blank=True)
    phone = models.CharField(max_length=20, blank=True)
    profile_picture = models.URLField(blank=True)
    date_of_birth = models.DateField(null=True, blank=True)
    address = models.TextField(blank=True)
    city = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=100, blank=True)
    country = models.CharField(max_length=100, blank=True)
    postal_code = models.CharField(max_length=20, blank=True)
    
    def __str__(self):
        return f"{self.username} ({self.get_role_display()})"

    class Meta:
        db_table = 'accounts_user'


class NotificationToken(BaseModel):
    """
    Model to store FCM notification tokens for users.
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notification_tokens')
    token = models.TextField()
    device_type = models.CharField(max_length=20, choices=[('android', 'Android'), ('ios', 'iOS')])
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return f"{self.user.username} - {self.device_type}"

    class Meta:
        db_table = 'accounts_notification_token'