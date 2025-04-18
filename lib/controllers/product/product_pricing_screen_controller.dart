import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributes/get_product_attributes_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/add_attribute_Image_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/add_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/delete_attribute_image_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/delete_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/edit_attribute_image_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/edit_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/get_attribute_values_api.dart';
import 'package:nq_mall_dashboard/apis/product/pricing_product_api.dart';
import 'package:nq_mall_dashboard/models/tree.dart';
import 'package:nq_mall_dashboard/models/tree_node.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/models/value_model.dart';

class ProductPricingScreenController extends GetxController {
  late ProductModel productModel;
  RxBool loadDetails = false.obs;
  List<AttributeModel> attributes = [];
  Rx<String> data = Rx('');
  List<List<ValueModel>> allCombinations = [];
  List<Map<String, TextEditingController>> quantityAndPrice = [];
  ProductPricingScreenController({required this.productModel});
  @override
  void onInit() async {
    await loadValues();
    buildTreeAction();
  }

  bool showSaveEditsButton() {
    bool visible = false;

    return visible;
  }

  FutureOr loadValues() async {
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
    } catch (e) {
      print(e);
    }
    loadDetails(false);
    update();
  }

  void buildTreeAction() {
    List<AttributeModel> tempAttributes = List.from(attributes);

    List<List<ValueModel>> values = tempAttributes
        .map((e) => (e.values ?? [])
            .map((value) => value.copyWith(type: e.Type))
            .toList())
        .toList();
    TreeNode root = TreeNode(data: ValueModel(ValueAr: ''));
    buildTree(root, values, 0);

    // print("-------------------------------");
    for (TreeNode child in root.children) {
      generateCombinations(child, [], allCombinations);
    }
    int i = 1;
    for (var combination in allCombinations) {
      quantityAndPrice.add({
        "quantity": TextEditingController(text: i.toString()),
        "price": TextEditingController(text: i.toString())
      });
      i++;
    }
  }

  void buildTree(TreeNode root, List<List<ValueModel>> values, int level) {
    if (level >= attributes.length) return;

    for (ValueModel value in values.elementAt(level)) {
      TreeNode child = TreeNode(data: value);
      root.addChild(child);
      buildTree(child, values, level + 1);
    }
  }

  generateCombinations(TreeNode root, List<ValueModel> currentCombination,
      List<List<ValueModel>> allCombinations) {
    currentCombination.add(root.data);
    if (root.children.isEmpty) {
      allCombinations.add(List.from(currentCombination));
    } else {
      for (TreeNode child in root.children) {
        generateCombinations(child, currentCombination, allCombinations);
      }
    }
    currentCombination.removeLast();
  }

  FutureOr priceProduct() async {
    loadDetails(true);
    update();
    try {
      List<Map> temp = [];
      for (var i = 0; i < allCombinations.length; i++) {
        temp.add({
          "valueId": allCombinations.elementAt(i).map((e) => e.Id).toList(),
          "variation": {
            "Price": quantityAndPrice.elementAt(i)['quantity']!.text,
            "Stock": quantityAndPrice.elementAt(i)['price']!.text,
            "productId": productModel.Id
          }
        });
      }
      ResponseModel responseModel =
          await PricingProductApi().callApi(variationsWithValues: temp);
      if (responseModel.code == 200) {
        print(responseModel);
      }
    } catch (e) {
      print(e);
    }
    loadDetails(false);
    update();
  }
}
