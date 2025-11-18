import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final bool isRead;
  final String type; // assignment, exam, announcement, payment

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isRead,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      isRead: json['is_read'] as bool,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'is_read': isRead,
      'type': type,
    };
  }

  IconData get icon {
    switch (type) {
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