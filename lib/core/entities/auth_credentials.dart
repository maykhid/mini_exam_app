class AuthCredentials {
  final String email;
  final String password;
  final String? fullname;

  AuthCredentials({required this.email, this.fullname, required this.password});
}
