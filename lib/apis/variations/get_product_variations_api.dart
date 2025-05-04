import 'dart:convert';

import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/api_hundler.dart';
// import 'package:http/http.dart' as http;

class GetProductVariationsApi {
  Future<ResponseModel> callApi({required ProductModel productModel}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler
        .setEndPoint('/variations/getProductVariation/${productModel.Id}');
    apiHundler.setToken(getIt.get<UserModel>().Token!);
    var response = await apiHundler.get();
    Map<String, dynamic> data = json.decode(response.body);
    ResponseModel responseModel = ResponseModel.fromMap(data);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
