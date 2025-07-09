import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/category/update_category_api.dart';
import 'package:nq_mall_dashboard/controllers/category/category_screen_controller.dart';
import 'package:nq_mall_dashboard/exception/connection_time_out.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';

import '../../exception/un_defined_problem.dart';
import '../../models/response_model.dart';

class EditCategoryScreenController extends GetxController {
  RxBool loading = false.obs;
  // File? image;
  Uint8List? imageBytes;
  String? imageName;

  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController descAr = TextEditingController();
  TextEditingController descEn = TextEditingController();
  late CategoryModel categoryModel;
  EditCategoryScreenController({required this.categoryModel});
  @override
  void onInit() {
    nameAr.text = categoryModel.NameAr ?? '';
    nameEn.text = categoryModel.NameEn ?? '';
    descAr.text = categoryModel.DescriptionAr ?? '';
    descEn.text = categoryModel.DescriptionEn ?? '';
    super.onInit();
  }

  void chooseImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      // if (kIsWeb) {
      imageBytes = result.files.single.bytes;
      imageName = result.files.single.name;
      // image = null; // no File on web
      // } else {
      //   image = File(result.files.single.path!);
      //   imageBytes = null;
      //   imageName = null;
      // }
      update();
    }
    // if (result != null) {
    //   image = File(result.files.single.path!);
    //   update();
    // } else {}
  }

  void submit() async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await UpdateCategoryApi().callApi(
          categoryModel: categoryModel.copyWith(
            NameAr: nameAr.text.trim(),
            NameEn: nameEn.text.trim(),
            DescriptionAr: descAr.text.trim(),
            DescriptionEn: descEn.text.trim(),
          ),
          image: imageBytes,
          imageName: imageName);
      loading(false);
      update();
      if (responseModel.code == 200) {
        Get.back();
        CategoryScreenController categoryScreenController =
            Get.find<CategoryScreenController>();
        categoryScreenController.onInit();
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }
}
