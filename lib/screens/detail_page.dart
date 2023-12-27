import 'package:flutter/material.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';

class TodoDetailsPage extends StatefulWidget {
  final Todos? todoData;
  const TodoDetailsPage({super.key, required this.todoData});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Todo Details",
          style: MyTextStyle.semiBold(fontSize: 17),
        ),
        actions: const [
          Icon(
            Icons.edit,
            size: 18,
            color: appPrimary,
          )
        ],
      ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
