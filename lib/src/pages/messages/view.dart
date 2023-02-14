import 'package:chat_app/src/common/widgets/app_bar.dart';
import 'package:chat_app/src/pages/messages/components/message_list.dart';
import 'package:chat_app/src/pages/messages/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(title: const Text("Messages")),
      body: const MessageList(),
    );
  }
}
