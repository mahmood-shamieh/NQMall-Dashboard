import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class DialogBoxWidget extends StatelessWidget {
  final Widget? actions;
  final String title;
  final Widget? body;
  const DialogBoxWidget(
      {super.key, required this.title, this.actions, this.body});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: currentDirection,
      child: Dialog(
        backgroundColor: MyTheme.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        surfaceTintColor: MyTheme.blackColor,
        // shadowColor: MyTheme.shadowColor,
        child: FittedBox(
          child: Container(
            decoration: BoxDecoration(
                color: MyTheme.mainColor,
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyTheme.shadowColor,
                    blurRadius: 8,
                    spreadRadius: 0.2,
                    blurStyle: BlurStyle.outer,
                  )
                ]),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: MyTheme.iconColor,
                      ),
                    ),
                    TextWidget(
                      text: title,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                actions ?? Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
