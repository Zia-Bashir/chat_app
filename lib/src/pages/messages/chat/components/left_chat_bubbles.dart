import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget leftChatBubble(BuildContext context, Msgcontent item) {
  var style = Theme.of(context).textTheme;

  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 10.h,
      horizontal: 10.w,
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.h),
        child: Container(
          margin: EdgeInsets.only(right: 10.w),
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 10.w,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.greenColor),
          child: item.type == "text"
              ? Text(
                  item.content!,
                  style: style.subtitle2?.copyWith(color: AppColors.darkColor),
                )
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 90.h,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: CachedNetworkImage(imageUrl: item.content!),
                  ),
                ),
        ),
      ),
    ]),
  );
}