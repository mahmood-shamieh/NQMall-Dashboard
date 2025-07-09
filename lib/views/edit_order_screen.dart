import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/image_can_be_deleted_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/order_item_widget.dart';
import 'package:nq_mall_dashboard/components/text_attributes_widget.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/order/edit_order_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/product/edit_product_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/image_attribute_Widget.dart';
import 'package:nq_mall_dashboard/models/order_model.dart';
import 'package:nq_mall_dashboard/models/order_status_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/views/edit_image_attribute_screen.dart';
import 'package:nq_mall_dashboard/views/edit_product_attributes_screen.dart';
import 'package:nq_mall_dashboard/views/edit_text_attributes_scree.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/constant.dart';
import '../shared/theme.dart';

class EditOrderScreen extends StatelessWidget {
  OrderModel orderModel;
  EditOrderScreen({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    const double elementSpacing = 10;
    const double smallElementSpacing = 4;
    return GetBuilder<EditOrderScreenController>(
      init: Get.put(
        EditOrderScreenController(orderModel: orderModel),
      ),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
          body: controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: "تغيير حالة الطلب:",
                          fontSize: 16,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<OrderStatusModel>(
                            isExpanded: true,
                            barrierDismissible: true,
                            alignment: AlignmentDirectional.center,
                            isDense: true,
                            hint: const SizedBox(
                              width: double.infinity,
                              child: TextWidget(
                                text: "إختر الحالة",
                                fontSize: 12,
                                textAlign: TextAlign.right,
                                fontWeight: FontWeight.w300,
                              ),
                            ),

                            items: controller.orderStatuses!
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: TextWidget(
                                                  text: item.NameAr ?? '',
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: controller.selectedOrderStatus.value,
                            onChanged: (value) => controller.chooseOrderStatus(
                                orderStatus: value!),
                            style: MyTheme.getTextStyle1(
                              color: MyTheme.mainColor,
                            ),
                            barrierColor: MyTheme.appBarColor.withOpacity(
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
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 50,

                              // width: 200,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              // maxHeight: 200,
                              decoration: BoxDecoration(
                                color: MyTheme.appBarColor,
                                borderRadius: MyTheme.buttonsRadius,
                              ),
                              direction: DropdownDirection.textDirection,
                              isFullScreen: true,
                              useSafeArea: true,
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              // height: 40,

                              selectedMenuItemBuilder: (context, child) =>
                                  Container(
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
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      child: child,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController:
                                  controller.orderStatusSearchController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Directionality(
                                textDirection: currentDirection,
                                child: TextFieldWidget(
                                  margin: MyTheme.padding,
                                  hintText: "البحث داخل الحالات",
                                  controller:
                                      controller.orderStatusSearchController,
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
                                controller.orderStatusSearchController.clear();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const TextWidget(
                          text: "ملاحظات المدير:",
                          fontSize: 16,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFieldWidget(
                          controller: controller.responseNotesController,
                          hintText: "ادخل ملاحظات المدير",
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const TextWidget(
                              text: "الحالة القديمة:",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.right,
                            ),
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: TextWidget(
                                text: orderModel.orderStatus != null
                                    ? orderModel.orderStatus!.NameAr.toString()
                                    : "",
                                textAlign: TextAlign.center,
                                color: MyTheme.iconColor,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: orderModel.mobile != null &&
                              orderModel.mobile!.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  text: "رقم الموبايل:",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.right,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyTheme.appBarColor,
                                    borderRadius: MyTheme.buttonsRadius,
                                  ),
                                  child: TextWidget(
                                    text: orderModel.mobile.toString(),
                                    fontSize: 18,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: orderModel.Notes != null &&
                              orderModel.Notes!.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  text: "ملاحظات المستخدم:",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.right,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyTheme.appBarColor,
                                    borderRadius: MyTheme.buttonsRadius,
                                  ),
                                  child: TextWidget(
                                    text: orderModel.Notes.toString(),
                                    fontSize: 18,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const TextWidget(
                          text: "تفاصيل المنتجات:",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.right,
                        ),
                        ...(controller.orderModel.orderItems ?? [])
                            .map((e) => OrderItemWidget(orderItem: e))
                            .toList(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyTheme.appBarColor,
                            borderRadius: MyTheme.buttonsRadius,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text:
                                    "تاريخ الطلب: ${orderModel.CreatedAt?.toString() ?? 'غير متوفر'}",
                                fontSize: 14,
                                textAlign: TextAlign.right,
                              ),
                              TextWidget(
                                text:
                                    "آخر تحديث: ${orderModel.UpdatedAt?.toString() ?? 'غير متوفر'}",
                                fontSize: 14,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: MyTheme.appBarColor,
                            borderRadius: MyTheme.buttonsRadius,
                          ),
                          child: TextWidget(
                            text:
                                "إجمالي الطلب: ${orderModel.orderItems?.fold<double>(
                                      0,
                                      (sum, item) =>
                                          sum +
                                          (double.parse(item.Price ?? '0') *
                                              (item.Quantity ?? 0)),
                                    ).toInt() ?? 0}",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: MyButton(
                              text: "حفظ التغييرات",
                              height: 50,
                              fontSize: 16,
                              action: () => controller.updateOrderStatus(),
                              textColor: MyTheme.iconColor,
                              buttonColor: MyTheme.blueColor,
                              icon: Icon(
                                Icons.save,
                                color: MyTheme.iconColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
