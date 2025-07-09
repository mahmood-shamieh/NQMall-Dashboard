import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nq_mall_dashboard/apis/orders/get_all_order_statuses_api.dart';
import 'package:nq_mall_dashboard/apis/orders/update_order_status_api.dart';
import 'package:nq_mall_dashboard/controllers/order/order_screen_controller.dart';
import 'package:nq_mall_dashboard/models/order_model.dart';
import 'package:nq_mall_dashboard/models/order_status_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

class EditOrderScreenController extends GetxController {
  RxBool loading = false.obs;
  late OrderModel orderModel;
  List<OrderStatusModel>? orderStatuses;
  TextEditingController orderStatusSearchController = TextEditingController();
  TextEditingController responseNotesController = TextEditingController();
  Rx<OrderStatusModel?> selectedOrderStatus = Rx<OrderStatusModel?>(null);
  EditOrderScreenController({required this.orderModel});
  @override
  void onInit() async {
    super.onInit();
    await getAllOrderStatuses();
    setSelectedOrderStatus();
    setResponseNotes();
  }

  void chooseOrderStatus({required OrderStatusModel orderStatus}) {
    selectedOrderStatus.value = orderStatus;
    update();
  }

  Future getAllOrderStatuses() async {
    loading(true);
    update();
    ResponseModel response = await GetAllOrderStatusesApi().callApi();
    // print(response.data);
    orderStatuses = response.data!
        .map<OrderStatusModel>(
          (e) => OrderStatusModel.fromMap(e),
        )
        .toList();

    loading(false);
    update();
  }

  Future updateOrderStatus() async {
    loading(true);
    update();
    ResponseModel response = await UpdateOrderStatusApi().callApi(
      orderModel: orderModel,
      orderStatus: selectedOrderStatus.value!,
      responseNote: responseNotesController.text.trim(),
    );
    if (response.code == 200) {
      Get.back();
      OrdersScreenController ordersScreenController = Get.find();
      ordersScreenController.refreshStatusAction();
    }

    loading(false);
    update();
  }

  void setSelectedOrderStatus() {
    OrderStatusModel? currentOrderStatus = orderStatuses?.firstWhere(
      (e) => e.Id == orderModel.orderStatusId,
    );
    selectedOrderStatus.value = currentOrderStatus!;

    update();
  }

  void setResponseNotes() {
    if (orderModel.ResponseNote != null &&
        orderModel.ResponseNote!.isNotEmpty) {
      responseNotesController.text = orderModel.ResponseNote!;
    }
  }
}
