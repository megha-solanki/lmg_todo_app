import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/custom_button.dart';

import '../enum_data.dart';
import '../main.dart';
import '../utils/colors_const.dart';
import '../widgets/custom_textformfield.dart';

class AddEditBottomSheet extends StatefulWidget {
  const AddEditBottomSheet({super.key});

  @override
  State<AddEditBottomSheet> createState() => _AddEditBottomSheetState();
}

class _AddEditBottomSheetState extends State<AddEditBottomSheet> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  final TimerController timerController = Get.put(TimerController());

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          DesignConst.gap15,
          Text(
            "Add Todo",
            style: MyTextStyle.semiBold(fontSize: 17),
          ),
          DesignConst.gap15,
          CustomTextFormField(
              label: "Title",
              hintText: "Enter title",
              controller: txtTitle,
              keyboardType: TextInputType.text),
          DesignConst.gap15,
          CustomTextFormField(
              label: "Description",
              hintText: "Enter description",
              controller: txtDescription,
              keyboardType: TextInputType.text),
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
                    label: "Save",
                    isLoading: false,
                    onPressed: () async {
                      await todoBox
                          .add(Todos(
                        title: txtTitle.text,
                        descriptions: txtDescription.text,
                        status: "${timerController.timerStatus}",
                      ))
                          .then((value) {
                        Navigator.pop(context);
                        log("key -> $value");
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
