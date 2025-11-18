class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String enrollmentDate;
  final String className;
  final String parentId;
  final String address;
  final String gender;
  final String profileImageUrl;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.enrollmentDate,
    required this.className,
    required this.parentId,
    required this.address,
    required this.gender,
    required this.profileImageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      enrollmentDate: json['enrollment_date'] as String,
      className: json['class_name'] as String,
      parentId: json['parent_id'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      profileImageUrl: json['profile_image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'enrollment_date': enrollmentDate,
      'class_name': className,
      'parent_id': parentId,
      'address': address,
      'gender': gender,
      'profile_image_url': profileImageUrl,
    };
  }

  String get fullName => '$firstName $lastName';
}