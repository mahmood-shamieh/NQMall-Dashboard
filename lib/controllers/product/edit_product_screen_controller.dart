import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributes/get_product_attributes_api.dart';
import 'package:nq_mall_dashboard/apis/media/delete_media_api.dart';
import 'package:nq_mall_dashboard/apis/media/get_product_media_api.dart';
import 'package:nq_mall_dashboard/apis/product/update_product_api.dart';
import 'package:nq_mall_dashboard/controllers/product/product_screen_controller.dart';
import 'package:nq_mall_dashboard/exception/connection_time_out.dart';
import 'package:nq_mall_dashboard/exception/un_defined_problem.dart';
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
    // print(productModel);
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

  Future deleteMedia() async {
    loadDetails(true);
    update();
    for (MediaModel element in imageToDelete) {
      try {
        ResponseModel responseModel =
            await DeleteMediaApi().callApi(mediaModel: element);
        if (responseModel.code == 200) {
          attributes = (responseModel.data as List)
              .map(
                (e) => AttributeModel.fromMap(e),
              )
              .toList();
        } else {
          return;
        }
      } catch (e) {}
    }
    loadDetails(false);
    update();
  }

  updateProductDetails() async {
    try {
      loadDetails(true);
      update();
      ResponseModel responseModel = await UpdateProductApi().callApi(
        productModel: productModel.copyWith(
            NameAr: nameAr.text.trim(),
            NameEn: nameEn.text.trim(),
            DescriptionAr: descriptionAr.text.trim(),
            DescriptionEn: descriptionEn.text.trim(),
            Price: int.parse(price.text.trim()),
            SalePrice: int.parse(salePrice.text.trim()),
            media: []),
      );
      loadDetails(false);
      update();
      if (responseModel.code == 200) {
        Get.back();
        ProductScreenController productScreenController =
            Get.find<ProductScreenController>();
        productScreenController.onInit();
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  changeViewLanguages({required String lang}) {
    currentLanguages(lang);
    if (currentLanguages.value == 'ar') {
      currentDirection = TextDirection.rtl;
    } else {
      currentDirection = TextDirection.ltr;
    }
    update();
  }

  editProductOperation() async {
    await deleteMedia();
    await updateProductDetails();
  }
}
