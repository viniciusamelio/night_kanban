import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:night_kanban/shared/services/dialogs/dto/dialog-dto.dart';
import 'package:night_kanban/shared/services/dialogs/interfaces/dialog-adapter.dart';
import 'package:night_kanban/shared/styles/colors.dart';

class AwesomeDialogService implements DialogAdapter {
  @override
  errorDialog(DialogDto dialog) {
    return AwesomeDialog(
      context: dialog.context,
      dismissOnTouchOutside: dialog.dismissOnClick,
      dialogBackgroundColor: darkGrey,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: dialog.title ?? 'Oopss',
      btnOk: dialog.confirmButton,
      btnCancel: dialog.cancelButton,
      showCloseIcon: dialog.showCloseIcon,
      desc: dialog.message,
    )..show();
  }

  @override
  infoDialog(DialogDto dialog) {
    return AwesomeDialog(
      context: dialog.context,
      dismissOnTouchOutside: dialog.dismissOnClick,
      dialogBackgroundColor: darkGrey,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: dialog.title,
      btnOk: dialog.confirmButton,
      btnCancel: dialog.cancelButton,
      showCloseIcon: dialog.showCloseIcon,
      desc: dialog.message,
    )..show();
  }

  @override
  successDialog(DialogDto dialog) {
    return AwesomeDialog(
      context: dialog.context,
      dismissOnTouchOutside: dialog.dismissOnClick,
      dialogBackgroundColor: darkGrey,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: dialog.title,
      btnOk: dialog.confirmButton,
      btnCancel: dialog.cancelButton,
      showCloseIcon: dialog.showCloseIcon,
      desc: dialog.message,
    )..show();
  }

  @override
  warningDialog(DialogDto dialog) {
    return AwesomeDialog(
      context: dialog.context,
      dismissOnTouchOutside: dialog.dismissOnClick,
      dialogBackgroundColor: darkGrey,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: dialog.title,
      btnOk: dialog.confirmButton,
      btnCancel: dialog.cancelButton,
      showCloseIcon: dialog.showCloseIcon,
      desc: dialog.message,
    )..show();
  }
}
