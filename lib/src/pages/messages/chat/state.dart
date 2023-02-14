import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatState {
  RxList<Msgcontent> msgContentList = <Msgcontent>[].obs;
  var toUid = ''.obs;
  var toName = ''.obs;
  var toAvatar = ''.obs;
  var toLocation = 'unknown'.obs;
  var docId = '';

  final textController = TextEditingController();
  final scrollController = ScrollController();
  FocusNode contentFocus = FocusNode();
  final userID = UserStore.to.token;

  var listner;

  ImagePicker picker = ImagePicker();
  var emojiShowing = false.obs;
}
