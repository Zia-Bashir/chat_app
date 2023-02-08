import 'package:get/get.dart';

import '../../pages/contacts/index.dart';
import './names.dart';
import '../../pages/splash/index.dart';
import '../../pages/signin/index.dart';
import '../../pages/application/index.dart';

class AppPages {
  static List<GetPage> routes = [
    //= -- Initial Route
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    //= -- SignIn Route
    GetPage(
      name: AppRoutes.SIGNIN,
      page: () => const SignINBindingScreen(),
      binding: SignINBinding(),
    ),
    //= -- Application Route
    GetPage(
      name: AppRoutes.APPLICATION,
      page: () => const ApplicationScreen(),
      binding: ApplicationBinding(),
    ),
    //= -- Application Route
    GetPage(
      name: AppRoutes.CONTACTS,
      page: () => const ContactScreen(),
      binding: ContactBinding(),
    ),
  ];
}
