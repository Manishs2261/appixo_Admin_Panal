  import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../screen/auth/login.dart';
import '../../screen/home/home.dart';
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