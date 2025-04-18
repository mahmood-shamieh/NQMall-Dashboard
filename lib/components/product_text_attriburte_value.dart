import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';

import '../shared/theme.dart';

class ProductTextAttributeValue extends StatelessWidget {
  TextEditingController nameArController;
  TextEditingController nameEnController;
  Uint8List? imageAr, imageEn;
  String? oldImageAr;
  String? oldImageEn;
  Function() chooseImageActionAr, chooseImageActionEn;
  Function() deleteAction;
  bool? deleted;
  ProductTextAttributeValue(
      {super.key,
      required this.nameArController,
      required this.nameEnController,
      required this.chooseImageActionAr,
      required this.chooseImageActionEn,
      required this.deleteAction,
      this.imageAr,
      this.imageEn,
      this.deleted,
      this.oldImageAr,
      this.oldImageEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.appBarColor,
        borderRadius: MyTheme.buttonsRadius,
      ),
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 0,
        left: 8,
        right: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Stack(
        children: [
          Column(
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
              TextFieldWidget(
                hintText: "قيمة الواصفة بالعربي",
                margin: EdgeInsets.all(0),
                controller: nameArController,
              ),
              TextFieldWidget(
                hintText: "قيمة الواصفة بالإنكليزي",
                margin: EdgeInsets.all(0),
                controller: nameEnController,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                padding: const EdgeInsets.all(8),
                height: (imageAr == null && oldImageAr == null) ? null : 220,
                decoration: BoxDecoration(
                  borderRadius: MyTheme.buttonsRadius,
                  color: MyTheme.blackColor,
                  image: imageAr != null
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: MemoryImage(imageAr!),
                        )
                      : oldImageAr != null
                          ? DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "${Constants.mediaUrl}/${oldImageAr!.toUrl()}"),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (oldImageAr == null && imageAr == null),
                      child: Center(
                        child: MyButton(
                          action: chooseImageActionAr,
                          height: 45,
                          width: 200,
                          text: "إختر صورة توضيحية باللغة العربية",
                          buttonColor: MyTheme.blueColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (oldImageAr == null && imageAr == null),
                      child: Center(
                        child: const TextWidget(
                          textAlign: TextAlign.center,
                          text:
                              'تظهر هذه الصورة بمثابة توضيح للمستخدم عن الخيار المختار باللغة العربية',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: imageAr != null || oldImageAr != null,
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
                height: (imageEn == null && oldImageEn == null) ? null : 220,
                decoration: BoxDecoration(
                  borderRadius: MyTheme.buttonsRadius,
                  color: MyTheme.blackColor,
                  image: imageEn != null
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: MemoryImage(imageEn!),
                        )
                      : oldImageEn != null
                          ? DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "${Constants.mediaUrl}/${oldImageEn!.toUrl()}"),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (oldImageEn == null && imageEn == null),
                      child: Center(
                        child: MyButton(
                          action: chooseImageActionEn,
                          height: 45,
                          width: 220,
                          text: "إختر صورة توضيحية باللغة الإنكليزية",
                          buttonColor: MyTheme.blueColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (oldImageEn == null && imageEn == null),
                      child: Center(
                        child: const TextWidget(
                          textAlign: TextAlign.center,
                          text:
                              'تظهر هذه الصورة بمثابة توضيح للمستخدم عن الخيار المختار باللغة الإنكليزية',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (imageEn != null || oldImageEn != null),
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
              )
            ],
          ),
          Visibility(
            visible: deleted ?? false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180 +
                  (oldImageAr != null || imageAr != null ? 220 : 90) +
                  (imageEn != null || oldImageEn != null ? 220 : 90),
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
          )
        ],
      ),
    );
  }
}
