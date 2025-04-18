import 'dart:convert';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
// import 'package:http/http.dart' as http;

class GetAllBrands {
  // Future<List<Map<String, dynamic>>>
  Future callApi({Map<String, String>? details}) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/brands/get');
    var response = await apiHundler.post(body: json.encode(details));
    ResponseModel responseModel =
        ResponseModel.fromMap(json.decode(response.body));

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
