import 'package:chat_app/src/common/routes/names.dart';
import 'package:get/get.dart';

import '../../pages/splash/index.dart';
import '../../pages/signin/index.dart';

class AppPages {
  static List<GetPage> routes = [
    //= -- Initial Route
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
        name: AppRoutes.SIGNIN,
        page: () => const SignINBindingScreen(),
        binding: SignINBinding(),
        transition: Transition.leftToRightWithFade),
  ];
}
