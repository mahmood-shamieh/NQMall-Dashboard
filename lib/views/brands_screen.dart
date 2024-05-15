import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/brand_item.dart';
import 'package:nq_mall_dashboard/components/loading_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/brand/brand_screen_controller.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';
import 'package:nq_mall_dashboard/views/add_brand_screen.dart';
import 'package:nq_mall_dashboard/views/edit_brand_screen.dart';

import '../components/dialog_box.dart';
import '../components/text_field_widget.dart';
import '../main.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandScreenController>(
      init: Get.put(BrandScreenController()),
      builder: (controller) => SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            Icons.web_stories_outlined,
                            color: MyTheme.iconColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const TextWidget(text: 'البراندات')
                        ],
                      ),
                      MyButton(
                        width: 100,
                        height: 40,
                        action: () {
                          Get.to(AddBrandScreen());
                        },
                        buttonColor: MyTheme.blueColor,
                        text: 'إضافة براند جديد',
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        margin: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.add,
                          color: MyTheme.iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: MyTheme.padding.add(MyTheme.padding),
                  decoration: BoxDecoration(
                      color: MyTheme.appBarColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        // height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 4),
                              child: TextWidget(
                                text: "فلترة الأصناف:",
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 152,
                              child: TextFieldWidget(
                                hintText: "النص المراد البحث عنه",
                                controller: controller.searchBarText,
                                icon: Icon(
                                  Icons.search,
                                  color: MyTheme.iconColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Responsive(
                        mobile: SizedBox(
                            height: MediaQuery.of(context).size.height - 260,
                            child: controller.brands!.isEmpty
                                ? Center(
                                    child: TextWidget(text: "لا يوجد أصناف"),
                                  )
                                : NotificationListener<ScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification
                                              is ScrollEndNotification &&
                                          notification.metrics.extentAfter ==
                                              0) {
                                        controller.getBrandAtNextPage();
                                        // User has reached the end of the list
                                        // Load more data or trigger pagination in flutter
                                        // _loadMoreData();
                                      }
                                      return false;
                                    },
                                    child: ListView(
                                      controller: controller.scrollController,
                                      children: controller.brands!
                                          .map(
                                            (e) => BrandItem(
                                              isMobile: true,
                                              actionWidget: SizedBox(
                                                child: Directionality(
                                                  textDirection:
                                                      currentDirection,
                                                  child:
                                                      PopupMenuButton<String>(
                                                    // onSelected: handleClick,
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return [
                                                        PopupMenuItem<String>(
                                                          value: "تعديل",
                                                          child: InkWell(
                                                            onTap: () => Get.to(
                                                              () =>
                                                                  EditBrandScreen(
                                                                brandModel: e,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextWidget(
                                                                  text: "تعديل",
                                                                  color: MyTheme
                                                                      .blackColor,
                                                                ),
                                                                Icon(
                                                                  Icons.edit,
                                                                  color: MyTheme
                                                                      .blackColor,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        PopupMenuItem<String>(
                                                          value: "حذف",
                                                          child: InkWell(
                                                            onTap: () =>
                                                                controller
                                                                    .deleteBrand(
                                                              brandModel: e,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextWidget(
                                                                  text: "حذف",
                                                                  color: MyTheme
                                                                      .errorColor,
                                                                ),
                                                                Icon(
                                                                  Icons.delete,
                                                                  color: MyTheme
                                                                      .errorColor,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        e.IsActive ?? false
                                                            ? PopupMenuItem<
                                                                String>(
                                                                value:
                                                                    "إلغاء تفعيل",
                                                                child: InkWell(
                                                                  onTap: () => controller
                                                                      .changeBrandStatus(
                                                                          brandModel:
                                                                              e,
                                                                          status:
                                                                              false),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      TextWidget(
                                                                        text:
                                                                            "إلغاء تفعيل",
                                                                        color: MyTheme
                                                                            .errorColor,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: MyTheme
                                                                            .errorColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : PopupMenuItem<
                                                                String>(
                                                                value: "تفعيل",
                                                                child: InkWell(
                                                                  onTap: () => controller
                                                                      .changeBrandStatus(
                                                                          brandModel:
                                                                              e,
                                                                          status:
                                                                              true),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      TextWidget(
                                                                        text:
                                                                            "تفعيل",
                                                                        color: MyTheme
                                                                            .greenColor,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyTheme
                                                                            .greenColor,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                      ];
                                                    },
                                                    icon: Icon(
                                                      Icons.menu,
                                                      color: MyTheme.iconColor,
                                                    ), // Hamburger icon
                                                  ),
                                                ),
                                              ),
                                              brandModel: e,
                                              action: () => showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // User must tap button to close dialog
                                                builder:
                                                    (BuildContext context) {
                                                  return DialogBoxWidget(
                                                    title: "العمليات",
                                                    actions: Wrap(
                                                      children: [
                                                        SizedBox(
                                                          width: 140,
                                                          child: MyButton(
                                                            height: 40,
                                                            text: "تعديل",
                                                            action: () =>
                                                                Get.to(
                                                              () =>
                                                                  EditBrandScreen(
                                                                      brandModel:
                                                                          e),
                                                            ),
                                                            textColor: MyTheme
                                                                .mainColor,
                                                            buttonColor: MyTheme
                                                                .iconColor,
                                                            fontSize: 16,
                                                            icon: Icon(
                                                              Icons
                                                                  .edit_note_sharp,
                                                              color: MyTheme
                                                                  .mainColor,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 140,
                                                          child: MyButton(
                                                            action: () =>
                                                                Get.to(
                                                              () =>
                                                                  EditBrandScreen(
                                                                      brandModel:
                                                                          e),
                                                            ),
                                                            text: "حذف",
                                                            textColor: MyTheme
                                                                .iconColor,
                                                            buttonColor: MyTheme
                                                                .errorColor,
                                                            fontSize: 16,
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: MyTheme
                                                                  .iconColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )),
                        desktop: SizedBox(
                          height: MediaQuery.of(context).size.height - 236,
                          child: controller.loading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView(
                                  children: controller.brands!
                                      .map(
                                        (e) => BrandItem(
                                          brandModel: e,
                                          actionWidget: SizedBox(
                                            child: Directionality(
                                              textDirection: currentDirection,
                                              child: PopupMenuButton<String>(
                                                // onSelected: handleClick,
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return {'تعديل', 'حذف'}
                                                      .map((String choice) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: choice,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextWidget(
                                                            text: choice,
                                                            color: choice ==
                                                                    "حذف"
                                                                ? MyTheme
                                                                    .errorColor
                                                                : MyTheme
                                                                    .mainColor,
                                                          ),
                                                          Icon(
                                                            choice == "حذف"
                                                                ? Icons.delete
                                                                : Icons.edit,
                                                            color: choice ==
                                                                    "حذف"
                                                                ? MyTheme
                                                                    .errorColor
                                                                : MyTheme
                                                                    .mainColor,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList();
                                                },
                                                icon: Icon(
                                                  Icons.menu,
                                                  color: MyTheme.iconColor,
                                                ), // Hamburger icon
                                              ),
                                            ),
                                          ),
                                          action: () => showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // User must tap button to close dialog
                                            builder: (BuildContext context) {
                                              return DialogBoxWidget(
                                                title: "العمليات",
                                                actions: Wrap(
                                                  children: [
                                                    SizedBox(
                                                      width: 140,
                                                      child: MyButton(
                                                        action: () => Get.to(
                                                          () => EditBrandScreen(
                                                              brandModel: e),
                                                        ),
                                                        height: 40,
                                                        text: "تعديل",
                                                        textColor:
                                                            MyTheme.mainColor,
                                                        buttonColor:
                                                            MyTheme.iconColor,
                                                        fontSize: 16,
                                                        icon: Icon(
                                                          Icons.edit_note_sharp,
                                                          color:
                                                              MyTheme.mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 140,
                                                      child: MyButton(
                                                        text: "حذف",
                                                        textColor:
                                                            MyTheme.iconColor,
                                                        buttonColor:
                                                            MyTheme.errorColor,
                                                        fontSize: 16,
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color:
                                                              MyTheme.iconColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Visibility(
              visible: controller.loading.value,
              child: Container(
                decoration: BoxDecoration(
                  color: MyTheme.loadingColor,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingWidget(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
