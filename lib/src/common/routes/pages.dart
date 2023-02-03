import 'package:chat_app/src/common/routes/names.dart';
import 'package:get/get.dart';

import '../../pages/splash/index.dart';

class AppPages {
  static List<GetPage> routes = [
    //= -- Initial Route
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}
