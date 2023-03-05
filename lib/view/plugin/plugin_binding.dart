import 'package:get/get.dart';
import 'plugin_controller.dart';

class PluginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PluginController(), fenix: true);
  }
}
