import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/enum_data.dart';
import 'package:lmg_todo_app/screens/add_edit_bottomsheet.dart';
import 'package:lmg_todo_app/screens/detail_page.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/image_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TimerController timerController =Get.put(TimerController());
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

  ValueListenableBuilder<Box<Todos>> getNotListView() {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Todos>("todos").listenable(),
        builder: (context, Box<Todos> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No Todos"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 80),
              itemCount: box.values.length,
              itemBuilder: (BuildContext context, int index) {
                Todos? result = box.getAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoDetailsPage(
                            todoData: result,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: grey100, width: 0.75)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              color: appPrimary.withOpacity(0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 6),
                                    decoration: BoxDecoration(
                                      // color: green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Obx((){
                                      return  Text("${statusNames[timerController.timerStatus.value]}");
                                    }),
                                  ),
                                   Obx(
                                        () => Text(
                                      timerController.formattedTime(),
                                      style: MyTextStyle.semiBold(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: grey100,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${result?.title}",
                                        style:
                                            MyTextStyle.semiBold(fontSize: 15),
                                      ),
                                      DesignConst.gap8,
                                      Text(
                                        "${result?.descriptions}",
                                        style: MyTextStyle.regular(
                                            fontSize: 13.5, color: grey600),
                                      ),
                                    ],
                                  ),
                                ),
                                DesignConst.gap14,
                                InkWell(
                                  onTap: () {
                                    box.deleteAt(index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: red.withOpacity(0.1),
                                    ),
                                    child: Image.asset(
                                      ImageConst.delete,
                                      width: 17,
                                      height: 17,
                                      color: red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
