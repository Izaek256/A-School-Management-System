from django.contrib import admin
from .models import Notification, NotificationPreference

# Register your models here
@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ('title', 'recipient', 'notification_type', 'is_read', 'created_at')
    list_filter = ('notification_type', 'is_read', 'created_at')
    search_fields = ('title', 'message', 'recipient__username')
    ordering = ('-created_at',)

@admin.register(NotificationPreference)
class NotificationPreferenceAdmin(admin.ModelAdmin):
    list_display = ('user', 'email_notifications', 'push_notifications', 'sms_notifications')
    list_filter = ('email_notifications', 'push_notifications', 'sms_notifications')
    search_fields = ('user__username',)
    ordering = ('user',)