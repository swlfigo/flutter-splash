import 'package:get/instance_manager.dart';
import 'package:splash/module/main_module/Controller/main_module_controller.dart';
import 'package:splash/module/user/Controller/user_controller.dart';
import 'package:splash/module/user/Service/user_service.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    print("Binding Dependencies");
    Get.put<UserService>(UserService());
    Get.lazyPut<MainModuleTopicController>(() => MainModuleTopicController());
  }
}
