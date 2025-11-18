import 'package:flutter/material.dart';

class Announcement {
  final String id;
  final String title;
  final String content;
  final String author;
  final String date;
  final String priority; // high, medium, low
  final List<String> attachments;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.priority,
    required this.attachments,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      date: json['date'] as String,
      priority: json['priority'] as String,
      attachments: List<String>.from(json['attachments'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'date': date,
      'priority': priority,
      'attachments': attachments,
    };
  }

  Color get priorityColor {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}