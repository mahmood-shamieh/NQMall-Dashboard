import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/order_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OrderWidget extends StatelessWidget {
  bool? isMobile;
  OrderModel orderModel;
  Widget actionWidget;
  OrderWidget(
      {super.key,
      this.isMobile,
      required this.orderModel,
      required this.actionWidget});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Container(
        width: isMobile ?? false ? 200 : 140,
        height: isMobile ?? false ? 200 : 140,
        child: CarouselSlider(
          options: CarouselOptions(height: 300.0),
          items: orderModel.orderItems?.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${Constants.mediaUrl}/${i.product?.media?.first.URL!.toUrl()}"),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
      SizedBox(
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: TextWidget(
          text: orderModel.Id.toString(),
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        // color: Colors.green,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: Visibility(
          visible: orderModel.mobile != null && orderModel.mobile!.isNotEmpty,
          child: TextWidget(
            text: orderModel.mobile ?? '',
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      SizedBox(
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: Visibility(
          visible: orderModel.Notes != null && orderModel.Notes!.isNotEmpty,
          child: TextWidget(
            text: orderModel.Notes ?? '',
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      Visibility(
        visible: orderModel.user != null,
        child: Container(
          // color: Colors.cyan,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: MyTheme.buttonsRadius,
            color: MyTheme.blackColor,
          ),
          width: isMobile ?? false
              ? MediaQuery.of(context).size.width
              : (MediaQuery.of(context).size.width / 8) + 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: "المستخدم:",
                textAlign: TextAlign.start,
                fontSize: 12,
              ),
              Divider(
                color: MyTheme.shadowColor,
                height: 10,
              ),
              TextWidget(
                text: orderModel.user!.FullName.toString(),
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.start,
              ),
              TextWidget(
                text: orderModel.user!.Email.toString(),
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.start,
              ),
              TextWidget(
                text: orderModel.user!.PhoneNumber.toString(),
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.start,
              ),
              TextWidget(
                text: orderModel.user!.Address.toString(),
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: Container(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green,
          ),
          child: TextWidget(
            text: orderModel.orderStatus != null
                ? orderModel.orderStatus!.NameAr.toString()
                : "",
            textAlign: TextAlign.center,
            color: MyTheme.iconColor,
          ),
        )),
      ),
      actionWidget
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: isMobile ?? false ? null : null,
      decoration: BoxDecoration(
          color: MyTheme.appBarColor,
          border: Border.all(
            color: MyTheme.shadowColor,
            width: 0.6,
          ),
          borderRadius: BorderRadius.circular(
            10,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isMobile ?? false
            ? Column(
                // alignment: WrapAlignment.spaceBetween,
                children: items,
              )
            : Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: items,
              ),
      ),
    );
  }
}
