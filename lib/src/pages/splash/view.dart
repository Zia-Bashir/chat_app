import 'package:chat_app/src/common/widgets/mytext_widget.dart';
import 'package:chat_app/src/pages/splash/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/utils/utils_index.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    controller.startAnimation();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => AnimatedPositioned(
                curve: Curves.easeInOutBack,
                duration: const Duration(milliseconds: 1000),
                top: controller.state.animate.value ? 280.h : 200.h,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: controller.state.animate.value ? 1 : 0,
                  duration: const Duration(milliseconds: 800),
                  child: SvgPicture.asset(chatterLogo),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutQuart,
                left: 0,
                right: 0,
                bottom: controller.state.animate.value ? 50.h : -20.h,
                child: AnimatedOpacity(
                  opacity: controller.state.animate.value ? 1 : 0,
                  duration: const Duration(milliseconds: 1000),
                  child: MyTextWidget(
                    title: tTitle,
                    style: style.headline2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
