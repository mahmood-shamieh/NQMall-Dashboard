import 'package:flutter/material.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/main.dart';

import '../shared/theme.dart';

class MyButton extends StatelessWidget {
  final Function()? action;
  final String? text;
  final Color? textColor;
  final Color? buttonColor;
  final FontWeight? fontWeight;
  final double? fontSize, width, height;
  final EdgeInsets? padding, margin;
  final Widget? icon;

  const MyButton(
      {super.key,
      this.action,
      this.text,
      this.textColor,
      this.fontWeight,
      this.fontSize,
      this.height,
      this.width,
      this.margin,
      this.padding,
      this.buttonColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: currentDirection,
      child: Container(
        width: icon == null ? width : null,
        height: icon == null ? height : null,
        margin: margin,
        // padding: padding,
        child: InkWell(
          onTap: action,
          child: Container(
            // margin: MyTheme.margin,
            padding: padding ?? MyTheme.padding,
            // width: width ?? double.infinity,
            // height: height ?? 50,
            decoration: BoxDecoration(
              color: buttonColor ?? MyTheme.mainColor,
              borderRadius: MyTheme.buttonsRadius,
            ),
            child: icon == null
                ? Center(
                    child: TextWidget(
                      text: text ?? '',
                      color: textColor ?? MyTheme.greyColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon!,
                      TextWidget(
                        text: text ?? '',
                        color: textColor ?? MyTheme.greyColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
