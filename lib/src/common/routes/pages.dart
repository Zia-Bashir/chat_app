import 'package:chat_app/src/pages/messages/index.dart';
import 'package:chat_app/src/pages/profile/index.dart';
import 'package:get/get.dart';

import '../../pages/contacts/index.dart';
import './names.dart';
import '../../pages/splash/index.dart';
import '../../pages/signin/index.dart';
import '../../pages/application/index.dart';
import '../../pages/messages/chat/index.dart';

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
    //= -- Contacts Route
    GetPage(
      name: AppRoutes.CONTACTS,
      page: () => const ContactScreen(),
      binding: ContactBinding(),
    ),
    //= -- Chat Route
    GetPage(
      name: AppRoutes.CHAT,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
    //= -- Message Route
    GetPage(
      name: AppRoutes.MESSAGE,
      page: () => const MessageScreen(),
      binding: MessageBinding(),
    ),
    //= -- Profile Route
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
