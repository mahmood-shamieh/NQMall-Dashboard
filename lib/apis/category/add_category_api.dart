import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

import '../../shared/file_utility.dart';

// import 'package:http/http.dart' as http;

class AddCategoryApi {
  Future<ResponseModel> callApi(
      {required CategoryModel categoryModel, required Uint8List image}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/category/create');
    // apiHundler.setToken(userModel.token!);

    // http.MultipartFile tempFile =
    //     await http.MultipartFile.fromPath('image', image.path);
    http.MultipartFile tempFile = await http.MultipartFile.fromBytes(
      'image',
      image,
      filename:
          DateTime.now().toString() + FileUtility.checkFiletype(file: image),
    );
    // Map<String, String> map = {
    //   "NameAr": categoryModel.NameAr ?? '',
    //   "NameEn": categoryModel.NameEn ?? '',
    //   "DescriptionAr": categoryModel.DescriptionAr ?? '',
    //   "DescriptionEn": categoryModel.NameEn ?? ''
    // };
    var response = await apiHundler.postMultiPartDate(
        body: categoryModel.toMap().processMap(), files: [tempFile]);

    // print(response.runtimeType);

    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    ResponseModel responseModel = ResponseModel.fromMap(data);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
