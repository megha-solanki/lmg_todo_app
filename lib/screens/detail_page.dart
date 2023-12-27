import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/custom_button.dart';

import '../enum_data.dart';

class TodoDetailsPage extends StatefulWidget {
  final Todos? todoData;

  const TodoDetailsPage({super.key, required this.todoData});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              "Edit",
              style: MyTextStyle.medium(color: appPrimary, fontSize: 15),
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
                "${widget.todoData!.title}",
                style: MyTextStyle.semiBold(fontSize: 15.5),
              ),
              DesignConst.gap15,
              Text(
                "Description :",
                style: MyTextStyle.medium(fontSize: 14, color: grey600),
              ),
              DesignConst.gap4,
              Text(
                "${widget.todoData!.descriptions}",
                style: MyTextStyle.medium(fontSize: 14, color: black),
              ),
              DesignConst.gap15,
              Text(
                "Status :",
                style: MyTextStyle.medium(fontSize: 14, color: grey600),
              ),
              DesignConst.gap4,
              Obx(
                () => Text(
                  "${statusNames[timerController.timerStatus.value]}",
                  style: MyTextStyle.medium(fontSize: 14, color: black),
                ),
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
                          timerController.formattedTime(),
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
                        timerController.startTimer();
                        /* if (timerStatus == TimerStatus.todo) {
        
                        }*/
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
                        timerController.pauseTimer();
                        /* if (timerStatus == TimerStatus.inProgress) {
                          pauseTimer();
                        }*/
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
                        timerController.stopTimer();
                        /*if (timerStatus == TimerStatus.inProgress) {
        
                        }*/
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
  }
}
