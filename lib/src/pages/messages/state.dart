// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/store/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageState {
  RxList<QueryDocumentSnapshot<Msg>> msgList =
      <QueryDocumentSnapshot<Msg>>[].obs;
  final token = UserStore.to.token;
  final fromImage = UserStore.to.profile;
  RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );
  var listner;
}
