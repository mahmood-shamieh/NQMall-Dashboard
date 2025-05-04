import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/shadow_container.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/product/product_attributes_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/product/product_pricing_screen_controller.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../main.dart';
import '../shared/constant.dart';

class ProductPricingScreen extends StatelessWidget {
  ProductModel productModel;
  ProductPricingScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(ProductPricingScreenController(productModel: productModel)),
      builder: (controller) {
        // controller.buildTreeAction();
        return Directionality(
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
            // floatingActionButton: InkWell(
            //   child: Container(
            //     padding: const EdgeInsets.all(14),
            //     margin: const EdgeInsets.only(left: 4),
            //     decoration: BoxDecoration(
            //         color: MyTheme.blueColor, shape: BoxShape.circle),
            //     child: Icon(
            //       Icons.add,
            //       color: MyTheme.textBlackColor,
            //     ),
            //   ),
            // ),
            body: controller.loadDetails.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      // TextWidget(text: controller.)
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                ...controller.allCombinations
                                    .map((e) => ShadowContainer(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          widget: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: TextWidget(
                                                  text: controller.productModel
                                                          .NameAr ??
                                                      '',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextWidget(
                                                text: "المواصفات: ",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                              Row(
                                                children: e
                                                    .map(
                                                      (valueModel) => Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 6,
                                                          vertical: 2,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              MyTheme.blueColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: valueModel.type
                                                                    .toString()
                                                                    .toLowerCase()
                                                                    .toLowerCase() ==
                                                                'images'
                                                            ? Container(
                                                                height: 40,
                                                                child: Image(
                                                                  image: NetworkImage(
                                                                      "${Constants.mediaUrl}/${(valueModel.ValueAr).toString().toUrl()}"),
                                                                ),
                                                              )
                                                            : TextWidget(
                                                                text: valueModel
                                                                        .ValueAr ??
                                                                    '',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                      child: Column(
                                                        children: [
                                                          TextWidget(
                                                            text: "الكمية",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          TextFieldWidget(
                                                            hintText: "الكمية",
                                                            controller: controller
                                                                .quantityAndPrice
                                                                .elementAt(controller
                                                                    .allCombinations
                                                                    .indexOf(
                                                                        e))['quantity'],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30,
                                                      child: Column(
                                                        children: [
                                                          TextWidget(
                                                            text: "السعر",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          TextFieldWidget(
                                                            hintText: "السعر",
                                                            controller: controller
                                                                .quantityAndPrice
                                                                .elementAt(controller
                                                                    .allCombinations
                                                                    .indexOf(
                                                                        e))['price'],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                const SizedBox(
                                  height: 140,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 10,
                      //   child: Column(
                      //     children: [
                      //       Visibility(
                      //         visible: controller.valuesToDelete.isNotEmpty,
                      //         child: SizedBox(
                      //           width: MediaQuery.of(context).size.width,
                      //           child: Center(
                      //             child: MyButton(
                      //               action: () =>
                      //                   controller.deleteAttributeValueAction(),
                      //               margin: const EdgeInsets.symmetric(
                      //                   horizontal: 10),
                      //               height: 60,
                      //               width: MediaQuery.of(context).size.width,
                      //               text: "حذف",
                      //               buttonColor: MyTheme.blueColor,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                      //       ,
                      //     ],
                      //   ),
                      // ),
                      Positioned(
                        bottom: 20,
                        left: 10,
                        child: MyButton(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 60,
                          text: 'حفظ الأسعار',
                          buttonColor: MyTheme.blueColor,
                          action: () => controller.priceProduct(),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
