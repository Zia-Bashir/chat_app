import 'package:chat_app/src/pages/messages/components/build_app_bar.dart';
import 'package:chat_app/src/pages/messages/components/message_list.dart';
import 'package:chat_app/src/pages/messages/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* ------------------ AppBar ------------------

      appBar: buildAppBar(context, controller),

      //* ------------------ Message List ------------------

      body: const MessageList(),
    );
  }
}
