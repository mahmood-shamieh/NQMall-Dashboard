import 'package:flutter/material.dart';

import '../shared/theme.dart';

class ShadowContainer extends StatelessWidget {
  final Widget? widget;
  final double? width, height;
  const ShadowContainer({super.key, this.widget, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      margin: MyTheme.margin,
      padding: MyTheme.padding,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: MyTheme.blackColor,
        borderRadius: MyTheme.buttonsRadius,
        border: Border(
          top: BorderSide(color: MyTheme.borderColor),
          bottom: BorderSide(color: MyTheme.borderColor),
          left: BorderSide(color: MyTheme.borderColor),
          right: BorderSide(color: MyTheme.borderColor),
        ),
        boxShadow: [
          BoxShadow(
            color: MyTheme.shadowColor,
            offset: const Offset(0, 0),
            blurRadius: 2,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: widget,
    );
  }
}
