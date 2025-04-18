import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';

class EditProductAttributeScreenController extends GetxController {
  late ProductModel productModel;
  EditProductAttributeScreenController({required this.productModel});

  List<Map<String, TextEditingController>> attributesAr = [];
  List<Map<String, TextEditingController>> attributesEn = [];

  @override
  void onInit() {
    for (var i = 0; i < productModel.DetailsAr!.entries.length; i++) {
      TextEditingController name = TextEditingController();      
      TextEditingController value = TextEditingController();
      name.text = productModel.DetailsAr!.entries.elementAt(i).key;
      value.text = productModel.DetailsAr!.entries.elementAt(i).value;
      Map<String, TextEditingController> data = {
        "name": name,
        "value": value,
      };
      attributesAr.add(data);
    }
    for (var i = 0; i < productModel.DetailsEn!.entries.length; i++) {
      TextEditingController name = TextEditingController();
      TextEditingController value = TextEditingController();
      name.text = productModel.DetailsEn!.entries.elementAt(i).key;
      value.text = productModel.DetailsEn!.entries.elementAt(i).value;
      Map<String, TextEditingController> data = {
        "name": name,
        "value": value,
      };
      attributesEn.add(data);
    }
    super.onInit();
  }
  void addAttributeAr() {
    Map<String, TextEditingController> data = {
      "name": TextEditingController(),
      "value": TextEditingController(),
    };
    attributesAr.add(data);
    update();
  }
  void addAttributeEn() {
    Map<String, TextEditingController> data = {
      "name": TextEditingController(),
      "value": TextEditingController(),
    };
    attributesEn.add(data);
    update();
  }
  void deleteAttributeAr(Map<String, TextEditingController> data) {
    attributesAr.remove(data);

    update();
  }
  void deleteAttributeEn(Map<String, TextEditingController> data) {
    attributesEn.remove(data);

    update();
  }
}
