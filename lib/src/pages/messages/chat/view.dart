import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:chat_app/src/common/utils/app_images.dart';
import 'package:chat_app/src/common/utils/app_sizes.dart';
import 'package:chat_app/src/common/widgets/textfiled_widget.dart';
import 'package:chat_app/src/pages/messages/chat/components/build_app_bar.dart';
import 'package:chat_app/src/pages/messages/chat/components/chat_list.dart';
import 'package:chat_app/src/pages/messages/chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
              //* ------ Emoji Icon ------
              // Offstage(
              //   offstage: !controller.state.emojiShowing.value,
              //   child: SizedBox(
              //     height: 250,
              //     child: EmojiPicker(
              //       textEditingController: controller.state.textController,
              //       config: Config(
              //         columns: 7,
              //         // Issue: https://github.com/flutter/flutter/issues/28894
              //         emojiSizeMax: 32 *
              //             (foundation.defaultTargetPlatform ==
              //                     TargetPlatform.iOS
              //                 ? 1.30
              //                 : 1.0),
              //         verticalSpacing: 0,
              //         horizontalSpacing: 0,
              //         gridPadding: EdgeInsets.zero,
              //         initCategory: Category.RECENT,
              //         bgColor: const Color(0xFFF2F2F2),
              //         indicatorColor: Colors.blue,
              //         iconColor: Colors.grey,
              //         iconColorSelected: Colors.blue,
              //         backspaceColor: Colors.blue,
              //         skinToneDialogBgColor: Colors.white,
              //         skinToneIndicatorColor: Colors.grey,
              //         enableSkinTones: true,
              //         showRecentsTab: true,
              //         recentsLimit: 28,
              //         replaceEmojiOnLimitExceed: false,
              //         noRecents: const Text(
              //           'No Recents',
              //           style: TextStyle(fontSize: 20, color: Colors.black26),
              //           textAlign: TextAlign.center,
              //         ),
              //         loadingIndicator: const SizedBox.shrink(),
              //         tabIndicatorAnimDuration: kTabScrollDuration,
              //         categoryIcons: const CategoryIcons(),
              //         buttonMode: ButtonMode.MATERIAL,
              //         checkPlatformCompatibility: true,
              //       ),
              //     ),
              //   ),
              // ),
              Obx(
                () => Positioned(
                  bottom: 70.h,
                  right: 0,
                  left: 0,
                  child: controller.state.isUploading.value == true
                      ? Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: SizedBox(
                              height: 30.h,
                              width: 60.w,
                              child: Lottie.asset(loading,
                                  repeat: true, fit: BoxFit.cover),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
              Positioned(
                bottom: 0.h,
                child: Container(
                  height: 52.h,
                  color: const Color(0xffFAFAFA),
                  width: screenWidth,
                  padding: EdgeInsets.only(
                    right: 10.w,
                    left: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 42.h,
                        width: 42.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.state.emojiShowing.value =
                                  !controller.state.emojiShowing.value;
                            },
                            child: Icon(
                              Icons.emoji_emotions_rounded,
                              color: AppColors.yellowColor,
                              size: 25.r,
                            ),
                          ),
                        ),
                      ),
                      TextFieldWidget(
                          textcontroller: controller.state.textController,
                          icon: Icons.attach_file,
                          onPressed: () {
                            controller.pickerBottomSheet(context);
                          },
                          hintText: "Type your message"),

                      //* ------ Send Message Button ------
                      GestureDetector(
                        onTap: () {
                          if (controller.state.textController.text.isNotEmpty) {
                            controller.sendMessage();
                          }
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
