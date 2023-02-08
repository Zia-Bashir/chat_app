import 'package:chat_app/src/common/routes/routes.dart';
import 'package:chat_app/src/common/store/store.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.SIGNIN ||
        route == AppRoutes.INITIAL) {
      return null;
    } else {
      Future.delayed(const Duration(seconds: 1),
          () => Get.snackbar("Expired", "Login expired, please log in again"));
      return const RouteSettings(name: AppRoutes.SIGNIN);
    }
  }
}
