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
  bool? isArabic;
  EditImageAttributeScreen(
      {super.key,
      required this.attributes,
      required this.productModel,
      this.isArabic});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditImageAttributeScreenController>(
      init: Get.put(
          EditImageAttributeScreenController(currentAttributes: attributes)),
      builder: (controller) => Directionality(
        textDirection: TextDirection.rtl,
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
                                            borderRadius: MyTheme.buttonsRadius,
                                          ),
                                          child: ImageAttributeWidget(
                                            attributeModel: e,
                                            isArabic: isArabic ?? true,
                                            isDeleted: controller
                                                .deletedAttribute
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
                            ),
                            TextWidget(
                              text: 'المواصفات الجديدة:',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                            ),
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
