import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/add_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/delete_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/edit_attribute_text_value_api.dart';
import 'package:nq_mall_dashboard/apis/attributesValues/get_attribute_values_api.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/models/value_model.dart';

class AttributeValuesScreenController extends GetxController {
  late AttributeModel attributeModel;
  RxBool loadDetails = false.obs;
  RxBool showAddDialog = false.obs;
  List<ValueModel> values = [];
  List<ValueModel> valuesToDelete = [];
  Map<int, Map<String, TextEditingController>> valuesTextEditingController = {};
  Map<int, Map<String, Uint8List>> valuesImages = {};
  TextEditingController newValueAr = TextEditingController();
  TextEditingController newValueEn = TextEditingController();
  Uint8List? imageAr;
  Uint8List? imageEn;
  AttributeValuesScreenController({required this.attributeModel});
  @override
  void onInit() async {
    await loadValues();
    values.forEach((element) {
      TextEditingController valueAr =
          TextEditingController(text: element.ValueAr);
      TextEditingController valueEn =
          TextEditingController(text: element.ValueEn);
      valueAr.addListener(() {
        showSaveEditsButton();
        update();
      });
      valueEn.addListener(() {
        showSaveEditsButton();
        update();
      });

      valuesTextEditingController[element.Id ?? 0] = {
        "ValueAr": valueAr,
        "ValueEn": valueEn
      };
    });
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

  void chooseImageForNewValue({required String tag}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        switch (tag) {
          case 'HoverImageAr':
            imageAr = uploadFile;
            break;
          case 'HoverImageEn':
            imageEn = uploadFile;
            break;
          default:
        }
        uploadFile;
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
    for (var element in values) {
      visible = element.ValueAr !=
              valuesTextEditingController[element.Id]!["ValueAr"]!
                  .text
                  .trim() ||
          element.ValueEn !=
              valuesTextEditingController[element.Id]!["ValueEn"]!.text.trim();
      if (visible) break;
    }
    // values.forEach((element) {
    //   visible = element.ValueAr !=
    //           valuesTextEditingController[element.Id]!["ValueAr"]!
    //               .text
    //               .trim() ||
    //       element.ValueEn !=
    //           valuesTextEditingController[element.Id]!["ValueEn"]!.text.trim();
    //   print(element.ValueAr);
    //   print(element.ValueEn);
    //   print(valuesTextEditingController[element.Id]!["ValueAr"]!.text);
    //   print(valuesTextEditingController[element.Id]!["ValueEn"]!.text);
    //   print(visible);
    // });
    // print(visible);
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

  FutureOr addTextValueAction() async {
    loadDetails(true);
    update();
    try {
      ResponseModel responseModel = await AddAttributeTextValueApi().callApi(
          attributeModel: attributeModel,
          valueModel: ValueModel(
            ValueAr: newValueAr.text.trim(),
            ValueEn: newValueEn.text.trim(),
          ),
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
            await DeleteAttributeTextValueApi().callApi(
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
        ResponseModel responseModel =
            await EditTextAttributeTextValueApi().callApi(
                attributeModel: attributeModel,
                valueModel: element.copyWith(
                  ValueAr: valuesTextEditingController[element.Id]?['ValueAr']
                      ?.text
                      .trim(),
                  ValueEn: valuesTextEditingController[element.Id]?['ValueEn']
                      ?.text
                      .trim(),
                ),
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
    valuesTextEditingController.clear();
    valuesToDelete.clear();
    onInit();
    showSaveEditsButton();
    loadDetails(false);
    update();
  }
}
