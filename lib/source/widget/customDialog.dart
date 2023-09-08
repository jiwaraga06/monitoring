import 'package:awesome_dialog/awesome_dialog.dart';

class MyDialog {
  static dialogSuccess(context, message) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Success !',
      desc: message,
      btnOkOnPress: () {},
    )..show();
  }

  static dialogFailed(context, message) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Failed !',
      desc: message,
      btnOkOnPress: () {},
    )..show();
  }

  static dialogInfo(context, message, btnOkOnPress) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'Info !',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
    )..show();
  }
}
