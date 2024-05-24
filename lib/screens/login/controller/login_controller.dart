import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString email = RxString('');
  RxString password = RxString('');
  final isValid = false.obs; // Use RxBool for button state

  void checkValidation(username, password) {
    if (GetUtils.isEmail(username) && password.toString().length > 9) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

}
