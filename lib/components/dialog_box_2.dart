import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class DialogBox2 extends StatelessWidget {
  final String title;
  final Widget? actions;
  final Widget? body;
  const DialogBox2({super.key, required this.title, this.actions, this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Directionality(
        textDirection: currentDirection,
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      // top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            color: MyTheme.iconColor,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextWidget(
                        text: title,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: body ?? Container(),
              ),
              actions ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
