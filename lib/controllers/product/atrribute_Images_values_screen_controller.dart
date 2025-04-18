import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/add_attribute_Image_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/add_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/delete_attribute_image_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/delete_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/edit_attribute_image_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/edit_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/get_attribute_values_api.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/models/value_model.dart';

class AttributeImagesValuesScreenController extends GetxController {
  late AttributeModel attributeModel;
  RxBool loadDetails = false.obs;
  RxBool showAddDialog = false.obs;
  List<ValueModel> values = [];
  List<ValueModel> valuesToDelete = [];
  Map<int, Map<String, Uint8List>> valuesImages = {};
  Uint8List? newValueAr;
  Uint8List? newValueEn;
  Uint8List? imageAr;
  Uint8List? imageEn;
  AttributeImagesValuesScreenController({required this.attributeModel});
  @override
  void onInit() async {
    await loadValues();
  }

  void chooseImageForValue(
      {required ValueModel valueModel, required String tag}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        if (valuesImages[valueModel.Id ?? 0] == null) {
          valuesImages[valueModel.Id ?? 0] = {};
        }
        valuesImages[valueModel.Id ?? 0]![tag] = uploadFile;
      }

      update();
    } else {}
  }

  showAddDialogFunction() {
    showAddDialog(!showAddDialog.value);
    update();
  }

  addValueToDelete({required ValueModel valueModel}) {
    if (valuesToDelete.contains(valueModel)) {
      valuesToDelete.remove(valueModel);
    } else {
      valuesToDelete.add(valueModel);
    }
    update();
  }

  bool showSaveEditsButton() {
    bool visible = false;

    return visible || valuesImages.isNotEmpty;
  }

  FutureOr loadValues() async {
    loadDetails(true);
    update();
    try {
      ResponseModel responseModel =
          await GetAttributeValuesApi().callApi(attributeModel: attributeModel);
      if (responseModel.code == 200) {
        values = (responseModel.data as List)
            .map((e) => ValueModel.fromMap(e))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    loadDetails(false);
    update();
  }

  FutureOr addImageValueAction() async {
    loadDetails(true);
    update();
    try {
      ResponseModel responseModel = await AddAttributeImageValueApi().callApi(
          attributeModel: attributeModel,
          imageAr: newValueAr,
          imageEn: newValueEn,
          hoverImageAr: imageAr,
          hoverImageEn: imageEn);
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

  FutureOr deleteAttributeValueAction() async {
    loadDetails(true);
    update();
    valuesToDelete.forEach((element) async {
      try {
        ResponseModel responseModel =
            await DeleteAttributeImageValueApi().callApi(
          valueModel: element,
        );
        if (responseModel.code == 200) {
          valuesToDelete.remove(element);
        }
      } catch (e) {
        print(e);
      }
    });
    onInit();
    loadDetails(false);
    update();
  }

  FutureOr editAttributeValueAction() async {
    loadDetails(true);
    update();
    values.forEach((element) async {
      // print("object");
      try {
        ResponseModel responseModel = await EditAttributeImageValueApi()
            .callApi(
                attributeModel: attributeModel,
                valueModel: element.copyWith(),
                valueAr: valuesImages[element.Id]?['ValueAr'],
                valueEn: valuesImages[element.Id]?['ValueEn'],
                hoverImageAr: valuesImages[element.Id]?['HoverImageAr'],
                hoverImageEn: valuesImages[element.Id]?['HoverImageEn']);
        print(responseModel);
        if (responseModel.code == 200) {}
      } catch (e) {
        print(e);
      }
    });
    values.clear();
    valuesImages.clear();
    valuesToDelete.clear();
    await Future.delayed(Durations.extralong4, () => onInit());
    showSaveEditsButton();
    loadDetails(false);
    update();
  }

  chooseImageForNewValue({required String tag}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        switch (tag) {
          case 'ValueAr':
            newValueAr = uploadFile;
            break;
          case 'ValueEn':
            newValueEn = uploadFile;
            break;
          case 'HoverImageAr':
            imageAr = uploadFile;
            break;
          case 'HoverImageEn':
            imageEn = uploadFile;
            break;
          default:
        }
      }

      update();
    } else {}
  }
}
