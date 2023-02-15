import 'package:chat_app/src/pages/messages/photoview/index.dart';
import 'package:get/get.dart';

class PhotoViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoController>(() => PhotoController());
  }
}
