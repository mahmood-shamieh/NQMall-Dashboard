import 'dart:convert';

import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
// import 'package:http/http.dart' as http;

class GetAllCategoriesNoPaginationApi {
  // Future<List<Map<String, dynamic>>>
  Future callApi() async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/category/getAll');
    apiHundler.setToken(getIt.get<UserModel>().Token!);

    // apiHundler.setToken(userModel.token!);
    var response = await apiHundler.get();

    // List<Map<String, dynamic>> data = (json.decode(response.body) as List)
    //     .map((element) => Map<String, dynamic>.from(element))
    //     .toList();

    ResponseModel responseModel =
        ResponseModel.fromMap(json.decode(response.body));

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
