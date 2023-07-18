import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void messageBar(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
