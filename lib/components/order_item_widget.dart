import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/models/order_item_model.dart';
import 'package:nq_mall_dashboard/models/order_model.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItemModel orderItem;
  const OrderItemWidget({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyTheme.appBarColor,
        borderRadius: MyTheme.buttonsRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (orderItem.product?.media != null &&
              orderItem.product!.media!.isNotEmpty)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: MyTheme.buttonsRadius,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${Constants.mediaUrl}/${orderItem.product!.media!.first.URL!.toUrl()}",
                  ),
                ),
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: orderItem.product?.NameAr ?? "منتج غير معروف",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.right,
                ),
                TextWidget(
                  text: "الكمية: ${orderItem.Quantity}",
                  fontSize: 14,
                  textAlign: TextAlign.right,
                ),
                TextWidget(
                  text:
                      "السعر المفرد: ${double.parse(orderItem.Price.toString()).toInt()}",
                  fontSize: 14,
                  textAlign: TextAlign.right,
                ),
                TextWidget(
                  text:
                      "السعر الإجمالي: ${(double.parse(orderItem.Price.toString()) * double.parse(orderItem.Quantity.toString())).toInt()}",
                  fontSize: 14,
                  textAlign: TextAlign.right,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TextWidget(
                      text: "التشكيلة: ",
                      fontSize: 14,
                      textAlign: TextAlign.right,
                    ),
                    ...(orderItem.variation != null
                        ? (orderItem.variation!.Values ?? [])
                            .map((e) => e.attribute!.Type == "images"
                                ? Container(
                                    height: 40,
                                    width: 100,
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyTheme.borderColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${Constants.mediaUrl}/${e.ValueAr!.toUrl()}")),
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyTheme.blackColor,
                                    ),
                                  )
                                : FittedBox(
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      // width: 120,
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: MyTheme.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyTheme.blackColor),
                                      child: Center(
                                        child: TextWidget(
                                          text: e.ValueAr ?? "",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ))
                            .toList()
                        : [
                            Container(),
                          ])
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
