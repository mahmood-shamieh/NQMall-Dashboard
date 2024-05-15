import 'package:flutter/material.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  bool? selected;
  final IconData iconData;
  Function() action;
  DrawerItem(
      {super.key,
      required this.text,
      this.selected,
      required this.iconData,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        margin: MyTheme.margin,
        padding: MyTheme.padding,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                iconData,
                color:
                    selected ?? false ? MyTheme.mainColor : MyTheme.greyColor,
              ),
            ),
            Flexible(
              flex: 1,
              child: TextWidget(
                text: text,
                color:
                    selected ?? false ? MyTheme.mainColor : MyTheme.greyColor,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: selected ?? false ? MyTheme.greyColor : MyTheme.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
