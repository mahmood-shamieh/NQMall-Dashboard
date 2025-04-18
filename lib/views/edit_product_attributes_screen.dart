import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/my_button.dart';
import '../components/text_field_widget.dart';
import '../components/text_widget.dart';
import '../controllers/product/edit_produt_attributes_screen_controller.dart';

class EditProductAttributesScreen extends StatelessWidget {
  ProductModel productModel;
  EditProductAttributesScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductAttributeScreenController>(
      init: Get.put(
          EditProductAttributeScreenController(productModel: productModel)),
      builder: (controller) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyTheme.appBarColor,
                    borderRadius: MyTheme.buttonsRadius,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            text: "مواصفات المنتج بالعربي",
                            textAlign: TextAlign.start,
                          ),
                          MyButton(
                            text: "إضافة",
                            action: () => controller.addAttributeAr(),
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
                      ...controller.attributesAr
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        onTap: () =>
                                            controller.deleteAttributeAr(e),
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
                                    controller: e['name'],
                                  ),
                                  TextFieldWidget(
                                    hintText: "قيمة الواصفة بالعربي",
                                    margin: EdgeInsets.all(0),
                                    controller: e['value'],
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyTheme.appBarColor,
                    borderRadius: MyTheme.buttonsRadius,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            text: "مواصفات المنتج بالإنكليزي",
                            textAlign: TextAlign.start,
                          ),
                          MyButton(
                            text: "إضافة",
                            action: () => controller.addAttributeEn(),
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
                      ...controller.attributesEn
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.only(
                                bottom: 6,
                              ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        onTap: () =>
                                            controller.deleteAttributeEn(e),
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
                                    hintText: "اسم الواصفة بالإنجليزي",
                                    margin: EdgeInsets.all(0),
                                    controller: e['name'],
                                  ),
                                  TextFieldWidget(
                                    hintText: "قيمة الواصفة بالإنجليزي",
                                    margin: EdgeInsets.all(0),
                                    controller: e['value'],
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList()
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
        ),
      ),
    );
  }
}
