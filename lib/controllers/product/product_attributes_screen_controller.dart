import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributes/add_text_attribute_api.dart';
import 'package:nq_mall_dashboard/apis/attributes/delete_Attribute_api.dart';
import 'package:nq_mall_dashboard/apis/attributes/edit_text_attribute_api.dart';
import 'package:nq_mall_dashboard/apis/attributes/get_product_attributes_api.dart';
import 'package:nq_mall_dashboard/apis/media/get_product_media_api.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/media_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/shared/attribute_types.dart';

class ProductAttributesScreenController extends GetxController {
  RxBool loadDetails = false.obs;
  late List<AttributeModel> attributes = [];
  Map<int, Map<String, TextEditingController>>
      attributesTextEditingControllers = {};
  late List<AttributeModel> attributesToDelete = [];
  ProductModel productModel;
  TextEditingController newAttributeNameAr = TextEditingController();
  TextEditingController newAttributeNameEn = TextEditingController();
  // List attributesType = ['list', 'items', 'images'];
  Rx<AttributeTypes> selectedAttributeType = (AttributeTypes.List).obs;
  RxBool showAddDialog = false.obs;

  // TextEditingController salePrice = TextEditingController();
  ProductAttributesScreenController({required this.productModel});
  @override
  void onInit() async {
    // print(productModel);
    // fillFields();
    await loadAttributes();
    attributes.forEach((element) {
      TextEditingController nameArController =
          TextEditingController(text: element.NameAr);
      TextEditingController nameEnController =
          TextEditingController(text: element.NameEn);
      nameArController.addListener(() {
        showSaveEditsButton();
        update();
      });
      nameEnController.addListener(() {
        showSaveEditsButton();
        update();
      });
      attributesTextEditingControllers[element.Id ?? 0] = {
        "NameAr": nameArController,
        "NameEn": nameEnController,
      };
    });
    // await loadAttributes();
    super.onInit();
  }

  showAddDialogFunction() {
    showAddDialog(!showAddDialog.value);
    update();
  }

  // fillFields() {
  //   nameAr.text = productModel.NameAr ?? '';
  //   nameEn.text = productModel.NameEn ?? '';
  //   descriptionAr.text = productModel.DescriptionAr ?? '';
  //   descriptionEn.text = productModel.DescriptionEn ?? '';
  //   price.text = productModel.Price.toString();
  //   salePrice.text = productModel.SalePrice.toString();
  // }
  addAttributesToDelete({required AttributeModel attributeModel}) {
    if (attributesToDelete.contains(attributeModel)) {
      attributesToDelete.remove(attributeModel);
    } else {
      attributesToDelete.add(attributeModel);
    }
    update();
  }

  setSelectedAttributesType({required AttributeTypes type}) {
    selectedAttributeType(type);
    // print(selectedAttributeType.value.name);
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
            .map((e) => AttributeModel.fromMap(e))
            .toList();
      }
    } catch (e) {}
    loadDetails(false);
    update();
  }

  FutureOr addNewAttribute() async {
    loadDetails(true);
    update();
    try {
      ResponseModel responseModel = await AddTextAttributeApi().callApi(
          productModel: productModel,
          attributeModel: AttributeModel(
            NameAr: newAttributeNameAr.text.trim(),
            NameEn: newAttributeNameEn.text.trim(),
            Type: selectedAttributeType.value.name.toString(),
          ));
      if (responseModel.code == 200) {
        onInit();
        showAddDialogFunction();
      }
    } catch (e) {
      print(e);
    }
    loadDetails(false);
    update();
  }

  FutureOr sendAttributesToDeleteApi() async {
    loadDetails(true);
    update();
    attributesToDelete.forEach((element) async {
      try {
        ResponseModel responseModel =
            await DeleteAttributeApi().callApi(attributeModel: element);
        if (responseModel.code == 200) {
          attributesToDelete.remove(element);
        }
      } catch (e) {}
    });
    // attributesToDelete.clear();
    loadDetails(false);
    update();
    onInit();
  }

  FutureOr sendAttributesToEditApi() async {
    loadDetails(true);
    update();
    attributes.forEach((element) async {
      try {
        ResponseModel responseModel = await EditTextAttributeApi().callApi(
          attributeModel: element.copyWith(
              NameAr: attributesTextEditingControllers[element.Id]!["NameAr"]!
                  .text
                  .trim(),
              NameEn: attributesTextEditingControllers[element.Id]!["NameEn"]!
                  .text
                  .trim()),
          productModel: productModel,
        );
        if (responseModel.code == 200) {}
      } catch (e) {
        print(e);
      }
    });
    onInit();
    loadDetails(false);
    update();
  }

  bool showSaveEditsButton() {
    bool visible = false;
    attributes.forEach((element) {
      visible = element.NameAr !=
              attributesTextEditingControllers[element.Id]!["NameAr"]!
                  .text
                  .trim() ||
          element.NameEn !=
              attributesTextEditingControllers[element.Id]!["NameEn"]!
                  .text
                  .trim();
    });

    return visible;
  }

  // FutureOr loadAttributes() async {
  //   loadDetails(true);
  //   update();
  //   try {
  //     ResponseModel responseModel =
  //         await GetProductAttributesApi().callApi(productModel: productModel);
  //     if (responseModel.code == 200) {
  //       attributes = (responseModel.data as List)
  //           .map(
  //             (e) => AttributeModel.fromMap(e),
  //           )
  //           .toList();
  //     }
  //   } catch (e) {}
  //   loadDetails(false);
  //   update();
  // }
}
