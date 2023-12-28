import 'package:get/get.dart';
import 'package:lmg_todo_app/controller/todo_controller.dart';

class InitializeControllers implements Bindings {
  @override
  void dependencies() {
    initializeControllers();
  }
}

initializeControllers() {
  Get.put(TodoController(), permanent: true);
}
