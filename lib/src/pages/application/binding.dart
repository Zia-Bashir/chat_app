import 'package:chat_app/src/pages/application/index.dart';
import 'package:chat_app/src/pages/contacts/index.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
