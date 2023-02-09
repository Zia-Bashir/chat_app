import 'package:chat_app/src/pages/chat/index.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();

  @override
  void onInit() {
    var data = Get.parameters;
    state.docId = data['doc_id'];
    state.toUid.value = data['to_uid'] ?? '';
    state.toName.value = data['to_name'] ?? '';
    state.toAvatar.value = data['to_avatar'] ?? '';
    super.onInit();
  }
}
