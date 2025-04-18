import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';

import '../shared/theme.dart';

class ProductImageAttributeValue extends StatelessWidget {
  Uint8List? hoverImageAr;
  Uint8List? hoverImageEn;
  String? oldHoverImageAr;
  String? oldHoverImageEn;
  String? oldImageAr;
  String? oldImageEn;
  Uint8List? imageAr;
  Uint8List? imageEn;
  Function() chooseImageActionAr;
  Function() chooseImageActionEn;
  Function() chooseHoverImageArAction;
  Function() chooseHoverImageEnAction;
  Function() deleteAction;
  bool? deleted;

  ProductImageAttributeValue({
    super.key,
    required this.imageAr,
    required this.imageEn,
    required this.chooseImageActionAr,
    required this.chooseImageActionEn,
    required this.chooseHoverImageArAction,
    required this.chooseHoverImageEnAction,
    this.deleted,
    required this.deleteAction,
    this.oldImageAr,
    this.oldImageEn,
    this.hoverImageAr,
    this.hoverImageEn,
    this.oldHoverImageAr,
    this.oldHoverImageEn,
  });

  @override
  Widget build(BuildContext context) {
    // print(deleted);
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
                          fit: BoxFit.contain,
                          image: MemoryImage(imageAr!),
                        )
                      : oldImageAr != null
                          ? DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  '${Constants.mediaUrl}/${oldImageAr.toString().toUrl()}'),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (imageAr == null && oldImageAr == null),
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
                      visible: (imageAr == null && oldImageAr == null),
                      child: Center(
                        child: const TextWidget(
                          textAlign: TextAlign.center,
                          text: 'تظهر هذه الصورة بمثابة خيار للمستخدم',
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
                          fit: BoxFit.contain,
                          image: MemoryImage(imageEn!),
                        )
                      : oldImageEn != null
                          ? DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  "${Constants.mediaUrl}/${oldImageEn.toString().toUrl()}"),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: (imageEn == null && oldImageEn == null),
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
                      visible: (imageEn == null && oldImageEn == null),
                      child: const Center(
                        child: Center(
                          child: TextWidget(
                            textAlign: TextAlign.center,
                            text: 'تظهر هذه الصورة بمثابة خيار للمستخدم',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: imageEn != null || oldImageEn != null,
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
                height: hoverImageAr == null && oldHoverImageAr == null
                    ? null
                    : 220,
                decoration: BoxDecoration(
                  borderRadius: MyTheme.buttonsRadius,
                  color: MyTheme.blackColor,
                  image: hoverImageAr != null
                      ? DecorationImage(
                          fit: BoxFit.contain,
                          image: MemoryImage(hoverImageAr!),
                        )
                      : oldHoverImageAr != null
                          ? DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  "${Constants.mediaUrl}/${oldHoverImageAr.toString().toUrl()}"),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: hoverImageAr == null && oldHoverImageAr == null,
                      child: Center(
                        child: MyButton(
                          action: chooseHoverImageArAction,
                          height: 45,
                          width: 130,
                          text: "إختر صورة توضيحية",
                          buttonColor: MyTheme.blueColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: hoverImageAr == null && oldHoverImageAr == null,
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
                      visible: hoverImageAr != null || oldHoverImageAr != null,
                      child: InkWell(
                        onTap: chooseHoverImageArAction,
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
                height: hoverImageEn == null && oldHoverImageEn == null
                    ? null
                    : 220,
                decoration: BoxDecoration(
                  borderRadius: MyTheme.buttonsRadius,
                  color: MyTheme.blackColor,
                  image: hoverImageEn != null
                      ? DecorationImage(
                          fit: BoxFit.contain,
                          image: MemoryImage(hoverImageEn!),
                        )
                      : oldHoverImageEn != null
                          ? DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  "${Constants.mediaUrl}/${oldHoverImageEn.toString().toUrl()}"),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: hoverImageEn == null && oldHoverImageEn == null,
                      child: Center(
                        child: MyButton(
                          action: chooseHoverImageEnAction,
                          height: 45,
                          width: 130,
                          text: "إختر صورة توضيحية",
                          buttonColor: MyTheme.blueColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: hoverImageEn == null && oldHoverImageEn == null,
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
                      visible: hoverImageEn != null || oldHoverImageEn != null,
                      child: InkWell(
                        onTap: chooseHoverImageEnAction,
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
                  (imageEn != null || oldImageEn != null ? 220 : 90) +
                  (hoverImageAr != null || oldHoverImageAr != null ? 220 : 90) +
                  (hoverImageEn != null || oldHoverImageEn != null ? 220 : 90),
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
