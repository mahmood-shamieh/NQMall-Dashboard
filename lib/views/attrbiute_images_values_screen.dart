import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/product_image_attriburte_value.dart';
import 'package:nq_mall_dashboard/components/product_text_attriburte_value.dart';
import 'package:nq_mall_dashboard/components/shadow_container.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/product/atrribute_Images_values_screen_controller.dart';

import 'package:nq_mall_dashboard/controllers/product/atrribute_values_screen_controller.dart';

import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/my_button.dart';

class AttributeImageValueScreen extends StatelessWidget {
  AttributeModel attributeModel;
  AttributeImageValueScreen({super.key, required this.attributeModel});

  @override
  Widget build(BuildContext context) {
    const double elementSpacing = 10;
    const double smallElementSpacing = 4;
    return GetBuilder<AttributeImagesValuesScreenController>(
      init: Get.put(
        AttributeImagesValuesScreenController(attributeModel: attributeModel),
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
                  controller.valuesToDelete.isNotEmpty
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
              :
              // ProductTextAttributeValue(
              //                           nameArController: controller.valuesTextEditingController[
              //                               e.Id ?? 0]!['ValueAr']!,
              //                           nameEnController:
              //                               controller.valuesTextEditingController[
              //                                   e.Id ?? 0]!['ValueEn']!,
              //                           chooseImageActionAr: () =>
              //                               controller.chooseImageForValue(
              //                                   valueModel: e,
              //                                   tag: 'HoverImageAr'),
              //                           chooseImageActionEn: () =>
              //                               controller.chooseImageForValue(
              //                                   valueModel: e,
              //                                   tag: 'HoverImageEn'),
              //                           imageAr: controller.valuesImages[e.Id ?? 0]
              //                               ?['HoverImageAr'],
              //                           imageEn: controller.valuesImages[e.Id ?? 0]?['HoverImageEn'],
              //                           oldImageAr: e.HoverImageAr,
              //                           oldImageEn: e.HoverImageEn,
              //                           deleteAction: () => controller.addValueToDelete(valueModel: e),
              //                           deleted: controller.valuesToDelete.contains(e))
              Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              ...controller.values
                                  .map(
                                    (e) => ProductImageAttributeValue(
                                      oldImageAr: e.ValueAr,
                                      oldImageEn: e.ValueEn,
                                      imageAr: controller.valuesImages[e.Id]
                                          ?['ValueAr'],
                                      imageEn: controller.valuesImages[e.Id]
                                          ?['ValueEn'],
                                      oldHoverImageAr: e.HoverImageAr,
                                      oldHoverImageEn: e.HoverImageEn,
                                      hoverImageAr: controller
                                          .valuesImages[e.Id]?['HoverImageAr'],
                                      hoverImageEn: controller
                                          .valuesImages[e.Id]?['HoverImageEn'],
                                      chooseImageActionAr: () =>
                                          controller.chooseImageForValue(
                                              valueModel: e, tag: 'ValueAr'),
                                      chooseImageActionEn: () =>
                                          controller.chooseImageForValue(
                                              valueModel: e, tag: 'ValueEn'),
                                      chooseHoverImageArAction: () =>
                                          controller.chooseImageForValue(
                                              valueModel: e,
                                              tag: 'HoverImageAr'),
                                      chooseHoverImageEnAction: () =>
                                          controller.chooseImageForValue(
                                              valueModel: e,
                                              tag: 'HoverImageEn'),
                                      deleteAction: () => controller
                                          .addValueToDelete(valueModel: e),
                                      deleted:
                                          controller.valuesToDelete.contains(e),
                                    ),
                                  )
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
                            visible: controller.valuesToDelete.isNotEmpty,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: MyButton(
                                  action: () =>
                                      controller.deleteAttributeValueAction(),
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
                                      controller.editAttributeValueAction(),
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
                      child: ShadowContainer(
                        // height: 320,
                        widget: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextWidget(text: "إضافة قيمة جديدة"),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                    top: 5,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  height: controller.newValueAr == null
                                      ? null
                                      : 220,
                                  decoration: BoxDecoration(
                                    borderRadius: MyTheme.buttonsRadius,
                                    color: MyTheme.appBarColor,
                                    image: controller.newValueAr != null
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: MemoryImage(
                                                controller.newValueAr!),
                                          )
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: controller.newValueAr == null,
                                        child: Center(
                                          child: MyButton(
                                            action: () => controller
                                                .chooseImageForNewValue(
                                                    tag: "ValueAr"),
                                            height: 45,
                                            width: 200,
                                            text: "صورة القيمة باللغة العربية",
                                            buttonColor: MyTheme.blueColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.newValueAr == null,
                                        child: const Center(
                                          child: TextWidget(
                                            textAlign: TextAlign.center,
                                            text:
                                                'تظهر هذه الصورة بمثابة القيمة للمستخدم باللغة العربية',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.newValueAr != null,
                                        child: InkWell(
                                          onTap: () =>
                                              controller.chooseImageForNewValue(
                                                  tag: "HoverImageAr"),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyTheme.appBarColor
                                                  .withOpacity(
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
                                  height: controller.newValueEn == null
                                      ? null
                                      : 220,
                                  decoration: BoxDecoration(
                                    borderRadius: MyTheme.buttonsRadius,
                                    color: MyTheme.appBarColor,
                                    image: controller.newValueEn != null
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: MemoryImage(
                                                controller.newValueEn!),
                                          )
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: controller.newValueEn == null,
                                        child: Center(
                                          child: MyButton(
                                            action: () => controller
                                                .chooseImageForNewValue(
                                                    tag: "ValueEn"),
                                            height: 45,
                                            width: 200,
                                            text:
                                                "صورة القيمة باللغة الإنكليزية",
                                            buttonColor: MyTheme.blueColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.newValueEn == null,
                                        child: const Center(
                                          child: TextWidget(
                                            textAlign: TextAlign.center,
                                            text:
                                                'تظهر هذه الصورة بمثابة صورة القيمة باللغة الإنكليزية',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.newValueEn != null,
                                        child: InkWell(
                                          onTap: () =>
                                              controller.chooseImageForNewValue(
                                                  tag: "HoverImageAr"),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyTheme.appBarColor
                                                  .withOpacity(
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
                                  height:
                                      controller.imageAr == null ? null : 220,
                                  decoration: BoxDecoration(
                                    borderRadius: MyTheme.buttonsRadius,
                                    color: MyTheme.appBarColor,
                                    image: controller.imageAr != null
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: MemoryImage(
                                                controller.imageAr!),
                                          )
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: controller.imageAr == null,
                                        child: Center(
                                          child: MyButton(
                                            action: () => controller
                                                .chooseImageForNewValue(
                                                    tag: "HoverImageAr"),
                                            height: 45,
                                            width: 200,
                                            text:
                                                "إختر صورة توضيحية باللغة العربية",
                                            buttonColor: MyTheme.blueColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.imageAr == null,
                                        child: const Center(
                                          child: TextWidget(
                                            textAlign: TextAlign.center,
                                            text:
                                                'تظهر هذه الصورة بمثابة توضيح للمستخدم عن الخيار المختار باللغة العربية',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.imageAr != null,
                                        child: InkWell(
                                          onTap: () =>
                                              controller.chooseImageForNewValue(
                                                  tag: "HoverImageAr"),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyTheme.appBarColor
                                                  .withOpacity(
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
                                  height:
                                      controller.imageEn == null ? null : 220,
                                  decoration: BoxDecoration(
                                    borderRadius: MyTheme.buttonsRadius,
                                    color: MyTheme.appBarColor,
                                    image: controller.imageEn != null
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: MemoryImage(
                                                controller.imageEn!),
                                          )
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: controller.imageEn == null,
                                        child: Center(
                                          child: MyButton(
                                            action: () => controller
                                                .chooseImageForNewValue(
                                                    tag: "HoverImageEn"),
                                            height: 45,
                                            width: 220,
                                            text:
                                                "إختر صورة توضيحية باللغة الإنكليزية",
                                            buttonColor: MyTheme.blueColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.imageEn == null,
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
                                        visible: controller.imageEn != null,
                                        child: InkWell(
                                          onTap: () =>
                                              controller.chooseImageForNewValue(
                                                  tag: "HoverImageEn"),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: MyTheme.appBarColor
                                                  .withOpacity(
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
                                MyButton(
                                  action: () =>
                                      controller.addImageValueAction(),
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
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
