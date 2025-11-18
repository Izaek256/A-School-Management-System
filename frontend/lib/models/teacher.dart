class Teacher {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String hireDate;
  final String subject;
  final String qualification;
  final String address;
  final String gender;
  final String profileImageUrl;

  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.hireDate,
    required this.subject,
    required this.qualification,
    required this.address,
    required this.gender,
    required this.profileImageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      hireDate: json['hire_date'] as String,
      subject: json['subject'] as String,
      qualification: json['qualification'] as String,
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
      'hire_date': hireDate,
      'subject': subject,
      'qualification': qualification,
      'address': address,
      'gender': gender,
      'profile_image_url': profileImageUrl,
    };
  }

  String get fullName => '$firstName $lastName';
}