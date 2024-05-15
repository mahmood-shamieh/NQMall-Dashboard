import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';

import '../shared/theme.dart';

class ProductImageAttributeValue extends StatelessWidget {
  Uint8List? image;
  Uint8List? imageAr;
  Uint8List? imageEn;
  Function() chooseImageActionAr;
  Function() chooseImageActionEn;
  Function() chooseImageAction;
  Function() deleteAction;

  ProductImageAttributeValue(
      {super.key,
      required this.imageAr,
      required this.imageEn,
      required this.chooseImageActionAr,
      required this.chooseImageActionEn,
      required this.chooseImageAction,
      required this.deleteAction,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.appBarColor,
        borderRadius: MyTheme.buttonsRadius,
      ),
      margin: const EdgeInsets.only(
        top: 0,
        bottom: 5,
        left: 8,
        right: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: deleteAction,
              child: Icon(
                Icons.close,
                color: MyTheme.greyColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 5,
            ),
            padding: const EdgeInsets.all(8),
            height: imageAr == null ? null : 220,
            decoration: BoxDecoration(
              borderRadius: MyTheme.buttonsRadius,
              color: MyTheme.blackColor,
              image: imageAr != null
                  ? DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: MemoryImage(imageAr!),
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: imageAr == null,
                  child: Center(
                    child: MyButton(
                      action: chooseImageActionAr,
                      height: 45,
                      width: 200,
                      text: "إختر صورة توضيحية للغة العربية",
                      buttonColor: MyTheme.blueColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Visibility(
                  visible: imageAr == null,
                  child: Center(
                    child: const TextWidget(
                      textAlign: TextAlign.center,
                      text: 'تظهر هذه الصورة بمثابة خيار للمستخدم',
                      fontSize: 14,
                    ),
                  ),
                ),
                Visibility(
                  visible: imageAr != null,
                  child: InkWell(
                    onTap: chooseImageActionAr,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyTheme.appBarColor.withOpacity(
                          0.3,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.edit,
                        color: MyTheme.greyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 5,
            ),
            padding: const EdgeInsets.all(8),
            height: imageEn == null ? null : 220,
            decoration: BoxDecoration(
              borderRadius: MyTheme.buttonsRadius,
              color: MyTheme.blackColor,
              image: imageEn != null
                  ? DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: MemoryImage(imageEn!),
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: imageEn == null,
                  child: Center(
                    child: MyButton(
                      action: chooseImageActionEn,
                      height: 45,
                      width: 210,
                      text: "إختر صورة توضيحية للغة الإنكليزية",
                      buttonColor: MyTheme.blueColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Visibility(
                  visible: imageEn == null,
                  child: Center(
                    child: const Center(
                      child: const TextWidget(
                        textAlign: TextAlign.center,
                        text: 'تظهر هذه الصورة بمثابة خيار للمستخدم',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: imageEn != null,
                  child: InkWell(
                    onTap: chooseImageActionEn,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyTheme.appBarColor.withOpacity(
                          0.3,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.edit,
                        color: MyTheme.greyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 5,
            ),
            padding: const EdgeInsets.all(8),
            height: image == null ? null : 220,
            decoration: BoxDecoration(
              borderRadius: MyTheme.buttonsRadius,
              color: MyTheme.blackColor,
              image: image != null
                  ? DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: MemoryImage(image!),
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: image == null,
                  child: Center(
                    child: MyButton(
                      action: chooseImageAction,
                      height: 45,
                      width: 130,
                      text: "إختر صورة توضيحية",
                      buttonColor: MyTheme.blueColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Visibility(
                  visible: image == null,
                  child: Center(
                    child: const TextWidget(
                      textAlign: TextAlign.center,
                      text:
                          'تظهر هذه الصورة بمثابة توضيح للمستخدم عن الخيار المختار',
                      fontSize: 14,
                    ),
                  ),
                ),
                Visibility(
                  visible: image != null,
                  child: InkWell(
                    onTap: chooseImageAction,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyTheme.appBarColor.withOpacity(
                          0.3,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.edit,
                        color: MyTheme.greyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
