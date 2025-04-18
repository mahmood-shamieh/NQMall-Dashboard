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

import '../../shared/file_utility.dart';

// import 'package:http/http.dart' as http;

class PricingProductApi {
  Future<ResponseModel> callApi({
    required List<Map> variationsWithValues,
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/variationsLinks/create');
    // apiHundler.setToken(userModel.token!);

    var response =
        await apiHundler.post(body: json.encode(variationsWithValues));

    // print(response.runtimeType);

    Map<String, dynamic> data = json.decode(response.body);

    ResponseModel responseModel = ResponseModel.fromMap(data);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
