import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../database/todo.dart';
import '../../utils/colors_const.dart';
import '../../utils/design_const.dart';
import '../../utils/image_const.dart';
import '../../utils/my_textstyle.dart';
import '../detail_page.dart';

class TodoComponent extends StatefulWidget {
  final Todos todos;
  final int index;
  final VoidCallback onDelete;

  const TodoComponent(
      {super.key,
      required this.index,
      required this.todos,
      required this.onDelete});

  @override
  State<TodoComponent> createState() => TodoComponentState();
}

class TodoComponentState extends State<TodoComponent>
    with AutomaticKeepAliveClientMixin {
  RxInt hours = 0.obs, minutes = 0.obs, seconds = 0.obs;
  Timer? timer;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (seconds < 59) {
        seconds++;
      } else {
        seconds.value = 0;
        if (minutes < 59) {
          minutes++;
        } else {
          minutes.value = 0;
          hours++;
        }
      }
      setState(() {});
    });
    log(formattedTime());
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formattedTime() {
    return '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoDetailsPage(
                componentState: this,
                index: widget.index,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Task: ${widget.todos.todoMinutes} Minutes ${widget.todos.todoSeconds}",
                        style: MyTextStyle.regular(fontSize: 13, color: black),
                      ),
                      Text(
                        formattedTime(),
                        style: MyTextStyle.semiBold(fontSize: 14),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.todos.title}",
                            style: MyTextStyle.semiBold(fontSize: 15),
                          ),
                          DesignConst.gap6,
                          Text(
                            "${widget.todos.descriptions}",
                            style: MyTextStyle.regular(
                                fontSize: 13.5, color: grey600),
                          ),
                          DesignConst.gap6,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 6),
                            decoration: BoxDecoration(
                              color: grey50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "${widget.todos.status}",
                              style: MyTextStyle.medium(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DesignConst.gap14,
                    Column(
                      children: [
                        widget.todos.isPlaying
                            ? Text(
                                "Pause",
                                style: MyTextStyle.medium(color: appPrimary),
                              )
                            : const SizedBox(),
                        DesignConst.gap15,
                        InkWell(
                          onTap: widget.onDelete,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
