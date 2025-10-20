import 'package:azul_crm/theme/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.success,
      textColor: AppColor.grayLight,
    );
  }

  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.error,
      textColor: AppColor.grayLight,
    );
  }
}
