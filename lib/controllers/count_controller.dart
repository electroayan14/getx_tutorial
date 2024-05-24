import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt counter = 0.obs;

  void increaseCount() {
    counter.value++;
  }
  void decreaseCount() {
    counter.value--;
  }
}
