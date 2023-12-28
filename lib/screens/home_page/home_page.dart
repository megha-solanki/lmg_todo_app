import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lmg_todo_app/controller/todo_controller.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/main.dart';
import 'package:lmg_todo_app/screens/add_edit_bottomsheet.dart';
import 'package:lmg_todo_app/screens/home_page/todo_component.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TODOS",
          style: MyTextStyle.semiBold(fontSize: 17),
        ),
      ),
      body: getNotListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return const AddEditBottomSheet();
            },
          );
        },
        elevation: 0,
        backgroundColor: appPrimary,
        tooltip: "Add Todo",
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget getNotListView() {
    return Obx(() {
      final todoListData = todoController.todoList;
      return ListView.builder(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 80),
        itemCount: todoListData.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoComponent(
            todos: todoListData[index],
            index: index,
            onDelete: () {
              todoController.deleteTodo(index);
            },
          );
        },
      );
    });
  }
}
