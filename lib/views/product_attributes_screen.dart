import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/image_can_be_deleted_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/product_text_attribute.dart';
import 'package:nq_mall_dashboard/components/shadow_container.dart';
import 'package:nq_mall_dashboard/components/text_attributes_widget.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/product/edit_product_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/product/product_attributes_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/image_attribute_Widget.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/attribute_types.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/views/attrbiute_images_values_screen.dart';
import 'package:nq_mall_dashboard/views/attrbiute_values_screen.dart';
import 'package:nq_mall_dashboard/views/edit_image_attribute_screen.dart';
import 'package:nq_mall_dashboard/views/edit_product_attributes_screen.dart';
import 'package:nq_mall_dashboard/views/edit_text_attributes_scree.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/constant.dart';
import '../shared/theme.dart';

class ProductAttributesScreen extends StatelessWidget {
  ProductModel productModel;
  ProductAttributesScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    const double elementSpacing = 10;
    const double smallElementSpacing = 4;
    return GetBuilder<ProductAttributesScreenController>(
      init: Get.put(
        ProductAttributesScreenController(productModel: productModel),
      ),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
            actions: const [
              SizedBox(
                width: 50,
              )
            ],
          ),
          backgroundColor: MyTheme.blackColor,
          floatingActionButton: controller.showSaveEditsButton() ||
                  controller.attributesToDelete.isNotEmpty
              ? const SizedBox()
              : InkWell(
                  onTap: () => controller.showAddDialogFunction(),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        color: MyTheme.blueColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.add,
                      color: MyTheme.textBlackColor,
                    ),
                  ),
                ),
          body: controller.loadDetails.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              ...controller.attributes
                                  .map((e) => Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: ProductTextAttribute(
                                            deleted: controller.attributesToDelete
                                                .contains(e),
                                            color: MyTheme.mainColor,
                                            showValuesAction: e.Type.toString()
                                                        .toLowerCase() ==
                                                    AttributeTypes.Images.name
                                                        .toLowerCase()
                                                        .toString()
                                                ? () => Get.to(() =>
                                                    AttributeImageValueScreen(
                                                      attributeModel: e,
                                                    ))
                                                : () => Get.to(
                                                    () => AttributeValuesScreen(
                                                          attributeModel: e,
                                                        )),
                                            deleteAction: () =>
                                                controller.addAttributesToDelete(
                                                    attributeModel: e),
                                            nameAr: controller.attributesTextEditingControllers[
                                                e.Id ?? 0]!['NameAr']!,
                                            nameEn: controller
                                                .attributesTextEditingControllers[e.Id ?? 0]!['NameEn']!),
                                      ))
                                  .toList(),
                              const SizedBox(
                                height: 140,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Column(
                        children: [
                          Visibility(
                            visible: controller.attributesToDelete.isNotEmpty,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: MyButton(
                                  action: () =>
                                      controller.sendAttributesToDeleteApi(),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  text: "حذف",
                                  buttonColor: MyTheme.blueColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: controller.showSaveEditsButton(),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: MyButton(
                                  action: () =>
                                      controller.sendAttributesToEditApi(),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  text: "حفظ التعديلات",
                                  buttonColor: MyTheme.blueColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.showAddDialog.value,
                      child: Center(
                        child: ShadowContainer(
                          height: 320,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextWidget(text: "إضافة واصفة"),
                              TextFieldWidget(
                                controller: controller.newAttributeNameAr,
                                hintText: "اسم الواصفة العربي",
                              ),
                              TextFieldWidget(
                                controller: controller.newAttributeNameEn,
                                hintText: "اسم الواصفة الإنكليزي",
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(top: 10),
                                // color: Colors.amber,
                                child: Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          controller.setSelectedAttributesType(
                                              type: AttributeTypes.List),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: controller
                                                        .selectedAttributeType
                                                        .value ==
                                                    AttributeTypes.List
                                                ? MyTheme.blueColor
                                                : MyTheme.appBarColor),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 20,
                                        ),
                                        child: TextWidget(text: 'قائمة'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          controller.setSelectedAttributesType(
                                              type: AttributeTypes.Items),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: controller
                                                        .selectedAttributeType
                                                        .value ==
                                                    AttributeTypes.Items
                                                ? MyTheme.blueColor
                                                : MyTheme.appBarColor),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 20,
                                        ),
                                        child: TextWidget(text: 'عناصر'),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          controller.setSelectedAttributesType(
                                              type: AttributeTypes.Images),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: controller
                                                        .selectedAttributeType
                                                        .value ==
                                                    AttributeTypes.Images
                                                ? MyTheme.blueColor
                                                : MyTheme.appBarColor),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 20,
                                        ),
                                        child: TextWidget(text: 'صور'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MyButton(
                                action: () => controller.addNewAttribute(),
                                text: "إضافة",
                                buttonColor: MyTheme.blueColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                margin: const EdgeInsets.only(top: 10),
                              ),
                              MyButton(
                                action: () =>
                                    controller.showAddDialogFunction(),
                                text: "إلغاء",
                                buttonColor: MyTheme.appBarColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                margin: const EdgeInsets.only(top: 10),
                              )
                            ],
                          ),
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
