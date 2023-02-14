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
          Icons.message,
        ),
        label: tabTitels[0],
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.contact_page,
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
