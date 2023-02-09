import 'package:chat_app/src/common/utils/utils_index.dart';
import 'package:chat_app/src/common/widgets/my_elevated_button_widget.dart';
import 'package:chat_app/src/common/widgets/mytext_widget.dart';
import 'package:chat_app/src/pages/signin/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class SignINBindingScreen extends GetView<SignInController> {
  const SignINBindingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          //* ------- Background Image -------
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),

            //* ------- Animation Limiter -------
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //? ------- Animation 1 -------
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(seconds: 3),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            delay: const Duration(seconds: 3),
                            child: FadeInAnimation(
                              duration: const Duration(seconds: 2),
                              child: widget,
                            ),
                          ),
                      children: [
                        //* ------- Title And Chat Image -------
                        Column(
                          children: [
                            MyTextWidget(title: tTitle, style: style.headline1),
                            SizedBox(
                              width: screenWidth,
                              child: Image.asset(chatImage),
                            ),
                          ],
                        ),
                      ]),
                ),

                //* ------- Continue with Google Container -------
                Column(
                  //? ------- Animation 2 -------
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(seconds: 3),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50.0,
                            delay: const Duration(seconds: 3),
                            child: FadeInAnimation(
                              duration: const Duration(seconds: 2),
                              child: widget,
                            ),
                          ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                                horizontal: 30.w,
                              ),
                              width: screenWidth,
                              height: 270.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50.r)),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      MyTextWidget(
                                        title: tWelcomeTitle,
                                        style: style.headline3?.copyWith(
                                            color: AppColors.mainColor),
                                        line: 4,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      MyTextWidget(
                                        title: tWelcomeSubtitle,
                                        style: style.subtitle2?.copyWith(
                                            color: AppColors.darkColor),
                                        line: 4,
                                      ),
                                    ],
                                  ),

                                  //* ------- Elevated Button -------
                                  Column(
                                    children: [
                                      MyElevatedButtonWidget(
                                          text: "Continue with Google",
                                          ontap: () {
                                            controller.handleGoogleSignIn();
                                          }),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //* ------- Terms & Condition Text -------
                                      Column(
                                        children: [
                                          MyTextWidget(
                                              title: tWelcomeTerms1,
                                              style: style.subtitle2),
                                          MyTextWidget(
                                              title: tWelcomeTerms2,
                                              style: style.bodyText1),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
