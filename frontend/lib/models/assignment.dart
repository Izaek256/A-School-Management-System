class Assignment {
  final String id;
  final String title;
  final String description;
  final String classId;
  final String className;
  final String subject;
  final String teacherId;
  final String teacherName;
  final String dueDate;
  final String assignedDate;
  final List<String> attachments;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.classId,
    required this.className,
    required this.subject,
    required this.teacherId,
    required this.teacherName,
    required this.dueDate,
    required this.assignedDate,
    required this.attachments,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      classId: json['class_id'] as String,
      className: json['class_name'] as String,
      subject: json['subject'] as String,
      teacherId: json['teacher_id'] as String,
      teacherName: json['teacher_name'] as String,
      dueDate: json['due_date'] as String,
      assignedDate: json['assigned_date'] as String,
      attachments: List<String>.from(json['attachments'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'class_id': classId,
      'class_name': className,
      'subject': subject,
      'teacher_id': teacherId,
      'teacher_name': teacherName,
      'due_date': dueDate,
      'assigned_date': assignedDate,
      'attachments': attachments,
    };
  }

  bool get isOverdue {
    final due = DateTime.parse(dueDate);
    return DateTime.now().isAfter(due);
  }
}