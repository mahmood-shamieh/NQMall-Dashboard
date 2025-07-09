import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/file_utility.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class AddMediaApi {
  Future<ResponseModel> callApi(
      {required ProductModel productModel,
      required List<Uint8List> images}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/media/create');
    apiHundler.setToken(getIt.get<UserModel>().Token!);

    // apiHundler.setToken(userModel.token!);

    // http.MultipartFile tempFile =
    //     await http.MultipartFile.fromPath('image', image.path);
    List<http.MultipartFile> files = [];
    int index = 0;
    for (Uint8List element in images) {
      index += 1;
      files.add(
        http.MultipartFile.fromBytes(
          'images[]',
          element,
          filename: index.toString() +
              DateTime.now().toString() +
              FileUtility.checkFiletype(file: element),
        ),
      );
    }

    // Map<String, String> map = {
    //   "NameAr": categoryModel.NameAr ?? '',
    //   "NameEn": categoryModel.NameEn ?? '',
    //   "DescriptionAr": categoryModel.DescriptionAr ?? '',
    //   "DescriptionEn": categoryModel.NameEn ?? ''
    // };
    var response = await apiHundler.postMultiPartDate(
        body: {"productId": productModel.Id}.processMap(), files: files);

    // print(response.runtimeType);

    Map<String, dynamic> data = json.decode(response.body);

    ResponseModel responseModel = ResponseModel.fromMap(data);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
