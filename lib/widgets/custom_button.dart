import 'package:flutter/material.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/loading_component.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? txtColor;

  const CustomButton(
      {super.key,
      required this.isLoading,
      required this.onPressed,
      this.bgColor,
      this.txtColor,
      this.height,
      this.width,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? DesignConst.btn50,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(bgColor ?? appPrimary),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const LoadingComponent()
            : Text(
                label,
                style: MyTextStyle.semiBold(color: txtColor ?? white),
              ),
      ),
    );
  }
}
