import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AddToCartButtonController extends GetxController {
  RxBool isChangedView = true.obs;

  void changeView() {
    isChangedView.value = !isChangedView.value;
  }
}
