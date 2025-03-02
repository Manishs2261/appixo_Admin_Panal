

import 'package:ad/src/data/repository/auth.dart';
import 'package:ad/src/screen/auth/login.dart';
import 'package:ad/src/screen/home/home.dart';
import 'package:ad/web_flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseConfig.currentPlatform);

  // Check if token exists
  bool isLoggedIn = await AuthClass.isUserLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        brightness: Brightness.light,  // or Brightness.dark
      ),
      home: isLoggedIn ? Home() : LoginScreen(),
    );
  }
}
