import 'dart:convert';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
// import 'package:http/http.dart' as http;

class GetAllProductsApi {
  // Future<List<Map<String, dynamic>>>
  Future callApi({Map<String, String>? details}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/products/get');
    // apiHundler.setToken(userModel.token!);
    var response = await apiHundler.post(body: json.encode(details));

    // List<Map<String, dynamic>> data = (json.decode(response.body) as List)
    //     .map((element) => Map<String, dynamic>.from(element))
    //     .toList();

    ResponseModel responseModel =
        ResponseModel.fromMap(json.decode(response.body));

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
