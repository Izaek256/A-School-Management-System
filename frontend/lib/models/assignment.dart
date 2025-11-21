class Assignment {
  final int id;
  final String title;
  final String description;
  final int classId;
  final String className;
  final int subjectId;
  final String subjectName;
  final int teacherId;
  final String teacherName;
  final String dueDate;
  final String assignedDate;
  final String? attachment;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.classId,
    required this.className,
    required this.subjectId,
    required this.subjectName,
    required this.teacherId,
    required this.teacherName,
    required this.dueDate,
    required this.assignedDate,
    this.attachment,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      classId: json['class_assigned'] ?? 0,
      className: json['class_name'] ?? '',
      subjectId: json['subject'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      teacherId: json['teacher'] ?? 0,
      teacherName: json['teacher_name'] ?? '',
      dueDate: json['due_date'] ?? '',
      assignedDate: json['assigned_date'] ?? '',
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'class_assigned': classId,
      'class_name': className,
      'subject': subjectId,
      'subject_name': subjectName,
      'teacher': teacherId,
      'teacher_name': teacherName,
      'due_date': dueDate,
      'assigned_date': assignedDate,
      'attachment': attachment,
    };
  }

  bool get isOverdue {
    if (dueDate.isEmpty) return false;
    try {
      final due = DateTime.parse(dueDate);
      return DateTime.now().isAfter(due);
    } catch (e) {
      return false;
    }
  }
}