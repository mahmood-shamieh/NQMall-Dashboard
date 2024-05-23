import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/image_can_be_deleted_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_attributes_widget.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/product/edit_product_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/image_attribute_Widget.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/views/edit_image_attribute_screen.dart';
import 'package:nq_mall_dashboard/views/edit_text_attributes_scree.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/constant.dart';
import '../shared/theme.dart';

class EditProductScreen extends StatelessWidget {
  ProductModel productModel;
  EditProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    const double elementSpacing = 10;
    const double smallElementSpacing = 4;
    return GetBuilder<EditProductScreenController>(
      init: Get.put(
        EditProductScreenController(productModel: productModel),
      ),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
            actions: [
              IconButton(
                onPressed: () => controller.changeViewLanguages(),
                icon: FaIcon(
                  FontAwesomeIcons.language,
                  color: MyTheme.iconColor,
                ),
              )
            ],
          ),
          backgroundColor: MyTheme.blackColor,
          body: controller.loadDetails.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: ListBody(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(height: 300.0),
                        items: productModel.media!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ImageCanBeDeletedWidget(
                                url: "${Constants.mediaUrl}/${i.URL!.toUrl()}",
                                action: () => controller
                                    .addMediaToImageToDelete(media: i),
                                isDeleted: controller.imageToDelete.contains(i),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: smallElementSpacing,
                            ),

                            TextWidget(
                              text: controller.currentLanguages.value == "ar"
                                  ? 'الاسم:'
                                  : "Name:",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            TextFieldWidget(
                              hintText:
                                  controller.currentLanguages.value == "ar"
                                      ? 'الاسم:'
                                      : "Name:",
                              controller:
                                  controller.currentLanguages.value == "ar"
                                      ? controller.nameAr
                                      : controller.nameEn,
                            ),
                            // TextWidget(
                            //   text: (controller.currentLanguages.value == "ar"
                            //           ? controller.productModel.NameAr
                            //           : controller.productModel.NameEn) ??
                            //       '',
                            //   fontSize: 14,
                            // ),
                            SizedBox(
                              height: smallElementSpacing,
                            ),

                            TextWidget(
                              text: controller.currentLanguages.value == "ar"
                                  ? 'وصف المنتج:'
                                  : "Description:",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            TextFieldWidget(
                              maxLine: null,
                              hintText:
                                  controller.currentLanguages.value == "ar"
                                      ? 'وصف المنتج:'
                                      : "Description:",
                              controller:
                                  controller.currentLanguages.value == "ar"
                                      ? controller.descriptionAr
                                      : controller.descriptionEn,
                            ),
                            SizedBox(
                              height: smallElementSpacing,
                            ),
                            TextWidget(
                              text: controller.currentLanguages.value == "ar"
                                  ? 'السعر:'
                                  : "price:",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            TextFieldWidget(
                              maxLine: null,
                              hintText:
                                  controller.currentLanguages.value == "ar"
                                      ? 'السعر:'
                                      : "price:",
                              controller:
                                  controller.currentLanguages.value == "ar"
                                      ? controller.price
                                      : controller.price,
                            )
                            // Row(
                            //   children: [
                            //     TextWidget(
                            //       text:
                            //           controller.currentLanguages.value == "ar"
                            //               ? 'السعر:'
                            //               : "price:",
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 16,
                            //     ),
                            //     const SizedBox(
                            //       width: 5,
                            //     ),
                            //     TextWidget(
                            //       text:
                            //           controller.productModel.Price.toString(),
                            //       fontSize: 14,
                            //     ),
                            //   ],
                            // ),
                            ,
                            SizedBox(
                              height: smallElementSpacing,
                            ),

                            TextWidget(
                              text: controller.currentLanguages.value == "ar"
                                  ? 'سعر التخفيضات:'
                                  : "Discount price:",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            TextFieldWidget(
                              maxLine: null,
                              hintText:
                                  controller.currentLanguages.value == "ar"
                                      ? 'سعر التخفيضات:'
                                      : "Discount price:",
                              controller:
                                  controller.currentLanguages.value == "ar"
                                      ? controller.salePrice
                                      : controller.salePrice,
                            ),
                            // Row(
                            //   children: [
                            //     TextWidget(
                            //       text:
                            //           controller.currentLanguages.value == "ar"
                            //               ? 'سعر التخفيضات:'
                            //               : "Discount price:",
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 16,
                            //     ),
                            //     const SizedBox(
                            //       width: 5,
                            //     ),
                            //     TextWidget(
                            //       text: controller.productModel.SalePrice
                            //           .toString(),
                            //       fontSize: 14,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            TextWidget(
                              text: controller.currentLanguages.value == "ar"
                                  ? 'مواصفات المنتج:'
                                  : "Product Attributes:",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            ...controller.attributes
                                .where((element) => element.Type == 'images')
                                .map(
                                  (e) => ImageAttributeWidget(
                                    attributeModel: e,
                                    isArabic:
                                        controller.currentLanguages.value ==
                                            'ar',
                                  ),
                                )
                                .toList(),
                            const SizedBox(
                              height: elementSpacing,
                            ),

                            ...controller.attributes
                                .where((element) => element.Type == 'items')
                                .map(
                                  (e) => TextAttributeWidget(
                                    attributeModel: e,
                                    isArabic:
                                        controller.currentLanguages.value ==
                                            "ar",
                                  ),
                                )
                                .toList(),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            // TextWidget(
                            //   text: controller.currentLanguages.value == "ar"
                            //       ? 'مواصفات المنتج:'
                            //       : "Product Attributes",
                            //   fontWeight: FontWeight.bold,
                            // ),

                            ...(controller.currentLanguages.value == "ar"
                                    ? controller.productModel.DetailsAr!
                                    : controller.productModel.DetailsEn!)
                                .entries
                                .map(
                                  (e) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: "${e.key}:",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextWidget(
                                        text: e.value,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            MyButton(
                              action: () => Get.to(
                                () => EditImageAttributeScreen(
                                    attributes: controller.attributes
                                        .where((element) =>
                                            element.Type == "images")
                                        .toList(),
                                    productModel: controller.productModel),
                              ),
                              text:
                                  //  controller.currentLanguages.value == "ar"
                                  //     ?
                                  "تعديل واصفات الصور"
                                      // : "edit Image Attributes"
                                      .capitalizeFirstChar(),
                              buttonColor: MyTheme.blueColor,
                            ),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            MyButton(
                              action: () => Get.to(
                                () => EditTextAttributesScreen(
                                  productModel: controller.productModel,
                                  attributes: controller.attributes
                                      .where(
                                          (element) => element.Type == 'items')
                                      .toList(),
                                ),
                              ),
                              text:
                                  // controller.currentLanguages.value == "ar"
                                  // ?
                                  "تعديل واصفات الكتابة"
                              // : "Edit Text Attributes"
                              ,
                              buttonColor: MyTheme.blueColor,
                            ),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            MyButton(
                              text:
                                  //  controller.currentLanguages.value == "ar" ?
                                  "تعديل مواصفات المنتج"
                              // : ''
                              ,
                              buttonColor: MyTheme.blueColor,
                            ),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            MyButton(
                              text:
                                  // controller.currentLanguages.value == "ar" ?
                                  "حفظ التعديلات"
                              // : ""
                              ,
                              buttonColor: MyTheme.blueColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
