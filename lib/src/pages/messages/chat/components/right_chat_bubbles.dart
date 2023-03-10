import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/routes/names.dart';
import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:chat_app/src/common/utils/date.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget rightChatBubble(BuildContext context, Msgcontent item) {
  var style = Theme.of(context).textTheme;

  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 10.h,
      horizontal: 10.w,
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: item.type == "text"
                  ? EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 10.w,
                    )
                  : EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 5.w,
                    ),
              decoration: item.type == "text"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.yellowColor)
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.yellowColor),
              child: item.type == "text"
                  ? Text(
                      item.content!,
                      style:
                          style.subtitle2?.copyWith(color: AppColors.darkColor),
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 90.h,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.PHOTOVIEW, parameters: {
                            'url': item.content ?? '',
                          });
                        },
                        child: CachedNetworkImage(
                          imageUrl: item.content!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 150.h,
                            padding: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w, top: 3.h),
              child: Text(
                getTime((item.addtime as Timestamp).toDate()),
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: style.subtitle2
                    ?.copyWith(fontSize: 10.sp, color: AppColors.darkColor),
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}
