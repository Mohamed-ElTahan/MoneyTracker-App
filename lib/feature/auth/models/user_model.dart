class UserModel {
  final String email;
  final String password;
  final String name;
  final List fev;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.fev,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'name': name, "fev": fev};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      fev: json['fev'],
    );
  }
}
