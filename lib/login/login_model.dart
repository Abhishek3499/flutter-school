class LoginData {
  final String phone;
  final String? email;
  final String password;

  LoginData({required this.phone, this.email, required this.password});

  LoginData copyWith({String? phone, String? email, String? password}) {
    return LoginData(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() =>
      'LoginData(phone: $phone, email: ${email ?? '<none>'}, password: [REDACTED])';
}
