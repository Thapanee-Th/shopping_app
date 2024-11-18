import 'package:get/get.dart';
import 'package:shopping_app/src/app/home/controller/home_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
