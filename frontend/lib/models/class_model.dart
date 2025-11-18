class ClassModel {
  final String id;
  final String name;
  final String section;
  final String teacherId;
  final String teacherName;
  final int studentCount;
  final String academicYear;

  ClassModel({
    required this.id,
    required this.name,
    required this.section,
    required this.teacherId,
    required this.teacherName,
    required this.studentCount,
    required this.academicYear,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as String,
      name: json['name'] as String,
      section: json['section'] as String,
      teacherId: json['teacher_id'] as String,
      teacherName: json['teacher_name'] as String,
      studentCount: json['student_count'] as int,
      academicYear: json['academic_year'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'section': section,
      'teacher_id': teacherId,
      'teacher_name': teacherName,
      'student_count': studentCount,
      'academic_year': academicYear,
    };
  }
}