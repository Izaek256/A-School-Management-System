class ClassModel {
  final int id;
  final String name;
  final String section;
  final int? classTeacherId;
  final String? classTeacherName;
  final int capacity;
  final int? academicYearId;
  final String? academicYearName;

  ClassModel({
    required this.id,
    required this.name,
    required this.section,
    this.classTeacherId,
    this.classTeacherName,
    required this.capacity,
    this.academicYearId,
    this.academicYearName,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'] ?? '',
      section: json['section'] ?? '',
      classTeacherId: json['class_teacher'],
      classTeacherName: json['class_teacher_name'],
      capacity: json['capacity'] ?? 0,
      academicYearId: json['academic_year'],
      academicYearName: json['academic_year_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'section': section,
      'class_teacher': classTeacherId,
      'class_teacher_name': classTeacherName,
      'capacity': capacity,
      'academic_year': academicYearId,
      'academic_year_name': academicYearName,
    };
  }
}