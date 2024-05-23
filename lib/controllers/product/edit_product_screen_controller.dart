import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributes/get_product_attributes_api.dart';
import 'package:nq_mall_dashboard/apis/media/get_product_media_api.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/media_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

class EditProductScreenController extends GetxController {
  RxBool loadDetails = false.obs;
  RxString currentLanguages =
      currentDirection == TextDirection.rtl ? 'ar'.obs : 'en'.obs;
  List<MediaModel> media = [];
  List<AttributeModel> attributes = [];
  ProductModel productModel;
  List<MediaModel> imageToDelete = [];
  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  // TextEditingController salePrice = TextEditingController();
  EditProductScreenController({required this.productModel});
  @override
  void onInit() async {
    fillFields();
    await loadMedia();
    await loadAttributes();
    super.onInit();
  }

  fillFields() {
    nameAr.text = productModel.NameAr ?? '';
    nameEn.text = productModel.NameEn ?? '';
    descriptionAr.text = productModel.DescriptionAr ?? '';
    descriptionEn.text = productModel.DescriptionEn ?? '';
    price.text = productModel.Price.toString();
    salePrice.text = productModel.SalePrice.toString();
  }

  void addMediaToImageToDelete({required MediaModel media}) {
    if (imageToDelete.contains(media)) {
      imageToDelete.remove(media);
    } else {
      imageToDelete.add(media);
    }
    update();
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

  changeViewLanguages() {
    if (currentLanguages.value == 'ar') {
      currentLanguages('en');
      currentDirection = TextDirection.ltr;
    } else {
      currentLanguages('ar');
      currentDirection = TextDirection.rtl;
    }
    update();
  }
}
