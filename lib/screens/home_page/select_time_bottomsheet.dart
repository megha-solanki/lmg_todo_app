import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/custom_button.dart';

import '../../utils/design_const.dart';

class SelectTimeBottomSheet extends StatefulWidget {
  final int? selectedSecond, selectedMinute;
  final Function(int hour, int minute) onSelectTime;

  const SelectTimeBottomSheet(
      {super.key,
      required this.onSelectTime,
      this.selectedMinute,
      this.selectedSecond});

  @override
  State<SelectTimeBottomSheet> createState() => _SelectTimeBottomSheetState();
}

class _SelectTimeBottomSheetState extends State<SelectTimeBottomSheet> {
  int selectedMinute = 1;
  int selectedSecond = 1;

  @override
  void initState() {
    super.initState();
    getTime();
  }

  getTime() {
    print("${widget.selectedSecond} : ${widget.selectedMinute}");
    setState(() {
      if (widget.selectedSecond != null) {
        selectedSecond = widget.selectedSecond!;
      }
      if (widget.selectedMinute != null) {
        selectedMinute = widget.selectedMinute!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DesignConst.gap15,
          Text(
            "Select time",
            style: MyTextStyle.semiBold(fontSize: 17),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 45,
                child: CupertinoPicker(
                  itemExtent: 30,
                  squeeze: 1,
                  diameterRatio: 1.25,
                  selectionOverlay: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  scrollController: FixedExtentScrollController(
                      initialItem: selectedMinute - 1),
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.2),
                      child: Text(
                        "${index + 1}",
                        style: selectedMinute == index
                            ? MyTextStyle.semiBold(fontSize: 17)
                            : MyTextStyle.regular(fontSize: 17),
                      ),
                    );
                  }),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedMinute = value + 1;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 200,
                width: 45,
                child: CupertinoPicker(
                  itemExtent: 30,
                  squeeze: 1,
                  diameterRatio: 1.25,
                  selectionOverlay: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  scrollController: FixedExtentScrollController(
                      initialItem: selectedSecond - 1),
                  children: List.generate(60, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.2),
                      child: Text("${index + 1}",
                          style: selectedSecond == index
                              ? MyTextStyle.semiBold(fontSize: 17)
                              : MyTextStyle.regular(fontSize: 17)),
                    );
                  }),
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedSecond = value + 1;
                    });
                  },
                ),
              ),
            ],
          ),
          DesignConst.gap8,
          SizedBox(
            width: 120,
            child: CustomButton(
              label: "Done",
              onPressed: () {
                widget.onSelectTime(selectedMinute, selectedSecond);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
