import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';
import "package:dio/dio.dart" as dioPackage;

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

import '../../shared/fike_utility.dart';

// import 'package:http/http.dart' as http;

class AddTextAttributeApi {
  Future<ResponseModel> callApi({
    required ProductModel productModel,
    required AttributeModel attributeModel,
    required List<String> itemsAr,
    required List<String> itemsEn,
    required List<Uint8List> mediaAr,
    required List<Uint8List> mediaEn,
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/attributes/create');
    // apiHundler.setToken(userModel.token!);

    List<dioPackage.MultipartFile> filesAr = [];
    List<dioPackage.MultipartFile> filesEn = [];
    for (Uint8List element in mediaAr) {
      filesAr.add(dioPackage.MultipartFile.fromBytes(
        element,
        filename: DateTime.now().toString() +
            FileUtility.checkFiletype(file: element),
      ));
    }
    for (Uint8List element in mediaAr) {
      filesEn.add(dioPackage.MultipartFile.fromBytes(
        element,
        filename: DateTime.now().toString() +
            FileUtility.checkFiletype(file: element),
      ));
    }

    dioPackage.FormData data = dioPackage.FormData.fromMap(
      {
        "NameAr": attributeModel.NameAr ?? '',
        "NameEn": attributeModel.NameEn ?? '',
        "productId": productModel.Id.toString(),
        "Type": "items",
        "IsActive": true.toString(),
        "itemsAr[]": itemsAr,
        "itemsEn[]": itemsEn,
        "mediaAr[]": filesAr,
        "mediaEn[]": filesEn,
      },
    );
    var response = await apiHundler.postMultiPartDate1(
      body: data,
    );

    // print(response.runtimeType);

    // Map<String, dynamic> data = json.decode(response.body);

    ResponseModel responseModel = ResponseModel.fromMap(response);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
