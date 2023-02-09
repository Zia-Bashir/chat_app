import 'package:chat_app/src/pages/chat/components/build_app_bar.dart';
import 'package:chat_app/src/pages/chat/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: buildAppBar(style, controller),
    );
  }
}
