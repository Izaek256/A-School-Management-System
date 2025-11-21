import 'package:flutter/material.dart';

class Announcement {
  final int id;
  final String title;
  final String content;
  final int authorId;
  final String authorName;
  final String publishDate;
  final String priority;
  final bool isPublished;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.publishDate,
    required this.priority,
    required this.isPublished,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      authorId: json['author'] ?? 0,
      authorName: json['author_name'] ?? '',
      publishDate: json['publish_date'] ?? '',
      priority: json['priority'] ?? 'medium',
      isPublished: json['is_published'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': authorId,
      'author_name': authorName,
      'publish_date': publishDate,
      'priority': priority,
      'is_published': isPublished,
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