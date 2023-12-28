import 'package:get/get.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/main.dart';

class TodoController extends GetxController {
  late RxList<Todos> todoList = <Todos>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTodo();
  }

  Future<void> getTodo() async {
    todoList.value = todoBox.values.toList();
  }

  Future<void> addEditTodo(key, Todos todData) async {
    todoBox.put(key, todData).then((value) {
      getTodo();
    });
  }

  deleteTodo(id) {
    todoBox.deleteAt(id).then((value) {
      getTodo();
    });
  }
}
