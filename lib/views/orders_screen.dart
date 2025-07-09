import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/brand_item.dart';
import 'package:nq_mall_dashboard/components/loading_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/order_widget.dart';
import 'package:nq_mall_dashboard/components/product_item.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/brand/brand_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/order/order_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/product/product_screen_controller.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';
import 'package:nq_mall_dashboard/views/add_product_screen.dart';
import 'package:nq_mall_dashboard/views/edit_brand_screen.dart';
import 'package:nq_mall_dashboard/views/edit_order_screen.dart';
import 'package:nq_mall_dashboard/views/edit_product_screen.dart';
import 'package:nq_mall_dashboard/views/product_attributes_screen.dart';
import 'package:nq_mall_dashboard/views/product_pricing_screen.dart';

import '../components/dialog_box.dart';
import '../components/text_field_widget.dart';
import '../main.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersScreenController>(
      init: Get.put(OrdersScreenController()),
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
                            Icons.shopping_cart_rounded,
                            color: MyTheme.iconColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const TextWidget(text: 'الطلبات')
                        ],
                      ),
                      MyButton(
                        width: 100,
                        height: 40,
                        action: () => controller.refreshStatusAction(),
                        buttonColor: MyTheme.blueColor,
                        text: 'تحديث',
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        margin: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.refresh,
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
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 4),
                              child: TextWidget(
                                text: "فلترة الطلبات:",
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 155,
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
                            child: controller.orders!.isEmpty
                                ? Center(
                                    child: TextWidget(text: "لا يوجد طلبات"),
                                  )
                                : NotificationListener<ScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification
                                              is ScrollEndNotification &&
                                          notification.metrics.extentAfter ==
                                              0) {
                                        controller.getOrderNextPage();
                                      }
                                      return false;
                                    },
                                    child: ListView(
                                      controller: controller.scrollController,
                                      children: controller.orders!
                                          .map(
                                            (e) => OrderWidget(
                                              isMobile: true,
                                              actionWidget: SizedBox(
                                                child: Directionality(
                                                  textDirection:
                                                      currentDirection,
                                                  child:
                                                      PopupMenuButton<String>(
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return [
                                                        PopupMenuItem<String>(
                                                          value: "تعديل",
                                                          child: InkWell(
                                                            onTap: () => Get.to(
                                                              () =>
                                                                  EditOrderScreen(
                                                                orderModel: e,
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
                                                      ];
                                                    },
                                                    icon: Icon(
                                                      Icons.menu,
                                                      color: MyTheme.iconColor,
                                                    ), // Hamburger icon
                                                  ),
                                                ),
                                              ),
                                              orderModel: e,
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
                              : NotificationListener<ScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification is ScrollEndNotification ||
                                        notification
                                            is UserScrollNotification) {
                                      final metrics = notification.metrics;
                                      if (metrics.pixels ==
                                          metrics.maxScrollExtent) {
                                        controller.getOrderNextPage();
                                      }
                                    }
                                    return false;
                                  },
                                  child: ListView(
                                    controller: controller.scrollController,
                                    children: controller.orders!
                                        .map(
                                          (e) => OrderWidget(
                                            orderModel: e,
                                            isMobile: false,
                                            actionWidget: SizedBox(
                                              child: Directionality(
                                                textDirection: currentDirection,
                                                child: PopupMenuButton<String>(
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      PopupMenuItem<String>(
                                                        value: "تعديل",
                                                        child: InkWell(
                                                          onTap: () => Get.to(
                                                            () =>
                                                                EditOrderScreen(
                                                              orderModel: e,
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
                                                    ];
                                                  },
                                                  icon: Icon(
                                                    Icons.menu,
                                                    color: MyTheme.iconColor,
                                                  ), // Hamburger icon
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
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
