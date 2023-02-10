import 'package:chat_app/src/pages/messages/chat/components/left_chat_bubbles.dart';
import 'package:chat_app/src/pages/messages/chat/components/right_chat_bubbles.dart';
import 'package:chat_app/src/pages/messages/chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          reverse: true,
          controller: controller.state.scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(bottom: 60.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.msgContentList[index];
                    if (controller.state.userID == item.uid) {
                      return rightChatBubble(context, item);
                    }
                    return leftChatBubble(context, item);
                  },
                  childCount: controller.state.msgContentList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
