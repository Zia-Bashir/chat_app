import 'package:chat_app/src/pages/messages/photoview/index.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  final state = PhotoViewState();
  PhotoController();

  @override
  void onInit() {
    var data = Get.parameters;
    if (data['url'] != null) {
      state.phoroUrl.value = data['url']!;
    }
    super.onInit();
  }
}
