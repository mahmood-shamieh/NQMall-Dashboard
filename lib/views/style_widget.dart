import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/style_widget_controller.dart';
import 'package:nq_mall_dashboard/shared/pages.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';
import 'package:nq_mall_dashboard/views/brands_screen.dart';
import 'package:nq_mall_dashboard/views/category_screen.dart';
import 'package:nq_mall_dashboard/views/drawer_page.dart';
import 'package:nq_mall_dashboard/views/orders_screen.dart';
import 'package:nq_mall_dashboard/views/product_screen.dart';
import 'package:nq_mall_dashboard/views/profile_screen.dart';

class StyleWidget extends StatelessWidget {
  const StyleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getBody({Pages? pages}) {
      if (pages == Pages.brands) {
        return BrandsScreen();
      } else if (pages == Pages.category) {
        return CategoryScreen();
      } else if (pages == Pages.products) {
        return ProductScreen();
      } else if (pages == Pages.profile) {
        return ProfileScreen();
      } else if (pages == Pages.orders) {
        return OrdersScreen();
      }
      return Container(
        child: Center(
          child: TextWidget(text: "الصفحة الرئيسية"),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MyTheme.blackColor,
        appBar: AppBarWidget(
          showBackButton: false,
        ),
        drawer: DrawerPage(),
        body: GetBuilder(
          init: Get.put(
            StyleWidgetController(),
          ),
          builder: (controller) => getBody(pages: controller.currentPage.value),
        ),
      ),
    );
  }
}
