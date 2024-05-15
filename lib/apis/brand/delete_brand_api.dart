import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class DeleteBrandApi {
  Future<ResponseModel> callApi({required BrandModel brandModel}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/brands/delete/${brandModel.Id}');
    // apiHundler.setToken(userModel.token!);
    var response = await apiHundler.delete();
    Map<String, dynamic> data = json.decode(response.body);
    ResponseModel responseModel = ResponseModel.fromMap(data);
    return Future.delayed(Duration.zero, () => responseModel);
  }
}
