import 'package:get/instance_manager.dart';
import 'package:splash/module/main_module/Controller/main_module_controller.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    print("Binding Dependencies");
    Get.lazyPut<MainModuleTopicController>(() => MainModuleTopicController());
  }
}
