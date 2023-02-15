import 'package:chat_app/src/pages/messages/components/message_list_items.dart';
import 'package:chat_app/src/pages/messages/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    //* ------------------ Pull to Refresh ------------------

    return Obx(
      () => SmartRefresher(
        controller: controller.state.refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onLoading: controller.onLoading,
        onRefresh: controller.onRefresh,
        header: const WaterDropHeader(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.msgList[index];
                    //* ------------------ Message List Items ------------------

                    return messageListItems(item, context);
                  },
                  childCount: controller.state.msgList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
