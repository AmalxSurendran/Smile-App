class Doctor {
  final int id;
  final String doctorId;
  final String name;
  final String email;
  final String mobile;
  final String username;

  Doctor({
    required this.id,
    required this.doctorId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.username,
  });

  // Factory constructor to create a Doctor object from JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      doctorId: json['doctor_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      username: json['username'],
    );
  }
}
