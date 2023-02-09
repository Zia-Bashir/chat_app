import 'package:chat_app/src/common/widgets/app_bar.dart';
import 'package:chat_app/src/pages/contacts/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/contact_list.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: buildAppBar(style),
      body: const ContactList(),
    );
  }
}

//* App Bar
AppBar buildAppBar(TextTheme style) {
  return transparentAppBar(
      title: Text(
    "Contacts",
    style: style.headline4?.copyWith(color: Colors.white),
  ));
}
