class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
  });

  factory UserModel.dummy() {
    return UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '+62 812 3456 7890',
      avatar: null,
    );
  }
}
