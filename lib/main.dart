import 'package:chat_app/src/common/routes/pages.dart';
import 'package:chat_app/src/common/services/storage_services.dart';
import 'package:chat_app/src/common/style/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import './src/common/helper/dependicies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //? --- Getx Dependecy Injection ---
  dep.initState();

  //* --- Storage Services ---
  StorageServices.to.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: child,
          getPages: AppPages.routes,
        );
      },
      //child: const HomePage(title: 'First Method'),
    );
  }
}
