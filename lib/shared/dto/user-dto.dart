class UserDto {
  String name;

  String email;

  bool isActive;

  int id;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = name;
    json['email'] = email;
    json['is_active'] = isActive;
    json['id'] = id;
    return json;
  }

  UserDto.fromJson(Map json) {
    name = json['name'];
    email = json['email'];
    isActive = json['is_active'] == 1;
    id = json['id'];
  }
}
