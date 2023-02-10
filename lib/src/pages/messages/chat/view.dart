import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:chat_app/src/common/utils/app_sizes.dart';
import 'package:chat_app/src/common/widgets/textfiled_widget.dart';
import 'package:chat_app/src/pages/messages/chat/components/build_app_bar.dart';
import 'package:chat_app/src/pages/messages/chat/components/chat_list.dart';
import 'package:chat_app/src/pages/messages/chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: buildAppBar(style, controller),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              const ChatList(),
              Positioned(
                bottom: 0.h,
                child: Container(
                  height: 52.h,
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //* ------ Emoji Icon ------
                      Container(
                        height: 42.h,
                        width: 42.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.emoji_emotions_rounded,
                            color: AppColors.yellowColor,
                            size: 25.r,
                          ),
                        ),
                      ),
                      TextFieldWidget(
                          controller: controller.state.textController,
                          icon: Icons.attach_file,
                          hintText: "Type your message"),

                      //* ------ Send Message Button ------
                      GestureDetector(
                        onTap: () {
                          controller.sendMessage();
                        },
                        child: Container(
                          height: 42.h,
                          width: 42.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: AppColors.yellowColor,
                              size: 25.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
