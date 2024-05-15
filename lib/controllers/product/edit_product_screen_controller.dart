import 'dart:async';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributes/get_product_attributes_api.dart';
import 'package:nq_mall_dashboard/apis/media/get_product_media_api.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/media_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

class EditProductScreenController extends GetxController {
  RxBool loadDetails = false.obs;
  List<MediaModel> media = [];
  List<AttributeModel> attributes = [];
  ProductModel productModel;
  EditProductScreenController({required this.productModel});
  @override
  void onInit() async {
    await loadMedia();
    await loadAttributes();
    super.onInit();
  }

  FutureOr loadMedia() async {
    loadDetails(true);
    update();
    try {
      ResponseModel responseModel =
          await GetProductMediaApi().callApi(productModel: productModel);
      if (responseModel.code == 200) {
        media = (responseModel.data as List)
            .map((e) => MediaModel.fromMap(e))
            .toList();
      }
    } catch (e) {}
    loadDetails(false);
    update();
  }

  FutureOr loadAttributes() async {
    loadDetails(true);
    update();
    try {
      ResponseModel responseModel =
          await GetProductAttributesApi().callApi(productModel: productModel);
      if (responseModel.code == 200) {
        attributes = (responseModel.data as List)
            .map(
              (e) => AttributeModel.fromMap(e),
            )
            .toList();
      }
    } catch (e) {}
    loadDetails(false);
    update();
  }
}
