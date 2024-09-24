import 'package:appixoadmin/src/screen/auth/login.dart';
import 'package:appixoadmin/src/screen/home/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../route_name/route_name.dart';

class AppRoutes{

  static appRoutes() =>[

    GetPage(
        name: RoutesName.home,
        page: () => Home(),
        transitionDuration: const Duration(milliseconds: 250),
        transition: Transition.leftToRightWithFade),

    GetPage(
        name: RoutesName.login,
        page: () => LoginScreen(),
        transitionDuration: const Duration(milliseconds: 250),
        transition: Transition.leftToRightWithFade),

  ];
}