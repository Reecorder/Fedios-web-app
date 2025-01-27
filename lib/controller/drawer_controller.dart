import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  /* selected option */
  RxString selectedOption = "Orders".obs;

  /* change selection */
  void changeSelection({required String option}) {
    /* change selected option */
    selectedOption.value = option;

    Get.back();
  }
}
