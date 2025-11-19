from django.contrib import admin
from .models import Announcement, Message, MessageAttachment

# Register your models here
@admin.register(Announcement)
class AnnouncementAdmin(admin.ModelAdmin):
    list_display = ('title', 'school', 'author', 'audience', 'priority', 'is_published', 'publish_date', 'expiry_date')
    list_filter = ('school', 'audience', 'priority', 'is_published')
    search_fields = ('title', 'content', 'author__username')
    ordering = ('-publish_date',)

@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display = ('sender', 'recipient', 'subject', 'is_read', 'sent_at')
    list_filter = ('is_read', 'sent_at')
    search_fields = ('subject', 'content', 'sender__username', 'recipient__username')
    ordering = ('-sent_at',)

@admin.register(MessageAttachment)
class MessageAttachmentAdmin(admin.ModelAdmin):
    list_display = ('message', 'file_name', 'file_size', 'uploaded_at')
    list_filter = ('uploaded_at',)
    search_fields = ('message__subject', 'file_name')
    ordering = ('-uploaded_at',)