// import 'dart:convert';

// import 'package:care_route/models/response_model.dart';
// import 'package:care_route/models/user_model.dart';
// import 'package:care_route/shared/api_hundler.dart';
// // import 'package:http/http.dart' as http;

// class ScanQrMedApi {
//   Future<ResponseModel> callApi(
//       {required String orderId, required UserModel userModel}) async {
//     ApiHundler apiHundler = ApiHundler();
//     apiHundler.setEndPoint('trackOrder');
//     apiHundler.setToken(userModel.token!);
//     var response =
//         await apiHundler.post(body: json.encode({'order_number': orderId}));

//     Map<String, dynamic> data = json.decode(response.body);
//     ResponseModel responseModel = ResponseModel.fromMap(data);

//     return Future.delayed(Duration.zero, () => responseModel);
//   }
// }
