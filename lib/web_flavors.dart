import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get currentPlatform {
    const String environment = String.fromEnvironment('ENV', defaultValue: 'dev');

    switch (environment) {
      case 'prod':
        return const FirebaseOptions(
            apiKey: "AIzaSyDLHX6XJrSU_ulc5YWwMPDje-wq2c8T0SQ",
            authDomain: "appixo.firebaseapp.com",
            projectId: "appixo",
            storageBucket: "appixo.appspot.com",
            messagingSenderId: "1012069754938",
            appId: "1:1012069754938:web:55d9d6e0711159538bad03",
            measurementId: "G-DWWVEHEWZ1"
        );
      case 'uat':
        return const FirebaseOptions(
          apiKey: "AUT_API_KEY",
          authDomain: "AUT_AUTH_DOMAIN",
          projectId: "AUT_PROJECT_ID",
          storageBucket: "AUT_STORAGE_BUCKET",
          messagingSenderId: "AUT_MESSAGING_SENDER_ID",
          appId: "AUT_APP_ID",
        );
      default:
        return const FirebaseOptions(
            apiKey: "AIzaSyBgkjn0-b1FfOVn1mdr8EpiRVk0ZeSLPTY",
            authDomain: "appixo-dev.firebaseapp.com",
            projectId: "appixo-dev",
            storageBucket: "appixo-dev.firebasestorage.app",
            messagingSenderId: "556483651228",
            appId: "1:556483651228:web:4fdd17df9df4ebd2aaaf59",
            measurementId: "G-MNWV37WQR7"
        );
    }
  }
}
