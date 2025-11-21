import 'package:flutter/material.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String notificationType;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.notificationType,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      notificationType: json['notification_type'] ?? 'general',
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'notification_type': notificationType,
      'is_read': isRead,
      'created_at': createdAt,
    };
  }

  IconData get icon {
    switch (notificationType) {
      case 'assignment':
        return Icons.assignment;
      case 'exam':
        return Icons.quiz;
      case 'announcement':
        return Icons.campaign;
      case 'payment':
        return Icons.attach_money;
      default:
        return Icons.notifications;
    }
  }
}