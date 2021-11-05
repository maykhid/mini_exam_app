class AuthCredentials {
  final String email;
  final String password;
  final String? firstname;
  final String? surname;

  AuthCredentials({
    required this.email,
    this.firstname,
    this.surname,
    required this.password,
  });
}
