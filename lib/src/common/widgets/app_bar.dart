import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.mainColor,
          AppColors.skyColor,
          AppColors.greenColor,
          //AppColors.yellowColor,
        ], transform: GradientRotation(90)),
      ),
    ),
    title: title != null ? Center(child: title) : null,
    leading: leading,
    actions: actions,
  );
}

Widget divider({
  Color bgColor = AppColors.mainColor,
}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}
