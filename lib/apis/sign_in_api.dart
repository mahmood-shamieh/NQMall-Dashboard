// import 'dart:convert';

// import 'package:care_route/models/response_model.dart';
// import 'package:care_route/shared/api_hundler.dart';
// // import 'package:http/http.dart' as http;

// class SignInApi {
//   Future<ResponseModel> callApi(
//       {required String username, required String password}) async {
//     ApiHundler apiHundler = ApiHundler();
//     apiHundler.setEndPoint('signIn');
//     var response = await apiHundler.post(
//         body: json.encode({'username': username, 'password': password}));
//     Map<String, dynamic> data = json.decode(response.body);
//     ResponseModel responseModel = ResponseModel.fromMap(data);

//     return Future.delayed(Duration.zero, () => responseModel);
//   }
// }
