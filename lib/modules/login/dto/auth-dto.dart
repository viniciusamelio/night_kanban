class AuthDto {
  String email;
  String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["email"] = email;
    map['password'] = password;
    return map;
  }
}
