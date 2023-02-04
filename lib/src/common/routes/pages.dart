import 'package:chat_app/src/common/routes/names.dart';
import 'package:get/get.dart';

import '../../pages/splash/index.dart';
import '../../pages/welcome/index.dart';

class AppPages {
  static List<GetPage> routes = [
    //= -- Initial Route
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
        name: AppRoutes.WELCOME,
        page: () => const WelcomeScreen(),
        binding: WelcomeBinding(),
        transition: Transition.leftToRightWithFade),
  ];
}
