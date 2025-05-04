import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/drawer_item.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
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
          DrawerItem(
            text: 'الملف الشخصي',
            iconData: Icons.person,
            selected: controller.currentPage.value == Pages.profile,
            action: () => controller.changePage(currentPage: Pages.profile),
          ),
          DrawerItem(
            text: 'الأصناف',
            iconData: Icons.category,
            selected: controller.currentPage.value == Pages.category,
            action: () => controller.changePage(currentPage: Pages.category),
          ),
          DrawerItem(
            text: 'البراندات',
            iconData: Icons.web_stories_outlined,
            selected: controller.currentPage.value == Pages.brands,
            action: () => controller.changePage(currentPage: Pages.brands),
          ),
          DrawerItem(
            text: 'المنتجات',
            iconData: Icons.shopify_rounded,
            selected: controller.currentPage.value == Pages.products,
            action: () => controller.changePage(currentPage: Pages.products),
          ),
          DrawerItem(
            text: 'المستخدمين',
            iconData: Icons.person,
            selected: controller.currentPage.value == Pages.users,
            action: () => controller.changePage(currentPage: Pages.users),
          ),
          DrawerItem(
            text: 'المدراء',
            iconData: Icons.admin_panel_settings_outlined,
            selected: controller.currentPage.value == Pages.admins,
            action: () => controller.changePage(currentPage: Pages.admins),
          ),
          DrawerItem(
            text: 'واصفات المنتج',
            iconData: Icons.attribution_rounded,
            selected: controller.currentPage.value == Pages.attributes,
            action: () => controller.changePage(currentPage: Pages.attributes),
          ),
          DrawerItem(
            text: 'التقييمات',
            iconData: Icons.category,
            selected: controller.currentPage.value == Pages.rating,
            action: () => controller.changePage(currentPage: Pages.rating),
          ),
          DrawerItem(
            text: 'سلات المشتريات',
            iconData: Icons.category,
            selected: controller.currentPage.value == Pages.cart,
            action: () => controller.changePage(currentPage: Pages.cart),
          )
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
