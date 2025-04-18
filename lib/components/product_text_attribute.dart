import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/views/attrbiute_images_values_screen.dart';

import '../shared/theme.dart';

class ProductTextAttribute extends StatelessWidget {
  Function() deleteAction;
  Function()? showValuesAction;
  Color? color;
  TextEditingController nameAr;
  TextEditingController nameEn;
  bool? deleted;

  ProductTextAttribute(
      {super.key,
      this.color,
      required this.deleteAction,
      this.deleted,
      required this.nameAr,
      required this.nameEn,this.showValuesAction});

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
        color: color ?? MyTheme.blackColor,
        // border: MyTheme.
        borderRadius: MyTheme.buttonsRadius,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 6,
                    ),
                    child: TextWidget(
                      text: "تفاصيل الواصفة ",
                      fontSize: 14,
                    ),
                  ),
                  deleted ?? false
                      ? const SizedBox()
                      : InkWell(
                          onTap: deleteAction,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.delete,
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
              FittedBox(
                child: MyButton(
                  action: showValuesAction,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  text: "قيم الواصفة",
                  buttonColor: MyTheme.blueColor,
                ),
              )
            ],
          ),
          Visibility(
            visible: deleted ?? false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                color: MyTheme.blackColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    text: "يرجى التأكيد للحذف",
                    fontSize: 18,
                    color: MyTheme.textBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  InkWell(
                    onTap: deleteAction,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                          color: MyTheme.blueColor,
                          borderRadius: MyTheme.buttonsRadius),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            color: MyTheme.textBlackColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextWidget(text: "إلغاء")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
