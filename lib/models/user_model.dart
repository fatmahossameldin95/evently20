class UserModel {
  String? id;
  String? name;
  String email;
  String? password;
  UserModel({required this.email, this.id, this.name, this.password});

  Map<String, dynamic> toJson() {
    return {"name": name, "id": id, "email": email};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      id: json['id'],
      name: json['name'],
    );
  }
}
