import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class UpdateCategoryApi {
  Future<ResponseModel> callApi(
      {required CategoryModel categoryModel,
      Uint8List? image,
      String? imageName}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/category/update');
    apiHundler.setToken(getIt.get<UserModel>().Token!);

    http.MultipartFile? tempFile;
    if (image != null) {
      tempFile = await http.MultipartFile.fromBytes(
        'image',
        image,
        filename: imageName,
      );
    }

    var response = await apiHundler.postMultiPartDate(
        body: categoryModel.toMap().processMap(),
        files: tempFile == null ? null : [tempFile],
        method: "PUT");

    // print(response.runtimeType);
    // print('aaaaa');

    Map<String, dynamic> data = json.decode(response.body);
    // print(data);
    ResponseModel responseModel = ResponseModel.fromMap(data);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
