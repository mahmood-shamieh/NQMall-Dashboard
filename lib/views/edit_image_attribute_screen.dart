import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/controllers/product/edit_image_attriubte_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/image_attribute_Widget.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/my_button.dart';
import '../components/product_image_attriburte_value.dart';
import '../components/product_image_attribute.dart';
import '../components/text_widget.dart';
import '../models/attribute_model.dart';

class EditImageAttributeScreen extends StatelessWidget {
  ProductModel productModel;
  List<AttributeModel> attributes;
  EditImageAttributeScreen(
      {super.key, required this.attributes, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditImageAttributeScreenController>(
      init: Get.put(
          EditImageAttributeScreenController(currentAttributes: attributes)),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'المواصفات الحالية:',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration:
                                  BoxDecoration(color: MyTheme.appBarColor),
                              child: Column(
                                children: controller.currentAttributes
                                    .map(
                                      (e) => Container(
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyTheme.blackColor,
                                          borderRadius: MyTheme.buttonsRadius,
                                        ),
                                        child: ImageAttributeWidget(
                                          attributeModel: e,
                                          isArabic: true,
                                          isDeleted: controller.deletedAttribute
                                              .contains(e),
                                          deleteAction: () => controller
                                              .addToAttributesToDelete(
                                            attributeModel: e,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            TextWidget(
                              text: 'المواصفات الجديدة:',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: MyTheme.appBarColor,
                                borderRadius: MyTheme.buttonsRadius,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextWidget(
                                        text: "تفاصيل المنتج ( مع صور )",
                                        textAlign: TextAlign.start,
                                      ),
                                      MyButton(
                                        text: "إضافة",
                                        action: () =>
                                            controller.addImageAttribute(),
                                        buttonColor: MyTheme.blueColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ...controller.imageAttributes
                                      .map(
                                        (imageAttribute) => Container(
                                          margin: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: MyTheme.blackColor,
                                            borderRadius: MyTheme.buttonsRadius,
                                          ),
                                          child: Column(
                                            children: [
                                              ProductImageAttribute(
                                                addValueAction: () => controller
                                                    .addImageAttributeValue(
                                                  attributeHashCode:
                                                      imageAttribute.hashCode,
                                                ),
                                                deleteAction: () => controller
                                                    .deleteImageAttribute(
                                                        imageAttribute),
                                                nameAr:
                                                    imageAttribute['nameAr']!,
                                                nameEn:
                                                    imageAttribute['nameEn']!,
                                              ),
                                              ...(controller.imageAttributesValues[
                                                          imageAttribute
                                                              .hashCode] ??
                                                      [])
                                                  .map(
                                                    (imageAttributeValue) =>
                                                        ProductImageAttributeValue(
                                                      imageAr:
                                                          imageAttributeValue[
                                                              'imageByteAr'],
                                                      imageEn:
                                                          imageAttributeValue[
                                                              "imageByteEn"],
                                                      chooseImageAction: () =>
                                                          controller
                                                              .chooseImageForImageAttribute(
                                                        key: "imageByte",
                                                        attributeHashCode:
                                                            imageAttribute
                                                                .hashCode,
                                                        attributeValueHashCode:
                                                            imageAttributeValue
                                                                .hashCode,
                                                      ),
                                                      chooseImageActionEn: () =>
                                                          controller
                                                              .chooseImageForImageAttribute(
                                                        key: "imageByteEn",
                                                        attributeHashCode:
                                                            imageAttribute
                                                                .hashCode,
                                                        attributeValueHashCode:
                                                            imageAttributeValue
                                                                .hashCode,
                                                      ),
                                                      chooseImageActionAr: () =>
                                                          controller
                                                              .chooseImageForImageAttribute(
                                                        key: "imageByteAr",
                                                        attributeHashCode:
                                                            imageAttribute
                                                                .hashCode,
                                                        attributeValueHashCode:
                                                            imageAttributeValue
                                                                .hashCode,
                                                      ),
                                                      image:
                                                          imageAttributeValue[
                                                              "imageByte"],
                                                      deleteAction: () => controller
                                                          .deleteImageAttributeValue(
                                                              data:
                                                                  imageAttributeValue,
                                                              attributeHashCode:
                                                                  imageAttribute
                                                                      .hashCode),
                                                    ),
                                                  )
                                                  .toList()
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: SizedBox(
                  // height: 80,
                  width: MediaQuery.of(context).size.width - 40,
                  child: MyButton(
                    text: "حفظ التعديلات",
                    buttonColor: MyTheme.blueColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
