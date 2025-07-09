import 'dart:convert';

import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/order_model.dart';
import 'package:nq_mall_dashboard/models/order_status_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';

import '../../models/response_model.dart';
import '../../shared/api_hundler.dart';
// import 'package:http/http.dart' as http;

class UpdateOrderStatusApi {
  // Future<List<Map<String, dynamic>>>
  Future callApi({
    required OrderModel orderModel,
    required OrderStatusModel orderStatus,
    String? responseNote,
  }) async {
    ApiHundler apiHundler = ApiHundler();
    apiHundler.setEndPoint('/orders/edit');
    apiHundler.setToken(getIt.get<UserModel>().Token!);
    Map<String, dynamic> details = {
      "orderId": orderModel.Id.toString(),
      "orderStatusId": orderStatus.Id.toString(),
      "responseNote": responseNote,
    };
    var response = await apiHundler.put(body: json.encode(details));

    ResponseModel responseModel =
        ResponseModel.fromMap(json.decode(response.body));

    return Future.delayed(Duration.zero, () => responseModel);
  }
}
