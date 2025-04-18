import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/value_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';
import "package:dio/dio.dart" as dioPackage;

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

import '../../shared/file_utility.dart';

// import 'package:http/http.dart' as http;

class AddAttributeImageValueApi {
  Future<ResponseModel> callApi({
    required AttributeModel attributeModel,
    Uint8List? hoverImageAr,
    Uint8List? hoverImageEn,
    Uint8List? imageAr,
    Uint8List? imageEn,
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/attributesValues/create/img');
    // apiHundler.setToken(userModel.token!);

    // List<dioPackage.MultipartFile> filesAr = [];
    // List<dioPackage.MultipartFile> filesEn = [];
    // for (Uint8List element in mediaAr) {
    // filesAr.add(dioPackage.MultipartFile.fromBytes(
    //   element,
    //   filename: DateTime.now().toString() +
    //       FileUtility.checkFiletype(file: element),
    // ));
    // }
    // for (Uint8List element in mediaAr) {
    //   filesEn.add(dioPackage.MultipartFile.fromBytes(
    //     element,
    //     filename: DateTime.now().toString() +
    //         FileUtility.checkFiletype(file: element),
    //   ));
    // }

    dioPackage.FormData data = dioPackage.FormData.fromMap({
      "attributeId": attributeModel.Id ?? '',
      "IsActive": true.toString(),
    });
    if (hoverImageAr != null) {
      data.files.add(
        MapEntry(
          'HoverImageAr',
          dioPackage.MultipartFile.fromBytes(
            hoverImageAr,
            filename: DateTime.now().toString() +
                FileUtility.checkFiletype(file: hoverImageAr),
          ),
        ),
      );
    }
   
    if (hoverImageEn != null) {
      data.files.add(
        MapEntry(
          'HoverImageEn',
          dioPackage.MultipartFile.fromBytes(
            hoverImageEn,
            filename: DateTime.now().toString() +
                FileUtility.checkFiletype(file: hoverImageEn),
          ),
        ),
      );
    }
    if (imageAr != null) {
      data.files.add(
        MapEntry(
          'ValueAr',
          dioPackage.MultipartFile.fromBytes(
            imageAr,
            filename: DateTime.now().toString() +
                FileUtility.checkFiletype(file: imageAr),
          ),
        ),
      );
    }
    if (imageEn != null) {
      data.files.add(
        MapEntry(
          'ValueEn',
          dioPackage.MultipartFile.fromBytes(
            imageEn,
            filename: DateTime.now().toString() +
                FileUtility.checkFiletype(file: imageEn),
          ),
        ),
      );
    }
    var response = await apiHundler.postMultiPartDate1(
      body: data,
    );

    // Map<String, dynamic> encodedResponse = json.decode(response.body);

    ResponseModel responseModel = ResponseModel.fromMap(response);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
