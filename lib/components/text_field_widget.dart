import 'package:flutter/material.dart';

import '../shared/theme.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? icon;
  final bool? isPasswordField;
  bool showPassword = true;
  EdgeInsets? padding, margin;
  TextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.icon,
    this.isPasswordField,
    this.padding,
    this.margin,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 2),
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 2),
      child: TextField(
        controller: widget.controller,
        style: MyTheme.getTextStyle1(
          color: MyTheme.iconColor,
          fontWeight: FontWeight.w300,
          fontSize: 12,
        ),
        obscureText:
            widget.isPasswordField ?? false ? widget.showPassword : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12, left: 15, right: 15),
          hintText: widget.hintText,
          hintStyle: MyTheme.getTextStyle1(
            color: MyTheme.iconColor,
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
          filled: true,
          fillColor: MyTheme.blackColor,
          suffixIcon: widget.isPasswordField ?? false
              ? InkWell(
                  onTap: () => setState(() {
                    widget.showPassword = !widget.showPassword;
                  }),
                  child: Icon(
                    widget.showPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: MyTheme.iconColor,
                  ),
                )
              : widget.icon,
          border: OutlineInputBorder(
            borderRadius: MyTheme.buttonsRadius,
            borderSide: BorderSide(
              color: MyTheme.mainColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: MyTheme.buttonsRadius,
            borderSide: BorderSide(
              color: MyTheme.borderColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
