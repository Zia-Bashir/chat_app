import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/firebase/firebase_reference.dart';
import 'package:chat_app/src/pages/messages/chat/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();

  @override
  void onInit() {
    //* ---- Getting Parameter ------
    var data = Get.parameters;
    state.docId = data['doc_id']!;
    state.toUid.value = data['to_uid'] ?? '';
    state.toName.value = data['to_name'] ?? '';
    state.toAvatar.value = data['to_avatar'] ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    litenEvent();
    super.onReady();
  }

  //* ---- Send Message ------
  sendMessage() async {
    String sendContent = state.textController.text;

    //* ---- Message Content ------
    var content = Msgcontent(
      content: sendContent,
      type: 'text',
      addtime: Timestamp.now(),
      uid: state.userID,
    );

    //* ---- Add Message to Firestore Collection ------
    await messageRF
        .doc(state.docId)
        .collection("msgList")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, optoons) => msg.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      print("Message added into : ${doc.id}");
      state.textController.clear();
      Get.focusScope?.unfocus();
    });

    //* ---- Update the Last Message and Time ------
    await messageRF
        .doc(state.docId)
        .update({"last_msg": sendContent, 'last_time': Timestamp.now()});
  }

  //* ---- Listen Message Event ------
  litenEvent() {
    var message = messageRF
        .doc(state.docId)
        .collection("msgList")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, optoons) => msg.toFirestore())
        .orderBy("addtime", descending: true);
    state.msgContentList.clear();
    state.listner = message.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.msgContentList.insert(0, change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
              break;
            case DocumentChangeType.removed:
              break;
            default:
          }
        }
      },
      onError: (error) => print("Listen Failed: $error"),
    );
  }
}
