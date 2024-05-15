import 'dart:typed_data';

import 'package:nq_mall_dashboard/apis/brand/add_brand_api.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nq_mall_dashboard/apis/category/add_category_api.dart';
import 'package:nq_mall_dashboard/controllers/category/category_screen_controller.dart';
import 'package:nq_mall_dashboard/exception/connection_time_out.dart';
import 'package:nq_mall_dashboard/exception/un_defined_problem.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
// import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

class AddBrandScreenController extends GetxController {
  RxBool loading = false.obs;

  Uint8List? imageBytes;
  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController descAr = TextEditingController();
  TextEditingController descEn = TextEditingController();
  TextEditingController url = TextEditingController();
  void chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      // FileReader reader = html.FileReader();
      // PlatformFile file1 = result.files.single;
      Uint8List uploadFile = result.files.single.bytes!;
      imageBytes = uploadFile;
      String filename = path.basename(result.files.single.name);
      update();
    } else {}
  }

  void submit() async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await AddBrandApi().callApi(
          brandModel: BrandModel(
            NameAr: nameAr.text.trim(),
            NameEn: nameEn.text.trim(),
            DescriptionAr: descAr.text.trim(),
            DescriptionEn: descEn.text.trim(),
            WebSiteUrl: url.text.trim(),
          ),
          image: imageBytes!);
      loading(false);
      update();
      if (responseModel.code == 200 || responseModel.code == 201) {
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
