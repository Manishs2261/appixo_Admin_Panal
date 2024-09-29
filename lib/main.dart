import 'package:appixoadmin/src/data/repository/auth.dart';
import 'package:appixoadmin/src/screen/auth/login.dart';
import 'package:appixoadmin/src/screen/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDLHX6XJrSU_ulc5YWwMPDje-wq2c8T0SQ",
          authDomain: "appixo.firebaseapp.com",
          projectId: "appixo",
          storageBucket: "appixo.appspot.com",
          messagingSenderId: "1012069754938",
          appId: "1:1012069754938:web:55d9d6e0711159538bad03",
          measurementId: "G-DWWVEHEWZ1"));

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
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn ? Home() : LoginScreen(),
    );
  }
}
