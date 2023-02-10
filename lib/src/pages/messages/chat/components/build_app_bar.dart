import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/src/common/utils/app_images.dart';
import 'package:chat_app/src/common/widgets/app_bar.dart';
import 'package:chat_app/src/pages/messages/chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//* App Bar
AppBar buildAppBar(TextTheme style, ChatController controller) {
  return transparentAppBar(
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    ),
    title: Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                width: 44.r,
                height: 44.r,
                child: CachedNetworkImage(
                  imageUrl: controller.state.toAvatar.value,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 44.r,
                    height: 44.r,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44.r),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Image(image: AssetImage(noImage)),
                ),
              ),
            ),
          ),
          Container(
            width: 180.w,
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180.w,
                  height: 44.h,
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.state.toName.value,
                            style:
                                style.subtitle1?.copyWith(color: Colors.white),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          Text(
                            "Unkown Location",
                            style:
                                style.subtitle2?.copyWith(color: Colors.white),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
