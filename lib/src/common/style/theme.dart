import 'package:chat_app/src/common/style/elevated_button_theme.dart';
import 'package:chat_app/src/common/style/text_theme.dart';
import 'package:flutter/material.dart';

class MyTheme {
  MyTheme._();
  //= Light Theme
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,

      //* -- Text Theme
      textTheme: AppTextTheme.lightTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme);
  //= Dark Theme
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,

      //* -- Text Theme
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme);
}
