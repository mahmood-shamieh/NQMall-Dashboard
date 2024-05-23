import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';

class EditTextAttributesScreenController extends GetxController {
  late List<AttributeModel> currentAttributes;
  List<AttributeModel> deletedAttributes = [];
  List<Map<String, TextEditingController>> textAttributes = [];
  Map<int, List<Map<String, dynamic>>> textAttributesValues = {};
  EditTextAttributesScreenController({required this.currentAttributes});
  void addToAttributesToDelete({required AttributeModel attributeModel}) {
    if (deletedAttributes.contains(attributeModel)) {
      deletedAttributes.remove(attributeModel);
    } else {
      deletedAttributes.add(attributeModel);
    }
    update();
  }

  addTextAttribute() {
    Map<String, TextEditingController> data = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    textAttributes.add(data);
    update();
  }

  void addTextAttributeValue({required int attributeHashCode}) {
    Map<String, dynamic> dataValue = {
      "valueAr": TextEditingController(),
      "valueEn": TextEditingController(),
      "imageByte": null,
    };

    if (textAttributesValues[attributeHashCode] == null) {
      textAttributesValues[attributeHashCode] = [];
    }
    textAttributesValues[attributeHashCode]!.add(dataValue);
    update();
  }

  deleteTextAttribute(Map<String, TextEditingController> data) {
    textAttributes.remove(data);
    update();
  }

  void chooseImageForTextAttribute(
      {required int attributeHashCode,
      required int attributeValueHashCode}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        textAttributesValues[attributeHashCode]!
            .where((element) => element.hashCode == attributeValueHashCode)
            .first['imageByte'] = uploadFile;
      }

      update();
    } else {}
  }

  deleteTextAttributeValue(
      {required Map<String, dynamic> data, required int attributeHashCode}) {
    textAttributesValues[attributeHashCode]!.remove(data);
    update();
  }
}
