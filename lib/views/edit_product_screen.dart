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
import 'package:nq_mall_dashboard/views/edit_product_attributes_screen.dart';
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
          ),
          backgroundColor: MyTheme.blackColor,
          body: controller.loadDetails.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyTheme.iconColor,
                            width: 0.4,
                          ),
                          borderRadius: MyTheme.buttonsRadius,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () =>
                                  controller.changeViewLanguages(lang: "ar"),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 9,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        controller.currentLanguages.value ==
                                                'ar'
                                            ? Radius.circular(6)
                                            : Radius.circular(0),
                                    topLeft:
                                        controller.currentLanguages.value ==
                                                'ar'
                                            ? Radius.circular(6)
                                            : Radius.circular(0),
                                    bottomRight:
                                        controller.currentLanguages.value ==
                                                'ar'
                                            ? Radius.circular(0)
                                            : Radius.circular(6),
                                    topRight:
                                        controller.currentLanguages.value ==
                                                'ar'
                                            ? Radius.circular(0)
                                            : Radius.circular(6),
                                  ),
                                  color:
                                      controller.currentLanguages.value == 'ar'
                                          ? MyTheme.blueColor
                                          : MyTheme.appBarColor,
                                ),
                                child: Center(child: TextWidget(text: "عربي")),
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  controller.changeViewLanguages(lang: "en"),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 9,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        controller.currentLanguages.value !=
                                                'ar'
                                            ? Radius.circular(6)
                                            : Radius.circular(0),
                                    topLeft:
                                        controller.currentLanguages.value !=
                                                'ar'
                                            ? Radius.circular(6)
                                            : Radius.circular(0),
                                    bottomRight:
                                        controller.currentLanguages.value !=
                                                'ar'
                                            ? Radius.circular(0)
                                            : Radius.circular(6),
                                    topRight:
                                        controller.currentLanguages.value !=
                                                'ar'
                                            ? Radius.circular(0)
                                            : Radius.circular(6),
                                  ),
                                  color:
                                      controller.currentLanguages.value != 'ar'
                                          ? MyTheme.blueColor
                                          : MyTheme.appBarColor,
                                ),
                                child:
                                    Center(child: TextWidget(text: "English")),
                              ),
                            )
                          ],
                        ),
                      ),
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
                                // .where((element) => element.Type == 'items')
                                .map(
                              (e) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TextAttributeWidget(
                                    //   attributeModel: e,
                                    //   isArabic:
                                    //       controller.currentLanguages.value ==
                                    //           "ar",
                                    // ),
                                    TextWidget(
                                      text:
                                          '${(controller.currentLanguages.value == "ar" ? e.NameAr : e.NameEn).toString()} :',
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: (e.values ?? [])
                                            .map((value) => Container(
                                                  height: 40,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                          .only(end: 4),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: MyTheme
                                                              .borderColor),
                                                      borderRadius: MyTheme
                                                          .buttonsRadius),
                                                  child: e.Type.toString()
                                                              .toLowerCase() ==
                                                          'images'
                                                      ? Image(
                                                          image: NetworkImage(
                                                              "${Constants.mediaUrl}/${(controller.currentLanguages.value == "ar" ? value.ValueAr : value.ValueEn).toString().toUrl()}"),
                                                        )
                                                      : TextWidget(
                                                          text: (controller
                                                                          .currentLanguages
                                                                          .value ==
                                                                      "ar"
                                                                  ? value
                                                                      .ValueAr
                                                                  : value
                                                                      .ValueEn)
                                                              .toString()),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
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
                            // const SizedBox(
                            //   height: elementSpacing,
                            // ),
                            // MyButton(
                            //   action: () => Get.to(
                            //     () => EditImageAttributeScreen(
                            //         isArabic:
                            //             controller.currentLanguages.value ==
                            //                     'ar'
                            //                 ? true
                            //                 : false,
                            //         attributes: controller.attributes
                            //             .where((element) =>
                            //                 element.Type == "images")
                            //             .toList(),
                            //         productModel: controller.productModel),
                            //   ),
                            //   text:
                            //       //  controller.currentLanguages.value == "ar"
                            //       //     ?
                            //       "تعديل واصفات الصور"
                            //           // : "edit Image Attributes"
                            //           .capitalizeFirstChar(),
                            //   buttonColor: MyTheme.blueColor,
                            // ),
                            // const SizedBox(
                            //   height: elementSpacing,
                            // ),
                            // MyButton(
                            //   action: () => Get.to(
                            //     () => EditTextAttributesScreen(
                            //       isArabic:
                            //           controller.currentLanguages.value == 'ar'
                            //               ? true
                            //               : false,
                            //       productModel: controller.productModel,
                            //       attributes: controller.attributes
                            //           .where(
                            //               (element) => element.Type == 'items')
                            //           .toList(),
                            //     ),
                            //   ),
                            //   text:
                            //       // controller.currentLanguages.value == "ar"
                            //       // ?
                            //       "تعديل واصفات الكتابة"
                            //   // : "Edit Text Attributes"
                            //   ,
                            //   buttonColor: MyTheme.blueColor,
                            // ),
                            const SizedBox(
                              height: elementSpacing,
                            ),
                            MyButton(
                              action: () => Get.to(
                                () => EditProductAttributesScreen(
                                  productModel: controller.productModel,
                                ),
                              ),
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
