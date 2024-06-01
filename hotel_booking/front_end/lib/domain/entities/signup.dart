class SignupState {
  final String? fullName;
  final String? email;
  final String password;
  final String confirmPassword;
  final bool isAdmin;

  SignupState({
    this.fullName,
    this.email,
    this.password = '',
    this.confirmPassword = '',
    this.isAdmin = false,
  });

  SignupState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isAdmin,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}