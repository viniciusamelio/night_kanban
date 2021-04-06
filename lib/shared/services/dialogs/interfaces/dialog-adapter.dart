import 'package:night_kanban/shared/services/dialogs/dto/dialog-dto.dart';

abstract class DialogAdapter {
  dynamic successDialog(DialogDto dialog);
  dynamic errorDialog(DialogDto dialog);
  dynamic warningDialog(DialogDto dialog);
  dynamic infoDialog(DialogDto dialog);
}
