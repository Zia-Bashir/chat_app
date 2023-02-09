import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/src/common/entities/user.dart';
import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:chat_app/src/pages/contacts/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var item = controller.state.contactList[index];
                  return buildList(item, style);
                },
                childCount: controller.state.contactList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(UserData item, TextTheme style) {
    return Container(
      padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 15.h),
      child: InkWell(
        onTap: () {
          if (item.id != null) {
            print("--------------Id is not null");
            controller.gochat(item);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 54.h,
              width: 54.w,
              child: CachedNetworkImage(imageUrl: item.photourl!),
            ),
            Container(
              width: 250.w,
              padding: EdgeInsets.only(top: 15.h, left: 20.w),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 215, 215, 215),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 42.h,
                    width: 200.w,
                    child: Text(item.name ?? '',
                        style: style.subtitle1
                            ?.copyWith(color: AppColors.mainColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
