import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';
import "package:dio/dio.dart" as dioPackage;

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

import '../../shared/file_utility.dart';

// import 'package:http/http.dart' as http;

class EditTextAttributeApi {
  Future<ResponseModel> callApi({
    required ProductModel productModel,
    required AttributeModel attributeModel,
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/attributes/edit');
    apiHundler.setToken(getIt.get<UserModel>().Token!);

    // apiHundler.setToken(userModel.token!);

    // List<dioPackage.MultipartFile> filesAr = [];
    // List<dioPackage.MultipartFile> filesEn = [];
    // for (Uint8List element in mediaAr) {
    //   filesAr.add(dioPackage.MultipartFile.fromBytes(
    //     element,
    //     filename: DateTime.now().toString() +
    //         FileUtility.checkFiletype(file: element),
    //   ));
    // }
    // for (Uint8List element in mediaAr) {
    //   filesEn.add(dioPackage.MultipartFile.fromBytes(
    //     element,
    //     filename: DateTime.now().toString() +
    //         FileUtility.checkFiletype(file: element),
    //   ));
    // }

    // dioPackage.FormData data = dioPackage.FormData.fromMap(
    // );
    Map<String, String> data = {
      "NameAr": attributeModel.NameAr ?? '',
      "NameEn": attributeModel.NameEn ?? '',
      "productId": productModel.Id.toString(),
      "Type": attributeModel.Type ?? 'list',
      "IsActive": true.toString(),
      "Id": attributeModel.Id.toString(),
    };
    var response = await apiHundler.post(
      body: json.encode(data),
    );

    Map<String, dynamic> encodedResponse = json.decode(response.body);
    // print(response.body);
    ResponseModel responseModel = ResponseModel.fromMap(encodedResponse);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
