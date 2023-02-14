import 'package:chat_app/src/common/entities/profile.dart';
import 'package:chat_app/src/common/utils/utils_index.dart';
import 'package:chat_app/src/pages/profile/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.darkColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.darkColor,
                      backgroundImage: NetworkImage(
                          controller.state.userProfile.photoUrl ??
                              networkProfile),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40.w,
                        width: 40.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.mainColor),
                        child: const Center(
                          child: Icon(
                            Icons.image_aspect_ratio,
                            size: 20,
                            color: AppColors.yellowColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  controller.state.userProfile.displayName ?? '',
                  style: style.headline2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      width: 15.h,
                    ),
                    Text(
                      'Active',
                      style: style.subtitle2
                          ?.copyWith(color: AppColors.darkColor, fontSize: 18),
                    ),
                    SizedBox(
                      width: 20.h,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.darkColor,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: profileModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: GestureDetector(
                    onTap: profileModel[index].onTap,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.darkColor,
                        backgroundImage: AssetImage(profileModel[index].imgUrl),
                      ),
                      title: Text(
                        profileModel[index].title,
                        style: style.subtitle1
                            ?.copyWith(color: AppColors.darkColor),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.darkColor,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
