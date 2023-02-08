import 'package:chat_app/src/pages/signin/controller.dart';
import 'package:get/get.dart';

class SignINBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
