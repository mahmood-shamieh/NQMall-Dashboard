import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/text_attributes_widget.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/app_bar_widget.dart';
import '../components/my_button.dart';
import '../components/product_text_attriburte_value.dart';
import '../components/product_text_attribute.dart';
import '../components/text_widget.dart';
import '../controllers/product/edit_text_attributes_screen_controller.dart';

class EditTextAttributesScreen extends StatelessWidget {
  ProductModel productModel;
  List<AttributeModel> attributes;
  bool? isArabic;
  EditTextAttributesScreen(
      {super.key,
      required this.productModel,
      required this.attributes,
      this.isArabic});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditTextAttributesScreenController>(
      init: Get.put(
        EditTextAttributesScreenController(
          currentAttributes: attributes,
        ),
      ),
      builder: (controller) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: MyTheme.blackColor,
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: ListBody(
                      children: [
                        Column(
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
                                child: Directionality(
                                  textDirection: currentDirection,
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
                                              borderRadius:
                                                  MyTheme.buttonsRadius,
                                            ),
                                            child: TextAttributeWidget(
                                              attributeModel: e,
                                              isArabic: isArabic ?? true,
                                              isDeleted: controller
                                                  .deletedAttributes
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
                                )),
                            TextWidget(
                              text: 'المواصفات الجديدة:',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
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
                                        text: "تفاصيل المنتج",
                                        textAlign: TextAlign.start,
                                      ),
                                      MyButton(
                                        text: "إضافة",
                                        action: () =>
                                            controller.addTextAttribute(),
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
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 120,
                        )
                      ],
                    ),
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
