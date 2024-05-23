import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool? showBackButton;
  List<Widget>? actions;
  AppBarWidget({super.key, this.showBackButton, this.actions})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: currentDirection,
      child: AppBar(
        backgroundColor: MyTheme.appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(text: 'قاسيون مول'),
            const SizedBox(
              width: 10,
            ),
            Container(
              // width: 200,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  // fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/photo_2023-11-22_20-25-26.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: widget.showBackButton ?? false
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.keyboard_arrow_left_sharp,
                  size: 30,
                  color: MyTheme.iconColor,
                ),
              )
            : IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  CupertinoIcons.line_horizontal_3,
                  color: MyTheme.iconColor,
                ),
              ),
        actions: widget.actions,
      ),
    );
  }
}
