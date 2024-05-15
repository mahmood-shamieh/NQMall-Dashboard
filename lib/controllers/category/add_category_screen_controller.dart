import 'dart:typed_data';

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

class AddCategoryScreenController extends GetxController {
  RxBool loading = false.obs;
  // io.File? image;
  Uint8List? imageBytes;
  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController descAr = TextEditingController();
  TextEditingController descEn = TextEditingController();
  void chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      // FileReader reader = html.FileReader();
      Uint8List uploadFile = result.files.single.bytes!;
      imageBytes = uploadFile;
      String filename = path.basename(result.files.single.name);
      // image = io.File('');
      update();
      // html.Blob blob = html.Blob([uploadFile]);
      // String url = html.Url.createObjectUrlFromBlob(blob);

      // reader.readAsArrayBuffer(html.Blob([uploadFile], 'image/jpeg'));
      // reader.onLoadEnd.listen((event) async {
      // if (reader.readyState == html.FileReader.DONE) {

      // io.File file = io.File.fromRawPath(uploadFile);
      // html.window.localStorage[filename] = uploadFile.toString();

      //     // Update the UI or perform other operations
      // update();
      // }
      // });

      // Uint8List uploadfile = result.files.single.bytes!;
      // String filename = path.basename(result.files.single.name);
      // image = File.fromRawPath(uploadfile);
      // final tempDir = await getTemporaryDirectory();
      // File file = await File('${tempDir.path}/$filename').create();
      // file.writeAsBytesSync(uploadfile);
      // image = file;

      // image = File(result.files.single.path!);
      update();
    } else {}
  }

  void submit() async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await AddCategoryApi().callApi(
          categoryModel: CategoryModel(
            NameAr: nameAr.text.trim(),
            NameEn: nameEn.text.trim(),
            DescriptionAr: descAr.text.trim(),
            DescriptionEn: descEn.text.trim(),
          ),
          image: imageBytes!);
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
// image = result.files.single.bytes;
      // Uint8List fileBytes = result.files.single.bytes!;
      // String? fileName = result.files.single.name;

      // Get the temporary directory path
      // Directory tempDir = await getTemporaryDirectory();
      // print(tempDir);
      // String tempPath = tempDir.path;

      // Create a temporary file
      // File tempFile = File('$tempPath/$fileName');

      // Write the bytes to the temporary file
      // await tempFile.writeAsBytes(fileBytes!);
      // image = tempFile;

      // String? fileName = result.files.single.name;
      // File imageFile = html.File([fileBytes], fileName, {'type': 'image/jpeg'});
