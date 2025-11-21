class Teacher {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dateOfBirth;
  final String joiningDate;
  final String department;
  final String designation;
  final String qualification;
  final String address;
  final String gender;
  final String? profileImageUrl;

  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.joiningDate,
    required this.department,
    required this.designation,
    required this.qualification,
    required this.address,
    required this.gender,
    this.profileImageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      joiningDate: json['joining_date'] ?? '',
      department: json['department'] ?? '',
      designation: json['designation'] ?? '',
      qualification: json['qualification'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      profileImageUrl: null, // Not in serializer
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
      'joining_date': joiningDate,
      'department': department,
      'designation': designation,
      'qualification': qualification,
      'address': address,
      'gender': gender,
      'profile_image_url': profileImageUrl,
    };
  }

  String get fullName => '$firstName $lastName';
}