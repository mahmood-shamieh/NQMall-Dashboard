// import 'dart:convert';
// import 'dart:io';

// import 'package:care_route/models/check_point_model.dart';
// import 'package:care_route/models/rde_message_model.dart';
// import 'package:care_route/models/response_model.dart';
// import 'package:care_route/models/user_model.dart';
// import 'package:care_route/shared/api_hundler.dart';
// import 'package:http/http.dart' as http;

// class UpdateProfileApi {
//   Future<ResponseModel> callApi(
//       {required UserModel userModel, File? img}) async {
//     ApiHundler apiHundler = ApiHundler();
//     apiHundler.setEndPoint('updateUserDetails');
//     apiHundler.setToken(userModel.token!);
//     http.MultipartFile? multipartFile;
//     if (img != null) {
//       List<int> imageBytes = await img.readAsBytes();

//       multipartFile = await http.MultipartFile.fromPath(
//         'img',
//         img.path,
//       );
//     }
//     Map<String, String> body = {
//       "id": userModel.id!,
//       "token": userModel.token!,
//       "fcm_token": userModel.fcm_token!,
//       "email": userModel.email!,
//       "full_name": userModel.full_name!,
//       "phone_number": userModel.phone_number!,
//       "address": userModel.address!,
//       "role": userModel.role!,
//     };

//     if (userModel.password != null) {
//       body['password'] = userModel.password!;
//     }

//     var response = await apiHundler.postMultiPartDate(
//       files: multipartFile == null ? [] : [multipartFile],
//       body: body,
//     );

//     Map<String, dynamic> data = json.decode(response.body);
//     ResponseModel responseModel = ResponseModel.fromMap(data);

//     return Future.delayed(Duration.zero, () => responseModel);
//   }
// }
