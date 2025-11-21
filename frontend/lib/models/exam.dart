class Exam {
  final int id;
  final String name;
  final int classId;
  final String className;
  final int subjectId;
  final String subjectName;
  final String date;
  final String startTime;
  final String endTime;
  final String examType;
  final double maxMarks;
  final double passingMarks;

  Exam({
    required this.id,
    required this.name,
    required this.classId,
    required this.className,
    required this.subjectId,
    required this.subjectName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.examType,
    required this.maxMarks,
    required this.passingMarks,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      name: json['name'] ?? '',
      classId: json['class_assigned'] ?? 0,
      className: json['class_name'] ?? '',
      subjectId: json['subject'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      examType: json['exam_type'] ?? '',
      maxMarks: (json['max_marks'] as num?)?.toDouble() ?? 0.0,
      passingMarks: (json['passing_marks'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'class_assigned': classId,
      'class_name': className,
      'subject': subjectId,
      'subject_name': subjectName,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'exam_type': examType,
      'max_marks': maxMarks,
      'passing_marks': passingMarks,
    };
  }
}