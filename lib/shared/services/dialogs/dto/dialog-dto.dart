import 'package:flutter/cupertino.dart';

class DialogDto {
  final String message;
  String title;
  final BuildContext context;
  Widget confirmButton;
  Widget cancelButton;
  bool showCloseIcon;
  bool dismissOnClick;

  DialogDto(
      {@required this.message,
      @required this.context,
      this.title,
      this.confirmButton,
      this.dismissOnClick = true,
      this.cancelButton,
      this.showCloseIcon = false});
}
