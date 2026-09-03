
class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String createdAt;
  final String updatedAt;
  final bool isOptIn;
  final bool isAdmin;


  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.isOptIn,
    required this.isAdmin,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      isOptIn: json['isOptIn'] ?? false,
      isAdmin: json['isAdmin'] ?? false,
    );
  }
}