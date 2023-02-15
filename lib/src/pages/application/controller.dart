import 'package:chat_app/src/common/utils/my_flutter_app_icons.dart';
import 'package:chat_app/src/pages/application/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitels;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  @override
  void onInit() {
    super.onInit();
    tabTitels = [
      'Chat',
      'Contacts',
    ];
    bottomTabs = [
      BottomNavigationBarItem(
        icon: const Icon(
          MyFlutterApp.chat1,
        ),
        label: tabTitels[0],
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          MyFlutterApp.contactbook,
        ),
        label: tabTitels[1],
      ),
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  handlePageChanged(int index) {
    state.page = index;
  }

  handleNavBarTab(int index) {
    pageController.jumpToPage(index);
  }
}
