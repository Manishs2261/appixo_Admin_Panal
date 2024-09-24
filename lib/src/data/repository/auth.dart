import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/logger/logger.dart';

class AuthClass{
  static FirebaseAuth auth = FirebaseAuth.instance;


 static Future<void> saveLoginToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }



 static Future<String?> getLoginToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }



  // Check if the user is logged in (token exists)
  static  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    return token != null; // If token exists, return true, otherwise false
  }


  // Clear the login token on logout
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }




  static Future<bool> loginEmailAndPassword(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      AuthClass.saveLoginToken("sjfnskkdsjfsnkfjankjafkf#!@%fs54656a" + email);

      if( credential.user!.emailVerified)
      {
        return true;
      }else{
        Get.snackbar("Email Not Verified", "The email has not been verified..");
      }

      AppLoggerHelper.info("${credential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("NO User found", "User are not registered.");

        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar("InValid", "password");

        return false;
      } else {
        Get.snackbar("Invalid", "Email id and password");
        AppLoggerHelper.info(e.code);
        return false;
      }
    }

    return false;
  }
}