import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/main.dart';
import 'package:lmg_todo_app/screens/add_edit_bottomsheet.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/custom_button.dart';

import '../controller/todo_controller.dart';
import 'home_page/todo_component.dart';

class TodoDetailsPage extends StatefulWidget {
  final int index;
  final TodoComponentState componentState;

  const TodoDetailsPage({
    super.key,
    required this.index,
    required this.componentState,
  });

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final todoData = todoController.todoList[widget.index];
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Todo Details",
            style: MyTextStyle.semiBold(fontSize: 17),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: InkWell(
                onTap: () {
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
                      return AddEditBottomSheet(
                        isEdited: true,
                        todoData: todoData,
                      );
                    },
                  );
                },
                child: Text(
                  "Edit",
                  style: MyTextStyle.medium(color: appPrimary, fontSize: 15),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title :",
                  style: MyTextStyle.medium(fontSize: 14, color: grey600),
                ),
                DesignConst.gap4,
                Text(
                  "${todoData.title}",
                  style: MyTextStyle.semiBold(fontSize: 15.5),
                ),
                DesignConst.gap15,
                Text(
                  "Description :",
                  style: MyTextStyle.medium(fontSize: 14, color: grey600),
                ),
                DesignConst.gap4,
                Text(
                  "${todoData.descriptions}",
                  style: MyTextStyle.medium(fontSize: 14, color: black),
                ),
                DesignConst.gap15,
                Text(
                  "Status :",
                  style: MyTextStyle.medium(fontSize: 14, color: grey600),
                ),
                DesignConst.gap4,
                Text(
                  "TODO",
                  style: MyTextStyle.medium(fontSize: 14, color: black),
                ),
                DesignConst.gap15,
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.7, color: grey100),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => Text(
                          widget.componentState.formattedTime(),
                          style: MyTextStyle.semiBold(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                DesignConst.gap15,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        bgColor: green,
                        height: 40,
                        txtColor: white,
                        label: "Play",
                        isLoading: false,
                        onPressed: () {
                          todoController.addEditTodo(todoData.key, todoData);
                          widget.componentState.startTimer();
                        },
                      ),
                    ),
                    DesignConst.gap10,
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        label: "Pause",
                        isLoading: false,
                        onPressed: () {
                          widget.componentState.pauseTimer();
                        },
                      ),
                    ),
                    DesignConst.gap10,
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        bgColor: red,
                        label: "Stop",
                        isLoading: false,
                        onPressed: () {
                          widget.componentState.stopTimer();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
