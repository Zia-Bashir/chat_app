import 'package:chat_app/src/common/routes/names.dart';
import 'package:chat_app/src/pages/splash/state.dart';
import 'package:get/get.dart';

import '../../common/services/storage.dart';
import '../../common/values/values.dart';

class SplashController extends GetxController {
  final state = SplashState();
  SplashController();

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    state.animate.value = true;

    state.logIn = StorageServices.to.getBool(LOGIN_STATE);

    Future.delayed(
      const Duration(seconds: 3),
      (() {
        if (state.logIn == true) {
          Get.offAllNamed(AppRoutes.APPLICATION);
        } else {
          Get.offAllNamed(AppRoutes.SIGNIN);
        }
      }),
    );
  }
}
