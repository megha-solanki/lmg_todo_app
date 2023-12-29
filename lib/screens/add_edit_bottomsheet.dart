import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lmg_todo_app/controller/todo_controller.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/custom_button.dart';

import '../enum_data.dart';

import '../utils/colors_const.dart';
import '../widgets/custom_textformfield.dart';
import 'home_page/select_time_bottomsheet.dart';

class AddEditBottomSheet extends StatefulWidget {
  final bool isEdited;
  final Todos? todoData;

  const AddEditBottomSheet({super.key, this.isEdited = false, this.todoData});

  @override
  State<AddEditBottomSheet> createState() => _AddEditBottomSheetState();
}

class _AddEditBottomSheetState extends State<AddEditBottomSheet> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtTime = TextEditingController();

  final TodoController todoController = Get.put(TodoController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? selectedSecond, selectedMinute;

  @override
  void initState() {
    super.initState();
    if (widget.isEdited == true) {
      getEditedVal();
    }
  }

  getEditedVal() {
    txtTitle.text = "${widget.todoData!.title}";
    txtDescription.text = "${widget.todoData!.descriptions}";
    txtTime.text =
        "${widget.todoData!.todoMinutes}:${widget.todoData!.todoSeconds}";
    selectedMinute = int.parse("${widget.todoData!.todoMinutes}");
    selectedSecond = int.parse("${widget.todoData!.todoSeconds}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignConst.gap15,
              Text(
                widget.isEdited == true ? "Edit Todo" : "Add Todo",
                style: MyTextStyle.semiBold(fontSize: 17),
              ),
              DesignConst.gap15,
              CustomTextFormField(
                  label: "Title",
                  hintText: "Enter title",
                  controller: txtTitle,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter title";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text),
              DesignConst.gap15,
              CustomTextFormField(
                  label: "Description",
                  hintText: "Enter description",
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter description";
                    }
                    return null;
                  },
                  controller: txtDescription,
                  keyboardType: TextInputType.text),
              DesignConst.gap15,
              CustomTextFormField(
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please select time";
                  }
                  return null;
                },
                onTap: () {
                  showModalBottomSheet(
                    elevation: 1,
                    isDismissible: true,
                    shape: DesignConst.bottomSheetRadius,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => SelectTimeBottomSheet(
                      selectedSecond: selectedSecond,
                      selectedMinute: selectedMinute,
                      onSelectTime: (minute, second) {
                        setState(() {
                          selectedSecond = second;
                          selectedMinute = minute;
                          txtTime.text = "$selectedMinute:$selectedSecond";
                        });
                      },
                    ),
                  );
                },
                controller: txtTime,
                readOnly: true,
                isAbsorbing: true,
                label: "Time",
                hintText: "Select time",
                sImage: const Icon(
                  Icons.calendar_month,
                  size: 21,
                  color: grey300,
                ),
              ),
              DesignConst.gap15,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        bgColor: grey25,
                        height: 44,
                        txtColor: grey600,
                        label: "Cancel",
                        isLoading: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    DesignConst.gap10,
                    Expanded(
                      child: CustomButton(
                        height: 44,
                        label: widget.isEdited == true ? "Edit" : "Save",
                        isLoading: false,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String keyName;
                            if (widget.isEdited && widget.todoData != null) {
                              keyName = widget.todoData!.key ??
                                  DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                            } else {
                              keyName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                            }

                            todoController
                                .addEditTodo(
                              keyName,
                              Todos(
                                key: keyName,
                                title: txtTitle.text,
                                descriptions: txtDescription.text,
                                status: statusNames[TimerStatusEnum.todo],
                                todoMinutes: selectedMinute,
                                todoSeconds: selectedSecond,
                              ),
                            )
                                .then((value) {
                              Navigator.pop(context);
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
