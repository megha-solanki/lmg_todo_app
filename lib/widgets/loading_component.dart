import 'package:flutter/material.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';


class LoadingComponent extends StatelessWidget {
  final Color color;
  final double size;
  final double loadingWidth;

  const LoadingComponent({
    super.key,
    this.color = appPrimary,
    this.size = 37,
    this.loadingWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: loadingWidth,
        ),
      ),
    );
  }
}
