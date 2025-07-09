import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/drawer_item.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/style_widget_controller.dart';
import 'package:nq_mall_dashboard/shared/pages.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(StyleWidgetController()),
      builder: (controller) {
        List<Widget> tabs = [
          // DrawerItem(
          //   text: 'الملف الشخصي',
          //   iconData: Icons.person,
          //   selected: controller.currentPage.value == Pages.profile,
          //   action: () => controller.changePage(currentPage: Pages.profile),
          // ),

          Visibility(
            visible: controller.userModel.admin_prevs?.any((element) =>
                    element.section!.NameEn == "categories" &&
                    element.Read == true) ??
                false,
            child: DrawerItem(
              text: 'الأصناف',
              iconData: Icons.category,
              selected: controller.currentPage.value == Pages.category,
              action: () => controller.changePage(currentPage: Pages.category),
            ),
          ),
          Visibility(
            visible: controller.userModel.admin_prevs?.any((element) =>
                    element.section!.NameEn == "brands" &&
                    element.Read == true) ??
                false,
            child: DrawerItem(
              text: 'البراندات',
              iconData: Icons.web_stories_outlined,
              selected: controller.currentPage.value == Pages.brands,
              action: () => controller.changePage(currentPage: Pages.brands),
            ),
          ),
          Visibility(
            visible: controller.userModel.admin_prevs?.any((element) =>
                    element.section!.NameEn == "products" &&
                    element.Read == true) ??
                false,
            child: DrawerItem(
              text: 'المنتجات',
              iconData: Icons.shopify_rounded,
              selected: controller.currentPage.value == Pages.products,
              action: () => controller.changePage(currentPage: Pages.products),
            ),
          ),
          // DrawerItem(
          //   text: 'المستخدمين',
          //   iconData: Icons.person,
          //   selected: controller.currentPage.value == Pages.users,
          //   action: () => controller.changePage(currentPage: Pages.users),
          // ),
          // DrawerItem(
          //   text: 'المدراء',
          //   iconData: Icons.admin_panel_settings_outlined,
          //   selected: controller.currentPage.value == Pages.admins,
          //   action: () => controller.changePage(currentPage: Pages.admins),
          // ),
          Visibility(
            visible: controller.userModel.admin_prevs?.any((element) =>
                    element.section!.NameEn == "orders" &&
                    element.Read == true) ??
                false,
            child: DrawerItem(
              text: 'الطلبات',
              iconData: Icons.shopping_cart_rounded,
              selected: controller.currentPage.value == Pages.orders,
              action: () => controller.changePage(currentPage: Pages.orders),
            ),
          ),
        ];
        return Responsive(
          mobile: Container(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 6),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: MyTheme.appBarColor,
            ),
            child: ListView(
              children: tabs,
            ),
          ),
          desktop: Container(
            width: 250,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: MyTheme.appBarColor,
            ),
            child: ListView(
              children: tabs,
            ),
          ),
        );
      },
    );
  }
}
