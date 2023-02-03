import 'package:chat_app/src/pages/home/view.dart';
import 'package:chat_app/src/pages/splash/state.dart';
import 'package:get/get.dart';

import '../../common/services/storage_services.dart';
import '../../common/utils/storage.dart';

class SplashController extends GetxController {
  final state = SplashState();

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    state.animate.value = true;

    state.logIn = StorageServices.to.getBool(LOGIN_STATE);

    Future.delayed(const Duration(seconds: 5), (() {
      if (state.logIn == true) {
        //Get.offAllNamed("/home");
        Get.to(() => const HomeScreen());
      } else {
        //Get.offAllNamed("/login");
        Get.to(() => const HomeScreen());
      }
    }));
  }
}
