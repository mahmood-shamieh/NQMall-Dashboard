import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/product_text_attriburte_value.dart';
import 'package:nq_mall_dashboard/components/product_text_attribute.dart';
import 'package:nq_mall_dashboard/components/product_image_attriburte_value.dart';
import 'package:nq_mall_dashboard/components/product_image_attribute.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/controllers/brand/add_brand_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/category/add_category_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/text_widget.dart';
import '../controllers/product/add_product_screen_controller.dart';
import '../shared/constant.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductScreenController>(
      init: Get.put(AddProductScreenController()),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
          body: Stack(
            children: [
              controller.loading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Container(
                            padding: MyTheme.padding,
                            margin: MyTheme.margin,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: MyTheme.iconColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const TextWidget(text: 'إضافة منتج جديد')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 0,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                      text: "الصور",
                                      textAlign: TextAlign.start,
                                    ),
                                    controller.imagesBytes.isEmpty
                                        ? Container()
                                        : MyButton(
                                            action: () =>
                                                controller.chooseImage(),
                                            // width: 0,
                                            margin: EdgeInsets.only(bottom: 5),
                                            text: "إضافة المزيد",
                                            buttonColor: MyTheme.blueColor,
                                          )
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    color: MyTheme.appBarColor,
                                    width:
                                        // Responsive.isDesktop(context)
                                        //     ? 400
                                        //     :
                                        MediaQuery.of(context).size.width,
                                    height: 250,
                                    child: controller.imagesBytes.isEmpty
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                  text: "لا يوجد صور",
                                                  color: MyTheme.iconColor,
                                                ),
                                                MyButton(
                                                  width: 60,
                                                  // height: 60,
                                                  action: () =>
                                                      controller.chooseImage(),
                                                  icon: Icon(
                                                    Icons.image,
                                                    color: MyTheme.iconColor,
                                                  ),
                                                  buttonColor:
                                                      MyTheme.blueColor,
                                                  text: "إختر صور",
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: controller.imagesBytes
                                                .map(
                                                  (e) => Container(
                                                    margin:
                                                        const EdgeInsets.all(6),
                                                    child: Container(
                                                      width: 250,
                                                      height: 250,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: MemoryImage(
                                                            e,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .imagesBytes
                                                                  .remove(e);
                                                              controller
                                                                  .update();
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                MyTheme
                                                                    .appBarColor
                                                                    .withOpacity(
                                                                  0.3,
                                                                ),
                                                              ),
                                                            ),
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: MyTheme
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const TextWidget(
                                  text: "البراند",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<BrandModel>(
                                    isExpanded: true,
                                    barrierDismissible: true,
                                    // alignment: AlignmentDirectional.bottomEnd,
                                    isDense: true,
                                    hint: const SizedBox(
                                      width: double.infinity,
                                      child: TextWidget(
                                        text: "إختر البراند",
                                        fontSize: 12,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),

                                    items: controller.brands!
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Container(
                                                // color: Colors.amber,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        child: TextWidget(
                                                          text:
                                                              item.NameAr ?? '',
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            const EdgeInsetsDirectional
                                                                .only(
                                                                start: 10),
                                                        width: 40,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: MyTheme
                                                              .buttonsRadius,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              "${Constants.mediaUrl!}/${item.LogoUrl!.toUrl()}",
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: controller.selectedBrand?.value,
                                    onChanged: (value) =>
                                        controller.chooseBrand(brand: value!),
                                    style: MyTheme.getTextStyle1(
                                      color: MyTheme.mainColor,
                                    ),
                                    barrierColor:
                                        MyTheme.appBarColor.withOpacity(
                                      0.5,
                                    ),

                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: MyTheme.buttonsRadius,
                                        border: Border.fromBorderSide(
                                          BorderSide(
                                            color: MyTheme.borderColor,
                                            width: 0.2,
                                          ),
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 50,

                                      // width: 200,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      // maxHeight: 200,
                                      decoration: BoxDecoration(
                                        color: MyTheme.appBarColor,
                                        borderRadius: MyTheme.buttonsRadius,
                                      ),
                                      direction:
                                          DropdownDirection.textDirection,
                                      isFullScreen: true,
                                      useSafeArea: true,
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      // height: 40,

                                      selectedMenuItemBuilder:
                                          (context, child) => Container(
                                        decoration: BoxDecoration(
                                          color: MyTheme.blueColor,
                                          borderRadius: MyTheme.buttonsRadius,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: MyTheme.blueColor),
                                              child: Icon(
                                                Icons.check,
                                                color: MyTheme.iconColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  80,
                                              child: child,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    dropdownSearchData: DropdownSearchData(
                                      searchController:
                                          controller.brandSearchController,
                                      searchInnerWidgetHeight: 50,
                                      searchInnerWidget: Directionality(
                                        textDirection: currentDirection,
                                        child: TextFieldWidget(
                                          margin: MyTheme.padding,
                                          hintText: "البحث داخل البراندات",
                                          controller:
                                              controller.brandSearchController,
                                        ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                        return searchValue.isEmpty
                                            ? true
                                            : item.value!.NameAr!
                                                    .contains(searchValue) ||
                                                item.value!.NameEn!
                                                    .contains(searchValue);
                                      },
                                    ),
                                    //This to clear the search value when you close the menu
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        controller.brandSearchController
                                            .clear();
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const TextWidget(
                                  text: "التصنيف",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<CategoryModel>(
                                    isExpanded: true,
                                    barrierDismissible: true,
                                    alignment: AlignmentDirectional.center,

                                    isDense: true,
                                    hint: const SizedBox(
                                      width: double.infinity,
                                      child: TextWidget(
                                        text: "إختر التصنيف",
                                        fontSize: 12,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),

                                    items: controller.categories!
                                        .map((item) => DropdownMenuItem(
                                              value: item,
                                              child: Container(
                                                // color: Colors.amber,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        child: TextWidget(
                                                          text:
                                                              item.NameAr ?? '',
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            const EdgeInsetsDirectional
                                                                .only(
                                                                start: 10),
                                                        width: 40,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: MyTheme
                                                              .buttonsRadius,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              "${Constants.mediaUrl!}/${item.ImageURL!.toUrl()}",
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: controller.selectedCategory?.value,
                                    onChanged: (value) => controller
                                        .chooseCategory(category: value!),
                                    style: MyTheme.getTextStyle1(
                                      color: MyTheme.mainColor,
                                    ),
                                    barrierColor:
                                        MyTheme.appBarColor.withOpacity(
                                      0.5,
                                    ),

                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: MyTheme.buttonsRadius,
                                        border: Border.fromBorderSide(
                                          BorderSide(
                                            color: MyTheme.borderColor,
                                            width: 0.2,
                                          ),
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 50,
                                      // width: 200,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      // maxHeight: 200,
                                      decoration: BoxDecoration(
                                        color: MyTheme.appBarColor,
                                        borderRadius: MyTheme.buttonsRadius,
                                      ),
                                      direction: DropdownDirection.right,
                                      isFullScreen: true,
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      // height: 40,
                                      selectedMenuItemBuilder:
                                          (context, child) => Container(
                                        decoration: BoxDecoration(
                                          color: MyTheme.blueColor,
                                          borderRadius: MyTheme.buttonsRadius,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: MyTheme.blueColor),
                                              child: Icon(
                                                Icons.check,
                                                color: MyTheme.iconColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  80,
                                              child: child,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    dropdownSearchData: DropdownSearchData(
                                      searchController:
                                          controller.categorySearchController,
                                      searchInnerWidgetHeight: 50,
                                      searchInnerWidget: Directionality(
                                        textDirection: currentDirection,
                                        child: TextFieldWidget(
                                          margin: MyTheme.padding,
                                          hintText: "البحث داخل الأصناف",
                                          controller: controller
                                              .categorySearchController,
                                        ),
                                      ),
                                      searchMatchFn: (item, searchValue) {
                                        return searchValue.isEmpty
                                            ? true
                                            : item.value
                                                .toString()
                                                .contains(searchValue);
                                      },
                                    ),
                                    //This to clear the search value when you close the menu
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        controller.categorySearchController
                                            .clear();
                                      }
                                    },
                                  ),
                                ),
                                const TextWidget(
                                  text: "الاسم بالعربي",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                TextFieldWidget(
                                  hintText: "الاسم بالعربي",
                                  margin: EdgeInsets.all(0),
                                  controller: controller.nameAr,
                                ),
                                const TextWidget(
                                  text: "الاسم بالإنكليزي",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                TextFieldWidget(
                                  hintText: "الاسم بالإنكليزي",
                                  margin: EdgeInsets.all(0),
                                  controller: controller.nameEn,
                                ),
                                const TextWidget(
                                  text: "الوصف العربي",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                TextFieldWidget(
                                  hintText: "الوصف العربي",
                                  margin: EdgeInsets.all(0),
                                  controller: controller.descAr,
                                ),
                                const TextWidget(
                                  text: "الوصف الإنكليزي",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                TextFieldWidget(
                                  hintText: "الوصف الإنكليزي",
                                  margin: EdgeInsets.all(0),
                                  controller: controller.descEn,
                                ),
                                const TextWidget(
                                  text: "السعر",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                TextFieldWidget(
                                  hintText: "السعر",
                                  margin: EdgeInsets.all(0),
                                  controller: controller.price,
                                ),
                                const TextWidget(
                                  text: "سعر التخفيضات إن وجد",
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 5),
                                TextFieldWidget(
                                  hintText: "سعر التخفيضات إن وجد",
                                  margin: EdgeInsets.all(0),
                                  controller: controller.salePrice,
                                ),
                                const SizedBox(
                                  height: 10,
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
                                            text: "مواصفات المنتج بالعربي",
                                            textAlign: TextAlign.start,
                                          ),
                                          MyButton(
                                            text: "إضافة",
                                            action: () =>
                                                controller.addAttributeAr(),
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
                                                borderRadius:
                                                    MyTheme.buttonsRadius,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          right: 6,
                                                        ),
                                                        child: TextWidget(
                                                          text:
                                                              "تفاصيل الواصفة",
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () => controller
                                                            .deleteAttributeAr(
                                                                e),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: MyTheme
                                                                .greyColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFieldWidget(
                                                    hintText:
                                                        "اسم الواصفة بالعربي",
                                                    margin: EdgeInsets.all(0),
                                                    controller: e['name'],
                                                  ),
                                                  TextFieldWidget(
                                                    hintText:
                                                        "قيمة الواصفة بالعربي",
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
                                            text: "مواصفات المنتج بالإنكليزي",
                                            textAlign: TextAlign.start,
                                          ),
                                          MyButton(
                                            text: "إضافة",
                                            action: () =>
                                                controller.addAttributeEn(),
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
                                                borderRadius:
                                                    MyTheme.buttonsRadius,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          right: 6,
                                                        ),
                                                        child: TextWidget(
                                                          text:
                                                              "تفاصيل الواصفة",
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () => controller
                                                            .deleteAttributeEn(
                                                                e),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: MyTheme
                                                                .greyColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFieldWidget(
                                                    hintText:
                                                        "اسم الواصفة بالإنجليزي",
                                                    margin: EdgeInsets.all(0),
                                                    controller: e['name'],
                                                  ),
                                                  TextFieldWidget(
                                                    hintText:
                                                        "قيمة الواصفة بالإنجليزي",
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
                                const SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: MyTheme.appBarColor,
                                //     borderRadius: MyTheme.buttonsRadius,
                                //   ),
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 8, vertical: 5),
                                //   child: Column(
                                //     children: [
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           const TextWidget(
                                //             text: "تفاصيل المنتج ( كتابة )",
                                //             textAlign: TextAlign.start,
                                //           ),
                                //           MyButton(
                                //             text: "إضافة",
                                //             action: () =>
                                //                 controller.addTextAttribute(),
                                //             buttonColor: MyTheme.blueColor,
                                //             padding: const EdgeInsets.symmetric(
                                //                 horizontal: 10, vertical: 4),
                                //             margin: const EdgeInsets.symmetric(
                                //               vertical: 4,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       const SizedBox(height: 5),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyButton(
                                  action: () => controller.submit(),
                                  buttonColor: MyTheme.blueColor,
                                  text: "إنشاء",
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              Visibility(
                visible: controller.showDialog.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyTheme.blackColor.withOpacity(
                      0.85,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                controller.createProduct.value
                                    ? Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Icon(
                                        Icons.check,
                                        color: MyTheme.greenColor,
                                        size: 30,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: "مرحلة إنشاء المنتج",
                                  color: MyTheme.iconColor,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                controller.uploadMedia.value
                                    ? Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Icon(
                                        Icons.check,
                                        color: MyTheme.greenColor,
                                        size: 30,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: "مرحلة رفع الصور",
                                  color: MyTheme.iconColor,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                controller.uploadProductDetails.value
                                    ? Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Icon(
                                        Icons.check,
                                        color: MyTheme.greenColor,
                                        size: 30,
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextWidget(
                                  text: "مرحلة إدخال التفاصيل",
                                  color: MyTheme.iconColor,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   // width: 120,
                          //   // height: 80,
                          //   child: MyButton(
                          //     action: () async {
                          //       controller.submit();
                          //     },
                          //     text: "aaa",
                          //     buttonColor: MyTheme.blueColor,
                          //   ),
                          // )
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
