import 'package:chat_app/src/common/utils/utils_index.dart';
import 'package:chat_app/src/pages/signin/index.dart';
import 'package:flutter/animation.dart';

class ProfileModel {
  final String title;
  final String? subtitle;
  final String imgUrl;
  final VoidCallback? onTap;
  ProfileModel(
      {required this.title, this.subtitle, required this.imgUrl, this.onTap});
}

SignInController signController = SignInController();

List<ProfileModel> profileModel = [
  ProfileModel(title: "Account", imgUrl: icon1),
  ProfileModel(title: "Chat", imgUrl: icon2),
  ProfileModel(title: "Notification", imgUrl: icon3),
  ProfileModel(title: "Privacy", imgUrl: icon4),
  ProfileModel(title: "Help", imgUrl: icon5),
  ProfileModel(title: "About", imgUrl: icon6),
  ProfileModel(
    title: "Logout",
    imgUrl: icon7,
    onTap: () {
      print('signout ----- ');

      signController.signOut();
    },
  ),
];
