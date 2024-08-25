class CreateUserRq {
  final String fullName;
  final String email;
  final String password;
  CreateUserRq({
    required this.fullName,
    required this.email,
    required this.password
  });
}