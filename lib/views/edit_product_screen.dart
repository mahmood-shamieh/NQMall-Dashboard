import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/product/edit_product_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';

import '../shared/theme.dart';

class EditProductScreen extends StatelessWidget {
  ProductModel productModel;
  EditProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductScreenController>(
      init: Get.put(
        EditProductScreenController(productModel: productModel),
      ),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
          body: controller.loadDetails.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: ListBody(
                    children: [
                      TextWidget(
                        text: controller.media
                            .map((e) => e.toString())
                            .toList()
                            .toString(),
                      ),
                      TextWidget(
                        text: controller.attributes
                            .map((e) => e.toString())
                            .toList()
                            .toString(),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
