class SignupState {
  final bool isAdmin;
  final String? fullName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  SignupState({
    this.isAdmin = true,
    this.fullName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  SignupState copyWith({
    bool? isAdmin,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignupState(
      isAdmin: isAdmin ?? this.isAdmin,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
