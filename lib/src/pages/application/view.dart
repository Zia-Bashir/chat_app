import 'package:chat_app/src/common/utils/app_colors.dart';
import 'package:chat_app/src/pages/application/index.dart';
import 'package:chat_app/src/pages/contacts/index.dart';
import 'package:chat_app/src/pages/messages/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationScreen extends GetView<ApplicationController> {
  const ApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: [
          const MessageScreen(),
          const ContactScreen(),
          Container(
            child: const Text("Setting"),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.grey.shade500,
          onTap: controller.handleNavBarTab,
        ),
      ),
    );
  }
}
