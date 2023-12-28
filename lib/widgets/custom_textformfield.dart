import 'package:flutter/material.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';
import 'package:lmg_todo_app/utils/design_const.dart';
import 'package:lmg_todo_app/utils/my_textstyle.dart';
import 'package:lmg_todo_app/widgets/loading_component.dart';

class CustomTextFormField extends StatelessWidget {
  final bool readOnly;
  final bool isAbsorbing;
  final bool isEnabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? label;
  final String hintText;
  final String? dLabel;
  final int? maxLine;
  final Color? bgColor;
  final String? initVal;
  final Widget? pImage;
  final Widget? sImage;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const CustomTextFormField(
      {super.key,
      this.readOnly = false,
      this.isAbsorbing = false,
      this.isEnabled = true,
      this.onChanged,
      this.bgColor,
      this.initVal,
      this.pImage,
      this.sImage,
      this.validator,
      this.dLabel,
      this.onTap,
      required this.hintText,
      this.keyboardType,
      this.maxLine,
      this.controller,
      this.prefixIconConstraints,
      this.suffixIconConstraints,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            "$label",
            style: MyTextStyle.medium(fontSize: 13),
          ),
        DesignConst.gap8,
        InkWell(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: isAbsorbing,
            child: TextFormField(
              initialValue: initVal,
              onChanged: onChanged,
              cursorColor: black,
              readOnly: readOnly,
              controller: controller,
              keyboardType: keyboardType,
              style: MyTextStyle.medium(),
              maxLines: maxLine ?? 1,
              validator: validator,
              enabled: isEnabled,
              decoration: InputDecoration(
                hintText: hintText,
                constraints: const BoxConstraints(maxHeight: 50),
                fillColor: white,
                filled: true,
                isDense: true,
                hintStyle: MyTextStyle.regular(color: grey500),
                contentPadding: const EdgeInsets.only(
                    top: 13, bottom: 13, left: 12, right: 12),
                prefixIconConstraints: prefixIconConstraints,
                suffixIconConstraints: suffixIconConstraints,
                prefixIcon: pImage != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 9),
                        child: pImage,
                      )
                    : null,
                suffixIcon: sImage != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: sImage)
                    : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: grey100, width: 0.70)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: grey100, width: 0.70)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: appPrimary, width: 0.70),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: red, width: 0.70),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
