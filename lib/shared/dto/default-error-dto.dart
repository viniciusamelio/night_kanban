class DefaultErrorDto {
  String message;
  String code;
  DefaultErrorDto({message, code});

  @override
  String toString() {
    return message;
  }
}
