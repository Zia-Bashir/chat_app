import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/src/common/entities/entities.dart';
import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:chat_app/src/common/utils/app_images.dart';
import 'package:chat_app/src/common/utils/date.dart';
import 'package:chat_app/src/pages/messages/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/routes/names.dart';

Widget messageListItems(QueryDocumentSnapshot<Msg> item, context) {
  MessageController controller = MessageController();
  var style = Theme.of(context).textTheme;
  return Container(
    padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
    child: InkWell(
      onTap: () {
        var toUid = '';
        var toNmae = '';
        var toAvatar = '';

        //* ------------------ Getting Data ------------------

        if (item.data().from_uid == controller.state.token) {
          toUid = item.data().to_uid ?? '';
          toNmae = item.data().to_name ?? '';
          toAvatar = item.data().to_avatar ?? '';
        } else {
          toUid = item.data().from_uid ?? '';
          toNmae = item.data().from_name ?? '';
          toAvatar = item.data().from_avatar ?? '';
        }

        //* ------------------ Sending Data to Parameters ------------------

        Get.toNamed(AppRoutes.CHAT, parameters: {
          'doc_id': item.id,
          'to_uid': toUid,
          'to_name': toNmae,
          'to_avatar': toAvatar,
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10.w),
            child: SizedBox(
              height: 54.w,
              width: 54.w,

              //* ------------------ Network Image ------------------

              child: CachedNetworkImage(
                imageUrl: item.data().from_uid == controller.state.token
                    ? item.data().to_avatar!
                    : item.data().from_avatar!,
                imageBuilder: (context, imageProvider) => Container(
                  height: 54.w,
                  width: 54.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 54.w,
                  width: 54.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(noImage), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 5.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xffe5e5e5),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200.w,
                  height: 54.h,
                  padding: EdgeInsets.only(right: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //* ------------------ to_User Name ------------------

                      Text(
                        item.data().to_name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: style.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor),
                      ),

                      //* ------------------ Last Message ------------------

                      Text(
                        item.data().last_msg ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: style.subtitle2?.copyWith(
                            fontSize: 12.sp, color: AppColors.mainColor),
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                ),

                //= ------------------ Time  ------------------

                Text(
                  duTimeLineFormat(
                      (item.data().last_time as Timestamp).toDate()),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: style.subtitle2
                      ?.copyWith(fontSize: 12.sp, color: AppColors.darkColor),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
