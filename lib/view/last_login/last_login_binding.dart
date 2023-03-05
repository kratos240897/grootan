import 'package:get/get.dart';
import 'last_login_controller.dart';

class LastLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LastLoginController(), fenix: true);
  }
}
