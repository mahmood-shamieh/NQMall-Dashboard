import 'package:flutter/material.dart';

import '../shared/theme.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const TextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontStyle,
      this.fontWeight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.left,
      text: TextSpan(
        text: text,
        style: MyTheme.getTextStyle1(
          color: color ?? MyTheme.greyColor,
          fontSize: fontSize ?? 18,
          fontStyle: fontStyle,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
