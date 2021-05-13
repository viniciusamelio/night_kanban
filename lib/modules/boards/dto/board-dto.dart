import 'dart:convert';

class BoardDto {
  int id;
  String title;
  String description;
  String color;
  int userId;

  BoardDto({
    this.id,
    this.title,
    this.description,
    this.color,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'user_id': userId,
    };
  }

  factory BoardDto.fromMap(Map<String, dynamic> map) {
    return BoardDto(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      color: map['color'],
      userId: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoardDto.fromJson(String source) =>
      BoardDto.fromMap(json.decode(source));
}
