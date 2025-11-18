class Exam {
  final String id;
  final String name;
  final String classId;
  final String className;
  final String subject;
  final String date;
  final String startTime;
  final String endTime;
  final String examType;
  final int totalMarks;

  Exam({
    required this.id,
    required this.name,
    required this.classId,
    required this.className,
    required this.subject,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.examType,
    required this.totalMarks,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'] as String,
      name: json['name'] as String,
      classId: json['class_id'] as String,
      className: json['class_name'] as String,
      subject: json['subject'] as String,
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      examType: json['exam_type'] as String,
      totalMarks: json['total_marks'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'class_id': classId,
      'class_name': className,
      'subject': subject,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'exam_type': examType,
      'total_marks': totalMarks,
    };
  }
}