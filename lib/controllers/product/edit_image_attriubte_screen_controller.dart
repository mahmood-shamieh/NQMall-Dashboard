import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';

class EditImageAttributeScreenController extends GetxController {
  late List<AttributeModel> currentAttributes;
  List<AttributeModel> deletedAttribute = [];
  List<Map<String, TextEditingController>> imageAttributes = [];
  Map<int, List<Map<String, dynamic>>> imageAttributesValues = {};
  EditImageAttributeScreenController({required this.currentAttributes});
  addImageAttribute() {
    Map<String, TextEditingController> data = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    imageAttributes.add(data);

    update();
  }

  void addImageAttributeValue({required int attributeHashCode}) {
    Map<String, dynamic> dataValue = {
      "imageByteAr": null,
      "imageByteEn": null,
      "imageByte": null,
    };
    if (imageAttributesValues[attributeHashCode] == null) {
      imageAttributesValues[attributeHashCode] = [];
    }
    imageAttributesValues[attributeHashCode]!.add(dataValue);
    update();
  }

  deleteImageAttribute(Map<String, TextEditingController> data) {
    imageAttributes.remove(data);
    update();
  }

  deleteImageAttributeValue(
      {required Map<String, dynamic> data, required int attributeHashCode}) {
    imageAttributesValues[attributeHashCode]!.remove(data);
    update();
  }

  void chooseImageForImageAttribute(
      {required int attributeHashCode,
      required int attributeValueHashCode,
      required String key}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        imageAttributesValues[attributeHashCode]!
            .where((element) => element.hashCode == attributeValueHashCode)
            .first[key] = uploadFile;
      }

      update();
    } else {}
  }

  void addToAttributesToDelete({required AttributeModel attributeModel}) {
    if (deletedAttribute.contains(attributeModel)) {
      deletedAttribute.remove(attributeModel);
    } else {
      deletedAttribute.add(attributeModel);
    }
    update();
  }
}
