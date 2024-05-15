import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/attribute_content_model.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

import '../../shared/fike_utility.dart';
import "package:dio/dio.dart" as dioPackage;

// import 'package:http/http.dart' as http;

class AddImageAttributeApi {
  Future<ResponseModel> callApi({
    required ProductModel productModel,
    required AttributeModel attributeModel,
    required List<Uint8List> itemsAr,
    required List<Uint8List> itemsEn,
    required List<Uint8List> mediaAr,
    required List<Uint8List> mediaEn,
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/attributes/imgCreate');
    dioPackage.FormData data = dioPackage.FormData.fromMap({
      "NameAr": attributeModel.NameAr,
      "NameEn": attributeModel.NameEn,
      "productId": productModel.Id,
      "IsActive": true,
      "Type": "images",
      "itemsAr[]": itemsAr
          .map(
            (e) => dioPackage.MultipartFile.fromBytes(
              e,
              filename: DateTime.now().toString() +
                  FileUtility.checkFiletype(file: e),
            ),
          )
          .toList(),
      "mediaAr[]": mediaAr
          .map(
            (e) => dioPackage.MultipartFile.fromBytes(
              e,
              filename: DateTime.now().toString() +
                  FileUtility.checkFiletype(file: e),
            ),
          )
          .toList(),
      "itemsEn[]": itemsEn
          .map(
            (e) => dioPackage.MultipartFile.fromBytes(
              e,
              filename: DateTime.now().toString() +
                  FileUtility.checkFiletype(file: e),
            ),
          )
          .toList(),
      "mediaEn[]": mediaEn
          .map(
            (e) => dioPackage.MultipartFile.fromBytes(
              e,
              filename: DateTime.now().toString() +
                  FileUtility.checkFiletype(file: e),
            ),
          )
          .toList(),
    });
    // apiHundler.setToken(userModel.token!);

    var response = await apiHundler.postMultiPartDate1(body: data);

    // print(response.runtimeType);

    ResponseModel responseModel = ResponseModel.fromMap(response);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
