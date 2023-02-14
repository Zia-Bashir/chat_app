import 'package:chat_app/src/common/routes/names.dart';
import 'package:chat_app/src/common/utils/utils_index.dart';
import 'package:chat_app/src/pages/messages/components/message_list.dart';
import 'package:chat_app/src/pages/messages/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 24.w, left: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.PROFILE);
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.darkColor,
                          radius: 27.r,
                          backgroundImage: NetworkImage(
                              controller.state.userProfile.photoUrl ??
                                  networkProfile),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 14.w,
                            width: 14.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 165.w,
                        height: 30.h,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 10.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: const Color(0xffe5e5e5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Search",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: AppColors.darkColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Icon(
                        Icons.more_vert,
                        color: AppColors.darkColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const MessageList(),
    );
  }
}
