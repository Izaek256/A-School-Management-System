class Student {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String admissionDate;
  final String className;
  final String? parentPhone;
  final String address;
  final String gender;
  final String? profileImageUrl;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.admissionDate,
    required this.className,
    this.parentPhone,
    required this.address,
    required this.gender,
    this.profileImageUrl,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      admissionDate: json['admission_date'] ?? '',
      className: json['current_class_name'] ?? '',
      parentPhone: json['parent_phone'],
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      profileImageUrl: null, // Not provided in StudentSerializer
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
      'admission_date': admissionDate,
      'current_class_name': className,
      'parent_phone': parentPhone,
      'address': address,
      'gender': gender,
      'profile_image_url': profileImageUrl,
    };
  }

  String get fullName => '$firstName $lastName';
}