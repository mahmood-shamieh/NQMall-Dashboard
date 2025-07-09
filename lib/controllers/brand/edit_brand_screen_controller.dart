import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/brand/update_brand_api.dart';
import 'package:nq_mall_dashboard/apis/category/update_category_api.dart';
import 'package:nq_mall_dashboard/controllers/brand/brand_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/category/category_screen_controller.dart';
import 'package:nq_mall_dashboard/exception/connection_time_out.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';

import '../../exception/un_defined_problem.dart';
import '../../models/response_model.dart';

class EditBrandScreenController extends GetxController {
  RxBool loading = false.obs;
  // File? image;
  Uint8List? image;
  String? imageName;
  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController descAr = TextEditingController();
  TextEditingController descEn = TextEditingController();
  late BrandModel brandModel;
  EditBrandScreenController({required this.brandModel});
  @override
  void onInit() {
    nameAr.text = brandModel.NameAr ?? '';
    nameEn.text = brandModel.NameEn ?? '';
    descAr.text = brandModel.DescriptionAr ?? '';
    descEn.text = brandModel.DescriptionEn ?? '';
    super.onInit();
  }

  void chooseImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      image = result.files.single.bytes;
      imageName = result.files.single.name;
      update();
    } else {}
  }

  void submit() async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await UpdateBrandApi().callApi(
          brandModel: brandModel.copyWith(
            NameAr: nameAr.text.trim(),
            NameEn: nameEn.text.trim(),
            DescriptionAr: descAr.text.trim(),
            DescriptionEn: descEn.text.trim(),
          ),
          image: image);
      loading(false);
      update();
      if (responseModel.code == 200) {
        Get.back();
        BrandScreenController categoryScreenController =
            Get.find<BrandScreenController>();
        categoryScreenController.onInit();
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }
}
