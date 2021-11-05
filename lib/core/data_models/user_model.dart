class UserModel {
  UserModel({
    required this.email,
    required this.firstname,
    required this.lastname,
  });

  String firstname, lastname, email;

  factory UserModel.fromMap(Map<String, dynamic>? map) => UserModel(
        email: map!["email"],
        firstname: map["firstname"],
        lastname: map["surname"],
      );
}
