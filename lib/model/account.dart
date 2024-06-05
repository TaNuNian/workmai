class Account{
  String email;
  String password;
  String? confirmPassword;
  Account({required this.email, required this.password, this.confirmPassword});
}