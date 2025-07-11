import 'dart:convert';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/map_utility.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class UpdateProductApi {
  Future<ResponseModel> callApi({
    required ProductModel productModel,
    /* required Uint8List image */
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/products/update');
    apiHundler.setToken(getIt.get<UserModel>().Token!);
    Map<String, String> request = {
      "Id": productModel.Id.toString(),
      "NameAr": productModel.NameAr.toString(),
      "NameEn": productModel.NameEn.toString(),
      "DescriptionAr": productModel.DescriptionAr.toString(),
      "DescriptionEn": productModel.DescriptionEn.toString(),
      "Price": productModel.Price.toString(),
      "SalePrice": productModel.SalePrice.toString(),
    };

    // http.MultipartFile tempFile =
    //     await http.MultipartFile.fromPath('image', image.path);
    // http.MultipartFile tempFile = http.MultipartFile.fromBytes(
    //   'image',
    //   image,
    //   filename: DateTime.now().toString(),
    // );
    // Map<String, String> map = {
    //   "NameAr": categoryModel.NameAr ?? '',
    //   "NameEn": categoryModel.NameEn ?? '',
    //   "DescriptionAr": categoryModel.DescriptionAr ?? '',
    //   "DescriptionEn": categoryModel.NameEn ?? '',
    //   "Price": categoryModel.NameEn ?? '',
    //   "SalePrice": categoryModel.NameEn ?? '',
    //   "DetailsAr": categoryModel.NameEn ?? '',
    //   "DetailsEn": categoryModel.NameEn ?? '',
    //   "IsActive": categoryModel.NameEn ?? '',
    //   "userId": categoryModel.NameEn ?? '',
    //   "categoryId": categoryModel.NameEn ?? '',
    //   "brandId": categoryModel.NameEn ?? '',
    // };
    var response = await apiHundler.post(
      body: json.encode(request),
    );

    // print(response.runtimeType);

    Map<String, dynamic> data = json.decode(response.body);
    ResponseModel responseModel = ResponseModel.fromMap(data);

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
