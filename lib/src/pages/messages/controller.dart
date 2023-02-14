import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/firebase/firebase_reference.dart';
import 'package:chat_app/src/pages/messages/index.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final state = MessageState();
  MessageController();

  //* ------------------ Pull to Refresh (onRefresh) ------------------

  void onRefresh() {
    asyancLoadAllData().then((_) {
      state.refreshController.refreshCompleted(
        resetFooterState: true,
      );
    }).catchError((_) {
      state.refreshController.refreshFailed();
    });
  }

  //* ------------------ Pull to Refresh (onLoading) ------------------\

  void onLoading() {
    asyancLoadAllData().then((_) {
      state.refreshController.loadComplete();
    }).catchError((_) {
      state.refreshController.loadFailed();
    });
  }

  //* ------------------ Load All Messages Conversation Data ------------------

  asyancLoadAllData() async {
    var fromMessage = await messageRF
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: state.token)
        .get();
    print("from messges");
    var toMessage = await messageRF
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('to_uid', isEqualTo: state.token)
        .get();
    print("To messges");
    state.msgList.clear();
    if (fromMessage.docs.isNotEmpty) {
      state.msgList.assignAll(fromMessage.docs);
    }
    if (toMessage.docs.isNotEmpty) {
      state.msgList.assignAll(toMessage.docs);
    }
  }
}
