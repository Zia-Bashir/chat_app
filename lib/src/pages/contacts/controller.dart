import 'dart:convert';

import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/firebase/firebase_reference.dart';
import 'package:chat_app/src/common/store/store.dart';
import 'package:chat_app/src/pages/contacts/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final state = ContactState();
  ContactController();

  final token = UserStore.to.token;

  @override
  void onReady() {
    loadAllContacts();
    super.onReady();
  }

  loadAllContacts() async {
    var usersBase = await userRF
        .where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userData, options) => userData.toFirestore())
        .get();

    for (var doc in usersBase.docs) {
      state.contactList.add(doc.data());
    }
  }

  gochat(UserData toUserData) async {
    var fromMessage = await messageRF
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: token)
        .where('to_uid', isEqualTo: toUserData.id)
        .get();

    var toMessage = await messageRF
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where('from_uid', isEqualTo: toUserData.id)
        .where('to_uid', isEqualTo: token)
        .get();

    if (fromMessage.docs.isEmpty && toMessage.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));

      var msgData = Msg(
        from_uid: userData.accessToken,
        to_uid: toUserData.id,
        from_name: userData.displayName,
        to_name: toUserData.name,
        to_avatar: toUserData.photourl,
        last_msg: '',
        msg_num: 0,
        last_time: Timestamp.now(),
      );

      messageRF
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (value, options) => value.toFirestore())
          .add(msgData)
          .then((value) => {
                Get.toNamed('/chat', parameters: {
                  'doc_id': value.id,
                  'to_uid': toUserData.id ?? '',
                  'to_name': toUserData.name ?? '',
                  'to_avatar': toUserData.photourl ?? '',
                })
              });
    } else {
      if (fromMessage.docs.isNotEmpty) {
        Get.toNamed('/chat', parameters: {
          'doc_id': fromMessage.docs.first.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? '',
        });
      }
      if (toMessage.docs.isNotEmpty) {
        Get.toNamed('/chat', parameters: {
          'doc_id': toMessage.docs.first.id,
          'to_uid': toUserData.id ?? '',
          'to_name': toUserData.name ?? '',
          'to_avatar': toUserData.photourl ?? '',
        });
      }
    }
  }
}
