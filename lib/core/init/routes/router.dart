import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view/last_login/last_login.dart';
import '../../../view/last_login/last_login_binding.dart';
import '../../../view/login/login.dart';
import '../../../view/login/login_binding.dart';
import '../../../view/plugin/plugin.dart';
import '../../../view/plugin/plugin_binding.dart';
import 'routes.dart';

class PageRouter {
  static Route? generateRoutes(RouteSettings settings) {
    //final args = settings.arguments;
    switch (settings.name) {
      case Routes.LOGIN:
        return GetPageRoute(
            routeName: Routes.LOGIN,
            page: () => Login(),
            binding: LoginBinding());
      case Routes.PLUGIN:
        return GetPageRoute(
            routeName: Routes.PLUGIN,
            page: () =>  Plugin(),
            binding: PluginBinding());
      case Routes.LAST_LOGIN:
        return GetPageRoute(
            routeName: Routes.LAST_LOGIN,
            page: () => const LastLogin(),
            binding: LastLoginBinding());
    }
    return null;
  }
}
