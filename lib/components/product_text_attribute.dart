import 'package:flutter/material.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';

import '../shared/theme.dart';

class ProductTextAttribute extends StatelessWidget {
  Function() deleteAction;
  Function() addValueAction;

  TextEditingController nameAr;
  TextEditingController nameEn;

  ProductTextAttribute(
      {super.key,
      required this.addValueAction,
      required this.deleteAction,
      required this.nameAr,
      required this.nameEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(
      // bottom: 6,
      //     ),
      padding: const EdgeInsets.all(
        8,
      ),
      width: double.infinity,
      // height: 20,
      decoration: BoxDecoration(
        color: MyTheme.blackColor,
        // border: MyTheme.
        borderRadius: MyTheme.buttonsRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 6,
                ),
                child: TextWidget(
                  text: "تفاصيل الواصفة",
                  fontSize: 14,
                ),
              ),
              InkWell(
                onTap: deleteAction,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.close,
                    color: MyTheme.greyColor,
                  ),
                ),
              ),
            ],
          ),
          TextFieldWidget(
            hintText: "اسم الواصفة بالعربي",
            margin: EdgeInsets.all(0),
            controller: nameAr,
          ),
          TextFieldWidget(
            hintText: "اسم الواصفة بالإنكليزي",
            margin: EdgeInsets.all(0),
            controller: nameEn,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  text: "قيم الواصفة",
                  textAlign: TextAlign.start,
                  fontSize: 14,
                ),
                MyButton(
                  text: "إضافة",
                  fontSize: 14,
                  action: addValueAction,
                  buttonColor: MyTheme.blueColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
